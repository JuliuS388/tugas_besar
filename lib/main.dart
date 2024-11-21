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
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
      home: DetailBus(), // Hapus 'const' di sini
    return const MaterialApp(
      home: LoginView(),
    );
  }
}
