import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_train_app/helper/convert_index_to_seat.dart';
import 'package:flutter_train_app/model/train_booking_model.dart';
import 'package:flutter_train_app/page/train_reservation_detail/widget/reservation_action_button.dart';
import 'package:flutter_train_app/value_notifier/train_reservation_value_notifier.dart';
import 'package:go_router/go_router.dart';

class TrainReservationDetailPage extends StatelessWidget {
  const TrainReservationDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('예매 내역'), centerTitle: true),
      body: SafeArea(
        child: ValueListenableBuilder<List<TrainReservationModel>>(
          valueListenable: TrainReservationValueNotifier.trainReservationList,
          builder: (context, items, child) {
            if (items.isEmpty) {
              return Center(child: Text("예매한 티켓이 없습니다."));
            }

            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final reservation = items[index];

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 8, spreadRadius: 2, offset: Offset(0, 4))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${reservation.startingStation} → ${reservation.destinationStation}",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),

                            Text(
                              "좌석: ${convertIndexToSeat(reservation.seatModel.seatRow, reservation.seatModel.seatColumn)}",

                              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.purple[100],

                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ReservationActionButton(
                              str: "예매 변경",
                              onTap: () {
                                showChangeDialog(context, reservation, index);
                              },
                            ),

                            Container(height: 30, width: 2, color: Colors.white),
                            ReservationActionButton(
                              str: "예매 취소",
                              onTap: () {
                                showRemoveDialog(context, reservation, index);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> showRemoveDialog(BuildContext context, TrainReservationModel reservation, int index) {
    return showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("예매를 취소 하시겠습니까??"),
          content: Text(
            "${reservation.startingStation} → ${reservation.destinationStation} , 좌석: ${convertIndexToSeat(reservation.seatModel.seatRow, reservation.seatModel.seatColumn)}",
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
                TrainReservationValueNotifier.removeReservation(index);
              },
              child: Text("확인", style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> showChangeDialog(BuildContext context, TrainReservationModel reservation, int index) {
    return showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("예매를 변경 하시겠습니까??"),
          content: Text(
            "${reservation.startingStation} → ${reservation.destinationStation} , 좌석: ${convertIndexToSeat(reservation.seatModel.seatRow, reservation.seatModel.seatColumn)}",
          ),
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
                context.push(
                  '/seat',
                  extra: {
                    'startingStation': reservation.startingStation,
                    'destinationStation': reservation.destinationStation,
                    'existingReservation': reservation,
                  },
                );
              },
              child: Text("확인", style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }
}
