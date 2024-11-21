import 'package:flutter/material.dart';
import 'package:tugas_besar/detailBus.dart';
import 'package:tugas_besar/home.dart';
import 'package:tugas_besar/login_page.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
     // Hapus 'const' di sini
    return const MaterialApp(
      home: LoginView(),
    );
  }
}
