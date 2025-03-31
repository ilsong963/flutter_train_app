class SeatModel {
  String seatRow;
  String seatColumn;

  SeatModel({required this.seatRow, required this.seatColumn});

  String getSeatString() {
    return '$seatRow-$seatColumn';
  }
}
