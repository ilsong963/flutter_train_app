import 'package:flutter/material.dart';
import 'package:flutter_train_app/page/home/widget/station_select.dart';
import 'package:flutter_train_app/page/seat_select/seat.dart';
import 'package:flutter_train_app/page/statin_list/station_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StationSelect(stationType: "출발역"),
                  Container(height: 50, width: 2, color: Colors.grey[200]),
                  StationSelect(stationType: "도착역"),
                ],
              ),
            ),
            SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SeatPage()));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, //change background color of button
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
