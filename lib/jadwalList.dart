import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:intl/intl.dart';
import 'package:tugas_besar/detailBusDanPemesanan.dart';
import 'package:tugas_besar/entity/Jadwal.dart';
import 'package:tugas_besar/client/JadwalClient.dart';

class JadwalList extends StatefulWidget {
  final String asal;
  final String tujuan;
  final int jumlahKursi;
  final String tanggal;

  const JadwalList({
    Key? key,
    required this.asal,
    required this.tujuan,
    required this.jumlahKursi,
    required this.tanggal,
  }) : super(key: key);

  @override
  State<JadwalList> createState() => _JadwalListState();
}

class _JadwalListState extends State<JadwalList> {
  List<Jadwal> jadwalList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchJadwal();
  }

  Future<void> _fetchJadwal() async {
    try {
      // Memanggil fetchFiltered dengan parameter asal, tujuan, dan tanggal (keberangkatan)
      List<Jadwal> fetchedJadwal = await JadwalClient.fetchFiltered(
        widget.asal, // asal dari widget
        widget.tujuan, // tujuan dari widget
        widget.tanggal, // tanggal keberangkatan dari widget
      );

      setState(() {
        jadwalList =
            fetchedJadwal; // Menyimpan hasil pencarian ke dalam jadwalList
        isLoading = false; // Mengubah status loading menjadi false
      });
    } catch (e) {
      print("Error fetching jadwal: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "Failed to fetch jadwal: $e")), // Menampilkan snackbar jika terjadi error
      );
      setState(() {
        isLoading = false; // Mengubah status loading menjadi false saat error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text('Cari Tiket', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : jadwalList.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.directions_bus_outlined,
                          size: 100, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'Maaf, Bus Tidak Ditemukan',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Tidak ada bus tersedia untuk rute ${widget.asal} - ${widget.tujuan}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: jadwalList.length,
                  itemBuilder: (context, index) {
                    final jadwal = jadwalList[index];
                    return InkWell(
                      onTap: () {
                        // Navigate to the detail bus page when tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailBusDanPemesanan(
                              jadwal: jadwal,
                              bus: jadwal.bus, // Pass the entire bus object
                              jumlahKursi: widget.jumlahKursi,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          elevation: 3,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  jadwal.bus?.namaBus ??
                                      'Nama Bus Tidak Tersedia',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          DateFormat('HH:mm')
                                              .format(jadwal.keberangkatan),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          jadwal.asal,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          children: [
                                            DottedLine(dashColor: Colors.grey),
                                            SizedBox(height: 4),
                                            Text(
                                              'Harga: Rp ${jadwal.harga.toStringAsFixed(0)}',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          DateFormat('HH:mm')
                                              .format(jadwal.kedatangan),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          jadwal.tujuan,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                // Display bus details (driver, facilities)
                                Text(
                                  'Supir: ${jadwal.bus?.supirBus ?? 'Nama Supir Tidak Tersedia'}',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Fasilitas: ${jadwal.bus?.fasilitasBus ?? 'Fasilitas Tidak Tersedia'}',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
