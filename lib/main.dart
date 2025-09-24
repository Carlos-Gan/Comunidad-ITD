import 'package:flutter/material.dart';
import 'package:ciit_2/frames/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ACIISTI 2.0',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const PanelInicio(),
    );
  }
}
