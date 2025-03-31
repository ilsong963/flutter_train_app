import 'package:flutter/material.dart';
import 'package:flutter_train_app/model/train_booking_model.dart';

class TrainBookingValueNotifier {
  static final ValueNotifier<List<TrainBookingModel>> trainBookingList =
      ValueNotifier<List<TrainBookingModel>>([]);
}
