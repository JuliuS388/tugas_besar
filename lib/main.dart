import 'package:flutter/material.dart';
import 'package:tugas_besar/login_page.dart';
import 'package:tugas_besar/ticket_preview.dart';
import 'package:tugas_besar/ticketList.dart';
import 'package:tugas_besar/histori_page.dart';
import 'package:tugas_besar/home.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}