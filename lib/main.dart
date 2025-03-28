import 'package:flutter/material.dart';
import 'package:flutter_train_app/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,

      themeMode: ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pinkAccent,
          brightness: Brightness.light,
        ),
        cardColor: Colors.white,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.black),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedLabelStyle: TextStyle(color: Colors.black),
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey[500],
          unselectedLabelStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pinkAccent,
          brightness: Brightness.dark,
        ),
        cardColor: Colors.grey[800],
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.white),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedLabelStyle: TextStyle(color: Colors.white),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[800],
          unselectedLabelStyle: TextStyle(color: Colors.grey[800]),
        ),
      ),
    );
  }
}
