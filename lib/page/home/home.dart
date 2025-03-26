import 'package:flutter/material.dart';
import 'package:flutter_train_app/page/home/widget/station_select.dart';
import 'package:flutter_train_app/page/seat_select/seat_page.dart';

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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text('기차 예매'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),

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
            ),
            SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => SeatPage(
                            startingStation: startingStation,
                            destinationStation: destinationStation,
                          ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor:
                      Colors.white, //change background color of button
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),

                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text('좌석 선택'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
