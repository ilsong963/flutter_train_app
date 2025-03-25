import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  StationListPage({super.key, required this.title});
  final List<String> stationList = ["수서", "동탄", "평택지제", "천안아산", "오송", "대전", "김천구미", "동대구", "경주", "울산", "부산"];
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            stationList.map((station) {
              return Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey[300]!))),
                alignment: Alignment.centerLeft,
                child: Text(station, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              );
            }).toList(),
      ),
    );
  }
}
