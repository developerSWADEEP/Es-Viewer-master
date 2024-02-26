import 'package:es_viewer/splash.dart';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';
void main() async {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      home: Splash(), // Display the splash screen initially
    );
  }
}
