import 'package:flutter/material.dart';

class StationRow extends StatelessWidget {
  const StationRow({super.key, required this.startingStation, required this.destinationStation});

  final String startingStation;

  final String destinationStation;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 1,
          child: Center(child: Text(startingStation, style: TextStyle(color: Colors.purple, fontSize: 30, fontWeight: FontWeight.bold))),
        ),
        Icon(Icons.arrow_circle_right_outlined, size: 30),
        Expanded(
          flex: 1,
          child: Center(child: Text(destinationStation, style: TextStyle(color: Colors.purple, fontSize: 30, fontWeight: FontWeight.bold))),
        ),
      ],
    );
  }
}
