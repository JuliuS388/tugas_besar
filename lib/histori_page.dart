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
      List<Riwayat> fetchedRiwayat = 
          await RiwayatClient.fetchByUser(widget.idUser);
      
      print("Fetched Riwayat: ${fetchedRiwayat.map((r) => {
        'jadwal': r.pemesanan?.jadwal,
        'bus': r.pemesanan?.jadwal?.bus
      }).toList()}");

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
    // Get nested data safely
    final pemesanan = riwayat.pemesanan;
    final jadwal = pemesanan?.jadwal;
    final bus = jadwal?.bus;

    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
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
              'Tanggal Transaksi: ${riwayat.tanggalTransaksi ?? 'N/A'}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            
            // Add spacing before the button
            SizedBox(height: 16),
            
            // Add Review Button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UlasanPage(
                          idPemesanan: riwayat.idPemesanan ?? 0,
                          idUser: riwayat.idUser ?? 0,
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.rate_review),
                  label: Text('Beri Ulasan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}