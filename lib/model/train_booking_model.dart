import 'package:flutter_train_app/model/seat_model.dart';

class TrainBookingModel {
  String startingStation;
  String destinationStation;
  SeatModel seatModel;

  TrainBookingModel({
    required this.startingStation,
    required this.destinationStation,
    required this.seatModel,
  });
}
