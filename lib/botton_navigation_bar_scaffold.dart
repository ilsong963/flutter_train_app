import 'package:flutter/material.dart';
import 'package:flutter_train_app/model/train_booking_model.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationBarScaffold extends StatefulWidget {
  const BottomNavigationBarScaffold({super.key, required this.child});
  final Widget child;

  @override
  State<BottomNavigationBarScaffold> createState() =>
      BottomNavigationBarScaffoldState();
}

class BottomNavigationBarScaffoldState
    extends State<BottomNavigationBarScaffold> {
  int selectedIndex = 0;

  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/details');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey, blurRadius: 3)],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          onTap: onTap,
          currentIndex: selectedIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
            BottomNavigationBarItem(
              icon: Icon(Icons.wysiwyg_rounded),
              label: "예매 내역",
            ),
          ],
        ),
      ),
    );
  }
}
