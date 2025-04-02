import 'package:flutter/material.dart';

class TextSquare extends StatelessWidget {
  const TextSquare({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      width: 50,
      height: 50,
      child: Center(child: Text(text, style: TextStyle(fontSize: 18))),
    );
  }
}
