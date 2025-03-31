import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StationSelect extends StatefulWidget {
  const StationSelect({
    super.key,
    required this.stationType,
    required this.onSelect,
    required this.exceptStation,
  });
  final String stationType;
  final Function(String?) onSelect;
  final String? exceptStation;

  @override
  State<StationSelect> createState() => _StationSelectState();
}

class _StationSelectState extends State<StationSelect> {
  String? station;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.stationType,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () async {
            String? selectedStation = await context.push(
              '/stationList',
              extra: {
                "title": widget.stationType,
                "exceptStation": widget.exceptStation,
              },
            );

            setState(() {
              station = selectedStation;
              widget.onSelect(station);
            });
          },
          child: Text(station ?? "선택", style: TextStyle(fontSize: 40)),
        ),
      ],
    );
  }
}
