import 'package:flutter/material.dart';

class ReservatedSeatSquare extends StatelessWidget {
  const ReservatedSeatSquare({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[600], borderRadius: BorderRadius.circular(8)),
      width: 50,
      height: 50,
      child: Center(child: Text("X", style: TextStyle(fontSize: 20, color: Colors.grey[400]))),
    );
  }
}
