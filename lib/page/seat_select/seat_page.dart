import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_train_app/helper/convert_index_to_seat.dart';
import 'package:flutter_train_app/model/seat_model.dart';
import 'package:flutter_train_app/model/train_booking_model.dart';
import 'package:flutter_train_app/page/seat_select/widget/seat_color_description.dart';
import 'package:flutter_train_app/page/seat_select/widget/reservated_seat_square.dart';
import 'package:flutter_train_app/page/seat_select/widget/seat_square.dart';
import 'package:flutter_train_app/page/seat_select/widget/station_row.dart';
import 'package:flutter_train_app/page/seat_select/widget/text_square.dart';
import 'package:flutter_train_app/value_notifier/train_reservation_value_notifier.dart';
import 'package:go_router/go_router.dart';

class SeatPage extends StatefulWidget {
  final String startingStation;
  final String destinationStation;
  final TrainReservationModel? existingReservation;

  const SeatPage({super.key, required this.startingStation, required this.destinationStation, this.existingReservation});

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  String? seatColumn;
  String? seatRow;

  @override
  Widget build(BuildContext context) {
    bool isEditMode = widget.existingReservation != null;

    return Scaffold(
      appBar: appbar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StationRow(startingStation: widget.startingStation, destinationStation: widget.destinationStation),
            SeatColorDescription(),
            totalSeat(),
            reservationButton(context, isEditMode),
          ],
        ),
      ),
    );
  }

  AppBar appbar() {
    return AppBar(title: Text('좌석 선택'), centerTitle: true, backgroundColor: Colors.transparent, scrolledUnderElevation: 0);
  }

  Expanded totalSeat() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: getColumnList()),
            SizedBox(
              width: 250,
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 5,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: List.generate(100, (index) {
                  if (TrainReservationValueNotifier.trainReservationList.value.isNotEmpty) {
                    String tempSeatRow = (index ~/ 5).toString();
                    String tempSeatColumn = (index % 5).toString();

                    bool isReserved = TrainReservationValueNotifier.isReservationExist(
                      TrainReservationModel(
                        startingStation: widget.startingStation,
                        destinationStation: widget.destinationStation,
                        seatModel: SeatModel(seatRow: tempSeatRow, seatColumn: tempSeatColumn),
                      ),
                    );

                    if (isReserved) {
                      return ReservatedSeatSquare();
                    }
                  }

                  if ((index - 2) % 5 == 0) {
                    return TextSquare(text: "${index ~/ 5 + 1}");
                  }

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (seatRow == (index ~/ 5).toString() && seatColumn == (index % 5).toString()) {
                          seatRow = null;
                          seatColumn == null;
                        } else {
                          seatRow = (index ~/ 5).toString();
                          seatColumn = (index % 5).toString();
                        }
                      });
                    },
                    child: SeatSquare(
                      color:
                          (seatRow != null && seatColumn != null && index == int.parse(seatRow!) * 5 + int.parse(seatColumn!))
                              ? Colors.purple
                              : Colors.grey[300]!,
                      size: 50,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox reservationButton(BuildContext context, isEditMode) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (seatColumn != null && seatRow != null) {
            showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: Text(isEditMode ? "변경 하시겠습니까?" : "예매 하시겠습니까??"),
                  content: Text("좌석: ${convertIndexToSeat(seatRow!, seatColumn!)}"),
                  actions: [
                    CupertinoDialogAction(
                      child: Text("취소", style: TextStyle(color: Colors.red)),
                      onPressed: () {
                        context.pop();
                      },
                    ),
                    CupertinoDialogAction(
                      onPressed: () {
                        context.pop();
                        context.pop();

                        if (isEditMode) {
                          TrainReservationValueNotifier.updateReservation(
                            widget.existingReservation!,
                            TrainReservationModel(
                              startingStation: widget.existingReservation!.startingStation,
                              destinationStation: widget.existingReservation!.destinationStation,
                              seatModel: SeatModel(seatRow: seatRow!, seatColumn: seatColumn!),
                            ),
                          );
                        } else {
                          TrainReservationValueNotifier.addReservation(
                            TrainReservationModel(
                              startingStation: widget.startingStation,
                              destinationStation: widget.destinationStation,
                              seatModel: SeatModel(seatRow: seatRow!, seatColumn: seatColumn!),
                            ),
                          );
                        }
                      },
                      child: Text("확인", style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                );
              },
            );
          }
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, //change background color of button
          backgroundColor: Colors.purple,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        child: Text(isEditMode ? '변경 하기' : '예매 하기'),
      ),
    );
  }

  List<Widget> getColumnList() {
    List<String> columnList = ['A', 'B', 'C', 'D'];
    List<Widget> widgetList = [];

    for (var i = 0; i < columnList.length; i++) {
      widgetList.add(Padding(padding: EdgeInsets.symmetric(horizontal: 2), child: TextSquare(text: columnList[i])));
    }

    widgetList.insert(2, Padding(padding: EdgeInsets.symmetric(horizontal: 2), child: SizedBox(width: 50, height: 50)));
    return widgetList;
  }
}
