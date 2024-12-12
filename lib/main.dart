import 'package:flutter/material.dart';
import 'package:tugas_besar/home.dart';
import 'package:tugas_besar/login_page.dart';
import 'package:tugas_besar/register.dart';
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
      home: RegisterView(),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:tugas_besar/client/RiwayatClient.dart';
// import 'package:tugas_besar/entity/Riwayat.dart';

// void main() {
//   runApp(MyRiwayatTestApp());
// }

// class MyRiwayatTestApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: RiwayatTestScreen(),
//     );
//   }
// }

// class RiwayatTestScreen extends StatefulWidget {
//   @override
//   _RiwayatTestScreenState createState() => _RiwayatTestScreenState();
// }

// class _RiwayatTestScreenState extends State<RiwayatTestScreen> {
//   List<Riwayat> riwayatList = [];
//   bool isLoading = false;
//   String errorMessage = '';

//   @override
//   void initState() {
//     super.initState();
//     fetchRiwayatData();
//   }

//   // Metode untuk mengambil semua riwayat
//   Future<void> fetchRiwayatData() async {
//     setState(() {
//       isLoading = true;
//       errorMessage = '';
//     });

//     try {
//       List<Riwayat> fetchedRiwayat = await RiwayatClient.fetchAll();
//       setState(() {
//         riwayatList = fetchedRiwayat;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Gagal mengambil riwayat: $e';
//         isLoading = false;
//       });
//     }
//   }

//   // Metode untuk membuat riwayat baru
//   Future<void> createRiwayat() async {
//     try {
//       Riwayat newRiwayat = Riwayat(
//         idUser: 1, // Ganti dengan ID user yang sesuai
//         idPemesanan: 1, // Ganti dengan ID pemesanan yang sesuai
//       );

//       Riwayat createdRiwayat = await RiwayatClient.create(newRiwayat);
      
//       setState(() {
//         riwayatList.add(createdRiwayat);
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Riwayat berhasil dibuat')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Gagal membuat riwayat: $e')),
//       );
//     }
//   }

//   // Metode untuk menghapus riwayat
//   Future<void> deleteRiwayat(int id) async {
//     try {
//       await RiwayatClient.destroy(id);
      
//       setState(() {
//         riwayatList.removeWhere((riwayat) => riwayat.id == id);
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Riwayat berhasil dihapus')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Gagal menghapus riwayat: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Riwayat Test'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.add),
//             onPressed: createRiwayat,
//           ),
//         ],
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : errorMessage.isNotEmpty
//               ? Center(child: Text(errorMessage))
//               : ListView.builder(
//                   itemCount: riwayatList.length,
//                   itemBuilder: (context, index) {
//                     Riwayat riwayat = riwayatList[index];
//                     return ListTile(
//                       title: Text('Riwayat ID: ${riwayat.id}'),
//                       subtitle: Text('User ID: ${riwayat.idUser}, Pemesanan ID: ${riwayat.idPemesanan}'),
//                       trailing: IconButton(
//                         icon: Icon(Icons.delete, color: Colors.red),
//                         onPressed: () => deleteRiwayat(riwayat.id!),
//                       ),
//                     );
//                   },
//                 ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: fetchRiwayatData,
//         child: Icon(Icons.refresh),
//       ),
//     );
//   }
// }