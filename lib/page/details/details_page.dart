import 'package:flutter/material.dart';
import 'package:flutter_train_app/model/train_booking_model.dart';
import 'package:flutter_train_app/value_notifier/train_booking_value_notifier.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<TrainBookingModel>>(
      valueListenable: TrainBookingValueNotifier.trainBookingList,
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
