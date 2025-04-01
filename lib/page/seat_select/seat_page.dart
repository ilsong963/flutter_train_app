import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_train_app/helper/convert_index_to_seat.dart';
import 'package:flutter_train_app/model/seat_model.dart';
import 'package:flutter_train_app/model/train_booking_model.dart';
import 'package:flutter_train_app/value_notifier/train_reservation_value_notifier.dart';
import 'package:go_router/go_router.dart';

class SeatPage extends StatefulWidget {
  final String startingStation;
  final String destinationStation;
  final TrainReservationModel? existingReservation;

  const SeatPage({
    super.key,
    required this.startingStation,
    required this.destinationStation,
    this.existingReservation,
  });

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
            stationRow(),
            seatColorDescription(),
            totalSeat(),
            reservationButton(context, isEditMode),
          ],
        ),
      ),
    );
  }

  AppBar appbar() {
    return AppBar(
      title: Text('좌석 선택'),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
    );
  }

  Expanded totalSeat() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: getColumnList(),
            ),
            SizedBox(
              width: 250,
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 5,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: List.generate(100, (index) {
                  if (TrainReservationValueNotifier
                      .trainReservationList
                      .value
                      .isNotEmpty) {
                    String tempSeatRow = (index ~/ 5).toString();
                    String tempSeatColumn = (index % 5).toString();

                    bool isReserved =
                        TrainReservationValueNotifier.isReservationExist(
                          TrainReservationModel(
                            startingStation: widget.startingStation,
                            destinationStation: widget.destinationStation,
                            seatModel: SeatModel(
                              seatRow: tempSeatRow,
                              seatColumn: tempSeatColumn,
                            ),
                          ),
                        );

                    if (isReserved) {
                      return reservatedSeatSquare();
                    }
                  }

                  if ((index - 2) % 5 == 0) {
                    return textSquare("${index ~/ 5 + 1}");
                  }

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (seatRow == (index ~/ 5).toString() &&
                            seatColumn == (index % 5).toString()) {
                          seatRow = null;
                          seatColumn == null;
                        } else {
                          seatRow = (index ~/ 5).toString();
                          seatColumn = (index % 5).toString();
                        }
                      });
                    },
                    child: seatSquare(
                      50,
                      (seatRow != null &&
                              seatColumn != null &&
                              index ==
                                  int.parse(seatRow!) * 5 +
                                      int.parse(seatColumn!))
                          ? Colors.purple
                          : Colors.grey[300]!,
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
                  content: Text(
                    "좌석: ${convertIndexToSeat(seatRow!, seatColumn!)}",
                  ),
                  actions: [
                    CupertinoDialogAction(
                      child: Text("취소", style: TextStyle(color: Colors.red)),
                      onPressed: () {
                        Navigator.of(context).pop();
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
                              startingStation:
                                  widget.existingReservation!.startingStation,
                              destinationStation:
                                  widget
                                      .existingReservation!
                                      .destinationStation,
                              seatModel: SeatModel(
                                seatRow: seatRow!,
                                seatColumn: seatColumn!,
                              ),
                            ),
                          );
                        } else {
                          TrainReservationValueNotifier.addReservation(
                            TrainReservationModel(
                              startingStation: widget.startingStation,
                              destinationStation: widget.destinationStation,
                              seatModel: SeatModel(
                                seatRow: seatRow!,
                                seatColumn: seatColumn!,
                              ),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        child: Text(isEditMode ? '변경 하기' : '예매 하기'),
      ),
    );
  }

  Padding seatColorDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          seatSquare(24, Colors.purple),
          SizedBox(width: 4),
          Text('선택됨'),
          SizedBox(width: 20),
          seatSquare(24, Colors.grey[300]!),
          SizedBox(width: 4),
          Text('선택안됨'),
        ],
      ),
    );
  }

  Row stationRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              widget.startingStation,
              style: TextStyle(
                color: Colors.purple,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Icon(Icons.arrow_circle_right_outlined, size: 30),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              widget.destinationStation,
              style: TextStyle(
                color: Colors.purple,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> getColumnList() {
    List columnList = ['A', 'B', 'C', 'D'];
    List<Widget> widgetList = [];

    for (var i = 0; i < columnList.length; i++) {
      widgetList.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: textSquare(columnList[i]),
        ),
      );
    }

    widgetList.insert(
      2,
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 2),
        child: SizedBox(width: 50, height: 50),
      ),
    );
    return widgetList;
  }

  Widget seatSquare(double size, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      width: size,
      height: size,
    );
  }

  Widget reservatedSeatSquare() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[600],
        borderRadius: BorderRadius.circular(8),
      ),
      width: 50,
      height: 50,
      child: Center(
        child: Text(
          "X",
          style: TextStyle(fontSize: 20, color: Colors.grey[400]),
        ),
      ),
    );
  }

  Widget textSquare(String text) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      width: 50,
      height: 50,
      child: Center(
        child: Text(text.toString(), style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
