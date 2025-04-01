String convertIndexToSeat(String seatRow, String seatColumn) {
  int row = int.parse(seatRow);
  int column = int.parse(seatColumn);

  // 좌석 열(column) 변환 로직
  int asciiOffset = (column % 5) > 2 ? 64 : 65;
  String seatLetter = String.fromCharCode((column % 5) + asciiOffset);

  return "${row + 1} - $seatLetter";
}
