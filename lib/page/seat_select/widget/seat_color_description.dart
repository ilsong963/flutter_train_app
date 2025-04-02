import 'package:flutter/material.dart';
import 'package:flutter_train_app/page/seat_select/widget/seat_square.dart';

class SeatColorDescription extends StatelessWidget {
  const SeatColorDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SeatSquare(color: Colors.purple, size: 25),
          SizedBox(width: 4),
          Text('선택됨'),
          SizedBox(width: 20),
          SeatSquare(color: Colors.grey[300]!, size: 24),
          SizedBox(width: 4),
          Text('선택안됨'),
        ],
      ),
    );
  }
}
