import 'package:flutter/material.dart';
import 'package:tugas_besar/login_page.dart';
import 'package:tugas_besar/ticket_preview.dart';
import 'package:tugas_besar/ticketList.dart';

void main() {
  runApp(MainApp());
}

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//      // Hapus 'const' di sini
//     return const MaterialApp(
//       home: TicketPreview(),
//     );
//   }
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: TicketPreview(), 
//     );
//   }
// }

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