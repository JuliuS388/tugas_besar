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
        backgroundColor: const Color.fromARGB(255, 48, 169, 255),
      ),
      body: Container(
        color: Colors.lightBlue[50],
        child: ListView.builder(
          itemCount: histori.length,
          itemBuilder: (context, index) {
            final item = histori[index];
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item['nama']!,
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
                                  builder: (context) => UlasanPage(),
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
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['jamBerangkat']!,
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
                                  Text(item['asal']!),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          Column(
                            children: [
                              Text('14 jam'),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['jamSampai']!,
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
                                  Text(item['tujuan']!),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item['tanggal']!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            'Kode Kursi : ${item['kursi']}',
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
          },
        ),
      ),
    );
  }
}
