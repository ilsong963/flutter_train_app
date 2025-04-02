import 'package:flutter/material.dart';
import 'package:flutter_train_app/page/home/widget/seat_selection_button.dart';
import 'package:flutter_train_app/page/home/widget/station_select.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? startingStation;
  String? destinationStation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('기차 예매'), centerTitle: true),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            stationSelectionCard(context),
            SizedBox(height: 20),
            SeatSelectionButton(startingStation: startingStation, destinationStation: destinationStation, context: context),
          ],
        ),
      ),
    );
  }

  Container stationSelectionCard(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Theme.of(context).cardColor),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: StationSelect(
              stationType: '출발역',
              exceptStation: destinationStation,
              onSelect: (station) {
                setState(() {
                  startingStation = station;
                });
              },
            ),
          ),
          Container(height: 50, width: 2, color: Colors.grey[200]),
          Expanded(
            flex: 1,
            child: StationSelect(
              stationType: '도착역',
              exceptStation: startingStation,
              onSelect: (station) {
                setState(() {
                  destinationStation = station;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
