import 'package:flutter/material.dart';
import 'package:mid_practice/mission_list.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpaceX Missions',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: AppBarTheme(),
        useMaterial3: false,
      ),
      home: const custom_mission_list(),
    );
  }
}