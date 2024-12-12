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
  List<Ticket> tickets = [];
  bool isLoading = true;

  Future<void> _fetchTickets() async {
    try {
      // Fetch tiket berdasarkan userId
      List<Ticket> fetchedTickets =
          await TicketClient.fetchByUser(widget.idUser);

      print(
          "Fetched Tickets: ${fetchedTickets.length}"); // Log data yang diterima

      setState(() {
        tickets = fetchedTickets; // Update list tickets
        isLoading = false; // Pastikan loading selesai
      });
    } catch (e) {
      print("Error fetching tickets: $e");
      setState(() {
        isLoading = false; // Pastikan loading selesai meskipun ada error
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchTickets();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (tickets.isEmpty) {
      return Center(
        child: Text(
          "Tidak ada tiket yang ditemukan",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        return TicketCard(ticket: tickets[index]);
      },
    );
  }
}

class TicketCard extends StatelessWidget {
  final Ticket ticket;

  const TicketCard({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TicketDetailPage(ticket: ticket),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bus: ${ticket.jadwal?.bus?.namaBus ?? "N/A"}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    _buildInfo("Asal", ticket.jadwal?.asal ?? "N/A"),
                    Spacer(),
                    _buildInfo("Tujuan", ticket.jadwal?.tujuan ?? "N/A"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey)),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class TicketDetailPage extends StatelessWidget {
  final Ticket ticket;

  const TicketDetailPage({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Tiket'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail Tiket',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Pemesan: ${ticket.user?.nama}'),
            Text('ID Tiket: ${ticket.id}'),
            Text('Nama Bus: ${ticket.jadwal?.bus?.namaBus ?? "N/A"}'),
            Text('Asal: ${ticket.jadwal?.asal ?? "N/A"}'),
            Text('Tujuan: ${ticket.jadwal?.tujuan ?? "N/A"}'),
            Text('Keberangkatan: ${ticket.jadwal?.keberangkatan ?? "N/A"}'),
            Text('Kedatangan: ${ticket.jadwal?.kedatangan ?? "N/A"}'),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman TicketPreview
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TicketPreview(ticket: ticket),
                  ),
                );
              },
              child: Text("Cetak PDF"),
            ),
          ],
        ),
      ),
    );
  }
}
