import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_train_app/model/seat_model.dart';
import 'package:flutter_train_app/model/train_booking_model.dart';
import 'package:flutter_train_app/value_notifier/train_booking_value_notifier.dart';
import 'package:go_router/go_router.dart';

class SeatPage extends StatefulWidget {
  final String startingStation;
  final String destinationStation;

  const SeatPage({
    super.key,
    required this.startingStation,
    required this.destinationStation,
  });

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  String? seatColumn;
  String? seatRow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('좌석 선택'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      widget.startingStation,
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Icon(Icons.arrow_circle_right_outlined, size: 30),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      widget.destinationStation,
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  seatSquare(24, Colors.purple),
                  SizedBox(width: 4),
                  Text('선택됨'),
                  SizedBox(width: 20),
                  seatSquare(24, Colors.grey[300]!),
                  SizedBox(width: 4),
                  Text('선택안됨'),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: getColumnList(),
                    ),
                    SizedBox(
                      width: 250,
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 5,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        children: List.generate(100, (index) {
                          if ((index - 2) % 5 == 0) {
                            return textSquare("${index ~/ 5 + 1}");
                          }
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                seatRow = (index ~/ 5).toString();
                                seatColumn = (index % 5).toString();
                              });
                            },
                            child: seatSquare(
                              50,
                              (seatRow != null &&
                                      seatColumn != null &&
                                      index ==
                                          int.parse(seatRow!) * 5 +
                                              int.parse(seatColumn!))
                                  ? Colors.purple
                                  : Colors.grey[300]!,
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (seatColumn != null && seatRow != null) {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text("예매 하시겠습니까??"),
                          content: Text(
                            "좌석: ${int.parse(seatRow!) + 1}-${convertNumberToAlphbet(int.parse(seatColumn!))}",
                          ),
                          actions: [
                            CupertinoDialogAction(
                              child: Text(
                                "취소",
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            CupertinoDialogAction(
                              onPressed: () {
                                context.pop();
                                context.pop();
                                TrainBookingValueNotifier
                                    .trainBookingList
                                    .value = List.from(
                                  TrainBookingValueNotifier
                                      .trainBookingList
                                      .value,
                                )..add(
                                  TrainBookingModel(
                                    startingStation: widget.startingStation,
                                    destinationStation:
                                        widget.destinationStation,
                                    seatModel: SeatModel(
                                      seatRow: seatRow!,
                                      seatColumn: seatColumn!,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "확인",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
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

  String convertNumberToAlphbet(int number) {
    return String.fromCharCode(
      (number % 5) > 2 ? (number % 5) + 64 : (number % 5) + 65,
    );
  }

  List<Widget> getColumnList() {
    List columnList = ['A', 'B', 'C', 'D'];
    List<Widget> widgetList = [];

    for (var i = 0; i < columnList.length; i++) {
      widgetList.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: textSquare(columnList[i]),
        ),
      );
    }

    widgetList.insert(
      2,
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 2),
        child: SizedBox(width: 50, height: 50),
      ),
    );
    return widgetList;
  }

  Widget seatSquare(double size, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      width: size,
      height: size,
    );
  }

  Widget textSquare(String text) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      width: 50,
      height: 50,
      child: Center(
        child: Text(text.toString(), style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
