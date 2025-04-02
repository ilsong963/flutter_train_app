import 'package:flutter/material.dart';

class SeatSquare extends StatelessWidget {
  const SeatSquare({super.key, required this.color, required this.size});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)), width: size, height: size);
  }
}
