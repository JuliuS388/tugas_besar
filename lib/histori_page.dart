import 'package:flutter/material.dart';
import 'package:tugas_besar/client/RiwayatClient.dart';
import 'package:tugas_besar/entity/Riwayat.dart';
import 'package:tugas_besar/ulasan_page.dart';

class HistoriPage extends StatefulWidget {
  final int idUser;

  const HistoriPage({Key? key, required this.idUser}) : super(key: key);

  @override
  _HistoriPageState createState() => _HistoriPageState();
}

class _HistoriPageState extends State<HistoriPage> {
  List<Riwayat> riwayatList = [];
  bool isLoading = true;
  String errorMessage = '';

  Future<void> _fetchRiwayat() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      // Fetch riwayat berdasarkan userId
      List<Riwayat> fetchedRiwayat = 
          await RiwayatClient.fetchByUser(widget.idUser);

      setState(() {
        riwayatList = fetchedRiwayat;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Gagal mengambil riwayat: $e';
        isLoading = false;
      });
      print("Error fetching riwayat: $e");
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
        title: Text('Riwayat Pemesanan', style: TextStyle(color: Colors.white)),
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
                : riwayatList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.history_outlined, size: 100, color: Colors.grey),
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
                        itemCount: riwayatList.length,
                        itemBuilder: (context, index) {
                          return RiwayatCard(riwayat: riwayatList[index]);
                        },
                      ),
      ),
    );
  }
}

class RiwayatCard extends StatelessWidget {
  final Riwayat riwayat;

  const RiwayatCard({Key? key, required this.riwayat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Riwayat
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    riwayat.bus?['nama'] ?? 'Nama Bus Tidak Tersedia',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UlasanPage(
                            // idRiwayat: riwayat.idRiwayat,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Beri Ulasan',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Informasi Perjalanan
              Row(
                children: [
                  // Keberangkatan
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        riwayat.jadwal?['waktu_keberangkatan'] ?? 'N/A',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 8,
                            color: const Color.fromARGB(255, 0, 5, 163),
                          ),
                          SizedBox(width: 5),
                          Text(riwayat.jadwal?['asal'] ?? 'N/A'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 20),

                  // Durasi
                  Column(
                    children: [
                      Text(_hitungDurasi(
                        riwayat.jadwal?['waktu_keberangkatan'],
                        riwayat.jadwal?['waktu_kedatangan'],
                      )),
                      SizedBox(
                        height: 20,
                        child: VerticalDivider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20),

                  // Kedatangan
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        riwayat.jadwal?['waktu_kedatangan'] ?? 'N/A',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 8,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 5),
                          Text(riwayat.jadwal?['tujuan'] ?? 'N/A'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Footer Riwayat
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    riwayat.jadwal?['tanggal'] ?? 'Tanggal Tidak Tersedia',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    'Kode Kursi: ${riwayat.jadwal?['kursi'] ?? 'N/A'}', // Perbaiki typo 'k ursi'
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _hitungDurasi(String? waktuKeberangkatan, String? waktuKedatangan) {
    // Implementasi logika untuk menghitung durasi perjalanan
    // Misalnya, jika waktu dalam format "HH:mm", Anda bisa menghitung selisihnya
    return 'Durasi: 14 jam'; // Placeholder, ganti dengan logika yang sesuai
  }
}