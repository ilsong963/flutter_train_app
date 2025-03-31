import 'package:flutter/material.dart';
import 'package:flutter_train_app/model/train_booking_model.dart';
import 'package:flutter_train_app/value_notifier/train_reservation_value_notifier.dart';

class TrainReservationDetailPage extends StatelessWidget {
  const TrainReservationDetailPage({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<TrainReservationModel>>(
      valueListenable: TrainReservationValueNotifier.trainReservationList,
      builder: (context, items, child) {
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: [
                  Text(
                    "${items[index].startingStation}  -> ${items[index].destinationStation} ",
                  ),
                  Text(" 좌석 :${items[index].seatModel.getSeatString()} "),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
