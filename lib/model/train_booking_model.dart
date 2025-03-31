import 'package:flutter_train_app/model/seat_model.dart';

class TrainReservationModel {
  String startingStation;
  String destinationStation;
  SeatModel seatModel;

  TrainReservationModel({
    required this.startingStation,
    required this.destinationStation,
    required this.seatModel,
  });
}
