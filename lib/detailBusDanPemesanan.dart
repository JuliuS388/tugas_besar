import 'package:flutter/material.dart';
import 'package:tugas_besar/detailPenumpang.dart';
import 'package:tugas_besar/entity/Pemesanan.dart';
import 'package:tugas_besar/entity/Bus.dart';
import 'package:tugas_besar/entity/Jadwal.dart';
import 'package:tugas_besar/client/PemesananClient.dart'; // Import PemesananClient
import 'package:intl/intl.dart';
import 'package:tugas_besar/detailPenumpang.dart'; // Import intl package untuk format tanggal

class DetailBusDanPemesanan extends StatelessWidget {
  final Bus bus;
  final Jadwal jadwal;
  final int jumlahKursi;

  const DetailBusDanPemesanan({
    super.key,
    required this.bus,
    required this.jadwal,
    required this.jumlahKursi,
  });

  // Method to handle ticket booking
  void _confirmBooking(BuildContext context) async {
    // Calculate total price
    double totalPrice = jadwal.harga * jumlahKursi;

    // Show confirmation dialog
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow scroll if needed
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          height: MediaQuery.of(context).size.height *
              0.6, // More space for content
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Text(
                'Konfirmasi Pemesanan',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
              SizedBox(height: 15),
              Divider(),

              // Ticket Details Section
              Row(
                children: [
                  Icon(Icons.directions_bus, color: Colors.blue.shade900),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Bus: ${bus.namaBus}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.blue.shade900),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Jadwal: ${jadwal.asal} to ${jadwal.tujuan}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.attach_money, color: Colors.blue.shade900),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Harga: Rp. ${totalPrice.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade800,
                      ),
                    ),
                  ),
                ],
              ),

              Spacer(),

              // Button Section
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    // Create Pemesanan object with calculated total price
                    var pemesanan = Pemesanan(
                      idUser: 1, // Use the actual user ID
                      idJadwal: jadwal.idJadwal,
                      tanggalPemesanan: DateTime.now(),
                      harga: totalPrice, // Use the calculated total price
                    );

                    try {
                      var pemesananBaru =
                          await PemesananClient.create(pemesanan);
                      var pemesananId = pemesananBaru.id!;

                      // Navigasi ke halaman DetailPenumpang
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPenumpang(
                            jumlahKursi: jumlahKursi,
                            idPemesanan: pemesananId,
                          ),
                        ),
                      );
                    } catch (e) {
                      // Tangani kesalahan
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Gagal melakukan pemesanan: $e')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                    padding: const EdgeInsets.symmetric(
                      vertical: 18.0,
                      horizontal: 40.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: const Text(
                    'Pesan Tiket',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Function to format the date and time
  String _formatDate(DateTime date) {
    return DateFormat('MMMM d, yyyy, HH:mm')
        .format(date); // Format: Bulan dd, yyyy, jam:mm
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                bus.namaBus ?? 'Bus Details',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            backgroundColor: Colors.blue.shade900,
            foregroundColor: Colors.white,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Bus Information',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Supir: ${bus.supirBus ?? 'Unknown'}',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            Divider(height: 20),
                            _buildDetailRow('Asal', jadwal.asal ?? '-'),
                            _buildDetailRow('Tujuan', jadwal.tujuan ?? '-'),
                            _buildDetailRow(
                                'Fasilitas', bus.fasilitasBus ?? '-'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const SectionTitle(title: 'Keberangkatan'),
                    InformationCard(
                      content:
                          '1. Penumpang sudah siap setidaknya 60 menit sebelum keberangkatan di titik keberangkatan yang telah ditentukan oleh agen. '
                          'Keterlambatan penumpang dapat menyebabkan tiket dibatalkan secara sepihak dan tidak mendapatkan pengembalian dana.\n\n'
                          '2. Penumpang diwajibkan untuk menunjukkan e-ticket dan identitas yang berlaku (KTP).\n\n'
                          '3. Waktu keberangkatan yang tertera di aplikasi adalah waktu lokal di titik keberangkatan.',
                    ),
                    const SizedBox(height: 16),
                    const SectionTitle(title: 'Barang Bawaan'),
                    InformationCard(
                      content:
                          '1. Penumpang dilarang membawa barang terlarang/ilegal dan menyertakan seperti senjata tajam, bahan terbakar, dan obat-obatan terlarang. '
                          'Barang-barang ini akan ditolak oleh pihak keperluan angkutan.\n\n'
                          '2. Untuk barang yang melebihi kapasitas yang telah ditentukan akan dikenakan biaya tambahan sesuai peraturan masing-masing agen bus.\n\n'
                          '3. Penumpang diminta untuk menjaga barang pribadi mereka selama perjalanan.',
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          _confirmBooking(context); // Trigger booking confirmation
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade900,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: const Text(
          'Pesan Tiket',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(
            value,
            style: TextStyle(color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class InformationCard extends StatelessWidget {
  final String content;

  const InformationCard({required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          content,
          style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
        ),
      ),
    );
  }
}
