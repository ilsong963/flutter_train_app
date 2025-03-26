import 'package:flutter/material.dart';

class SeatPage extends StatefulWidget {
  final String? startingStation;
  final String? destinationStation;

  const SeatPage({super.key, this.startingStation, this.destinationStation});

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('좌석 선택'), centerTitle: true),

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.startingStation ?? "출발역",
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.arrow_circle_right_outlined, size: 30),
                Text(
                  widget.destinationStation ?? "도착역",
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                seat(24, Colors.purple),
                SizedBox(width: 4),
                Text('선택됨'),
                SizedBox(width: 20),
                seat(24, Colors.grey[300]!),
                SizedBox(width: 4),
                Text('선택안됨'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  ['A', 'B', ' ', 'C', 'D']
                      .map<Widget>(
                        (element) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2),
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Center(
                              child: Text(
                                element,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return row(index + 1);
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SeatPage()),
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
                child: Text('예매 하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding row(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          seat(50, Colors.grey[300]!),
          SizedBox(width: 4),
          seat(50, Colors.grey[300]!),
          SizedBox(width: 4),
          seat(50, Colors.white, text: index.toString()),
          SizedBox(width: 4),
          seat(50, Colors.grey[300]!),
          SizedBox(width: 4),
          seat(50, Colors.grey[300]!),
        ],
      ),
    );
  }

  Widget seat(double size, Color color, {String? text}) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      width: size,
      height: size,
      child: text == null ? SizedBox() : Center(child: Text(text.toString())),
    );
  }
}
