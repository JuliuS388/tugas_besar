import 'package:flutter/material.dart';
import 'package:tugas_besar/pembayaran.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyWidget(),
    );
  }
}
