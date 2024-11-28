import 'package:flutter/material.dart';
import 'package:tugas_besar/ulasan_page.dart';

class HistoriPage extends StatelessWidget {
  final List<Map<String, String>> histori = [
    {
      'nama': 'Handoyo',
      'jamBerangkat': '13:00',
      'asal': 'Pulo Gadung',
      'jamSampai': '03:00',
      'tujuan': 'Terminal Jombor',
      'tanggal': '25 Oktober 2024',
      'kursi': 'D5',
    },
    {
      'nama': 'Haryanto',
      'jamBerangkat': '02:00',
      'asal': 'Pulo Gadung',
      'jamSampai': '16:00',
      'tujuan': 'Terminal Jombor',
      'tanggal': '25 Oktober 2024',
      'kursi': 'A1, A2',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Pemesanan'),
      ),
      body: ListView.builder(
        itemCount: histori.length,
        itemBuilder: (context, index) {
          final item = histori[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text(item['nama']!),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Berangkat: ${item['jamBerangkat']} (${item['asal']})'),
                    Text('Sampai: ${item['jamSampai']} (${item['tujuan']})'),
                    Text('Tanggal: ${item['tanggal']}'),
                    Text('Kode Kursi: ${item['kursi']}'),
                  ],
                ),
                trailing: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UlasanPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Beri Ulasan',
                    style: TextStyle(color: Colors.blue),
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
