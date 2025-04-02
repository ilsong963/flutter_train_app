import 'package:flutter/material.dart';

class ReservationActionButton extends StatelessWidget {
  const ReservationActionButton({super.key, required this.str, required this.onTap});

  final String str;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(padding: EdgeInsets.all(10), child: Text(str, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
    );
  }
}
