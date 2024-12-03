import 'package:flutter/material.dart';
import 'package:tugas_besar/pemesanan.dart';
import 'package:tugas_besar/entity/Bus.dart'; // Pastikan Anda mengimpor entitas Bus

class DetailBus extends StatelessWidget {
  final Bus bus;

  const DetailBus({super.key, required this.bus});

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
                            _buildDetailRow('Asal', bus.asalBus ?? '-'),
                            _buildDetailRow('Tujuan', bus.tujuanBus ?? '-'),
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PemesananTiket()),
          );
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
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          content,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ),
    );
  }
}
