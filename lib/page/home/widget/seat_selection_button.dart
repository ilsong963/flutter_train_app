import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SeatSelectionButton extends StatelessWidget {
  const SeatSelectionButton({super.key, required this.startingStation, required this.destinationStation, required this.context});

  final String? startingStation;
  final String? destinationStation;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (startingStation != null && destinationStation != null) {
            context.push('/seat', extra: {'startingStation': startingStation, 'destinationStation': destinationStation});
          }
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, //change background color of button
          backgroundColor: Colors.purple,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        child: Text('좌석 선택'),
      ),
    );
  }
}
