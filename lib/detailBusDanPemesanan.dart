import 'package:flutter/material.dart';
import 'package:tugas_besar/client/RiwayatClient.dart';
import 'package:tugas_besar/detailPenumpang.dart';
import 'package:tugas_besar/entity/Pemesanan.dart';
import 'package:tugas_besar/entity/Riwayat.dart';
import 'package:tugas_besar/entity/Bus.dart';
import 'package:tugas_besar/entity/Jadwal.dart';
import 'package:tugas_besar/client/PemesananClient.dart';
import 'package:intl/intl.dart';
import 'package:tugas_besar/tokenStorage.dart';

class DetailBusDanPemesanan extends StatefulWidget {
  final Bus bus;
  final Jadwal jadwal;
  final int jumlahKursi;

  const DetailBusDanPemesanan({
    super.key,
    required this.bus,
    required this.jadwal,
    required this.jumlahKursi,
  });

  @override
  _DetailBusDanPemesananState createState() => _DetailBusDanPemesananState();
}

Future<int?> getUserId() async {
  final userId = await TokenStorage.getUserId();
  print("User ID yang didapat: $userId");
  return userId;
}

class _DetailBusDanPemesananState extends State<DetailBusDanPemesanan> {
  // Method to handle ticket booking
  void _confirmBooking(BuildContext context) async {
    // Calculate total price
    double totalPrice = widget.jadwal.harga * widget.jumlahKursi;

    // Show confirmation dialog
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          height: MediaQuery.of(context).size.height * 0.6,
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
                      'Bus: ${widget.bus.namaBus}',
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
                      'Jadwal: ${widget.jadwal.asal} to ${widget.jadwal.tujuan}',
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
                    try {
                      final userId = await getUserId();
                      if (userId == null) {
                        throw 'User ID tidak ditemukan. Harap login ulang.';
                      }

                      // 1. Buat pemesanan
                      var pemesanan = Pemesanan(
                        idUser: userId,
                        idJadwal: widget.jadwal.idJadwal,
                        tanggalPemesanan: DateTime.now(),
                        harga: totalPrice,
                      );

                      try {
                        // 2. Kirim pemesanan ke server
                        var pemesananBaru = await PemesananClient.create(pemesanan);
                        var pemesananId = pemesananBaru.id!;

                        // 3. Buat riwayat
                        var riwayat = Riwayat(
                          idUser: userId,
                          idPemesanan: pemesananId,
                          tanggalTransaksi: DateTime.now().toIso8601String(),
                          pemesanan: pemesananBaru,
                        );

                        try {
                          await RiwayatClient.create(riwayat);

                          // Tutup bottom sheet terlebih dahulu
                          Navigator.pop(context);

                          // 5. Navigasi ke halaman DetailPenumpang
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPenumpang(
                                jumlahKursi: widget.jumlahKursi,
                                idPemesanan: pemesananId,
                              ),
                            ),
                          );

                          // 6. Tampilkan notifikasi sukses
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  Icon(Icons.check_circle, color: Colors.white),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Pemesanan berhasil!',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 4),
                            ),
                          );
                        } catch (e) {
                          // Error handling untuk riwayat
                          print("Error saat menyimpan riwayat: $e");
                          
                          // Jika gagal membuat riwayat, hapus pemesanan
                          await PemesananClient.destroy(pemesananId);
                          
                          Navigator.pop(context); // Tutup bottom sheet
                          
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  Icon(Icons.error, color: Colors.white),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Gagal menyimpan riwayat: $e',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 4),
                            ),
                          );
                        }
                      } catch (e) {
                        // Error handling untuk pemesanan
                        print("Error saat memesan tiket: $e");
                        
                        Navigator.pop(context); // Tutup bottom sheet
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                Icon(Icons.error, color: Colors.white),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Gagal melakukan pemesanan: $e',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 4),
                          ),
                        );
                      }
                    } catch (e) {
                      // Error handling untuk user ID
                      print("Error saat mengambil user ID: $e");
                      
                      Navigator.pop(context); // Tutup bottom sheet
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              Icon(Icons.error, color: Colors.white),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Gagal mengambil user ID: $e',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 4),
                        ),
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
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    widget.bus.namaBus ?? 'Bus Details',
                    style: const TextStyle(color: Colors.white, fontSize: 22),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Bus Information',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Supir: ${widget.bus.supirBus ?? 'Unknown'}',
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                const Divider(height: 20),
                                _buildDetailRow(
                                    'Asal', widget.jadwal.asal ?? '-'),
                                _buildDetailRow(
                                    'Tujuan', widget.jadwal.tujuan ?? '-'),
                                _buildDetailRow('Fasilitas',
                                    widget.bus.fasilitasBus ?? '-'),
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
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          _confirmBooking(context);
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
            style: const TextStyle(fontWeight: FontWeight.w600),
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
