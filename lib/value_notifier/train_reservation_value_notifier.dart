import 'package:flutter/material.dart';
import 'package:flutter_train_app/model/train_booking_model.dart';

class TrainReservationValueNotifier {
  static final ValueNotifier<List<TrainReservationModel>> trainReservationList =
      ValueNotifier<List<TrainReservationModel>>([]);

  static void removeReservation(int index) {
    if (index < 0 || index >= trainReservationList.value.length) return;

    final updatedList = List<TrainReservationModel>.from(
      trainReservationList.value,
    );
    updatedList.removeAt(index);
    trainReservationList.value = updatedList;
  }

  static void addReservation(TrainReservationModel trainreservationModel) {
    trainReservationList.value = [
      ...trainReservationList.value,
      trainreservationModel,
    ];
  }

  static void updateReservation(
    TrainReservationModel oldReservation,
    TrainReservationModel updatedReservation,
  ) {
    trainReservationList.value =
        trainReservationList.value.map((reservation) {
          if (reservation == oldReservation) {
            return updatedReservation;
          }
          return reservation;
        }).toList();
  }
}
