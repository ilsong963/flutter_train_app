import 'package:flutter/material.dart';
import 'package:flutter_train_app/model/train_booking_model.dart';

class TrainReservationValueNotifier {
  static final ValueNotifier<List<TrainReservationModel>> trainReservationList =
      ValueNotifier<List<TrainReservationModel>>([]);
}
