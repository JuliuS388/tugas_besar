import 'package:flutter/material.dart';
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
      home: HomeView(), // Hapus 'const' di sini
    );
  }
}
