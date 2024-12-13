import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:intl/intl.dart';
import 'package:tugas_besar/client/TicketClient.dart';
import 'package:tugas_besar/detailBusDanPemesanan.dart';
import 'package:tugas_besar/entity/Ticket.dart';
import 'package:tugas_besar/ticket_preview.dart';

class TicketList extends StatefulWidget {
  final int idUser;

  const TicketList({Key? key, required this.idUser}) : super(key: key);

  @override
  _TicketListState createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> {
  List<Ticket> ticketList = [];
  bool isLoading = true;
  String errorMessage = '';

  Future<void> _fetchRiwayat() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      List<Ticket> fetchedTicket =
          await TicketClient.fetchByUser(widget.idUser);

      // Debug prints
      print("Total tickets fetched: ${fetchedTicket.length}");
      print("Fetched Tickets data: ${fetchedTicket.map((t) => {
            'id': t.id,
            'pemesanan_id': t.pemesanan_id,
            'user_id': t.user_id,
          }).toList()}");

      setState(() {
        ticketList = fetchedTicket;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Gagal mengambil ticket: $e';
        isLoading = false;
      });
      print("Error fetching ticket: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchRiwayat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tiket', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade900,
      ),
      body: RefreshIndicator(
        onRefresh: _fetchRiwayat,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          errorMessage,
                          style: TextStyle(color: Colors.red),
                        ),
                        ElevatedButton(
                          onPressed: _fetchRiwayat,
                          child: Text('Coba Lagi'),
                        )
                      ],
                    ),
                  )
                : ticketList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.history_outlined,
                                size: 100, color: Colors.grey),
                            Text(
                              'Tidak Ada Riwayat Pemesanan',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: ticketList.length,
                        itemBuilder: (context, index) {
                          return TicketCard(ticket: ticketList[index]);
                        },
                      ),
      ),
    );
  }
}

class TicketCard extends StatelessWidget {
  final Ticket ticket;

  const TicketCard({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pemesanan = ticket.pemesanan;
    final jadwal = pemesanan?.jadwal;
    final bus = jadwal?.bus;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TicketPreview(ticket: ticket),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bus Information
              Text(
                bus?.namaBus ?? 'Nama Bus Tidak Tersedia',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),

              // Journey Details
              Row(
                children: [
                  Icon(Icons.location_on, size: 16),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '${jadwal?.asal ?? 'N/A'} → ${jadwal?.tujuan ?? 'N/A'}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),

              // Schedule
              SizedBox(height: 8),
              Text(
                'Keberangkatan: ${jadwal?.keberangkatan ?? 'N/A'}',
                style: TextStyle(fontSize: 14),
              ),

              // Transaction Date
              SizedBox(height: 8),
              Text(
                'Tanggal Transaksi: ${pemesanan?.tanggalPemesanan ?? 'N/A'}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class TicketDetailPage extends StatelessWidget {
//   final Ticket ticket;

//   const TicketDetailPage({Key? key, required this.ticket}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detail Tiket'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Detail Tiket',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             Text('Pemesan: ${ticket.user?.nama}'),
//             Text('ID Tiket: ${ticket.id}'),
//             Text('Nama Bus: ${ticket.jadwal?.bus?.namaBus ?? "N/A"}'),
//             Text('Asal: ${ticket.jadwal?.asal ?? "N/A"}'),
//             Text('Tujuan: ${ticket.jadwal?.tujuan ?? "N/A"}'),
//             Text('Keberangkatan: ${ticket.jadwal?.keberangkatan ?? "N/A"}'),
//             Text('Kedatangan: ${ticket.jadwal?.kedatangan ?? "N/A"}'),
//             Spacer(),
//             ElevatedButton(
//               onPressed: () {
//                 // Navigasi ke halaman TicketPreview
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => TicketPreview(ticket: ticket),
//                   ),
//                 );
//               },
//               child: Text("Cetak PDF"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
