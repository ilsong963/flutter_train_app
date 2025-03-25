import 'package:flutter/material.dart';

class StationSelect extends StatelessWidget {
  const StationSelect({super.key, required this.stationType});
  final String stationType;
  final String? station = null;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(stationType, style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold)),
        TextButton(onPressed: () {}, child: Text(station ?? "선택", style: TextStyle(fontSize: 40, color: Colors.black))),
      ],
    );
  }
}
