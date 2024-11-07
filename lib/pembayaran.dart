import 'package:flutter/material.dart';

class PembayaranPage extends StatefulWidget {
  @override
  _PembayaranPageState createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  // Variabel untuk menyimpan status pemilihan metode pembayaran
  bool _bcaSelected = true;
  bool _mandiriSelected = false;
  bool _briSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigasi kembali atau tutup layar
            Navigator.pop(context);
          },
        ),
        title: const Text('Lanjutkan Pembayaran'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: const Text(
                '1 Pilih Metode - 2 Bayar - 3 Selesai',
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Detail Tiket
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gunakan TextButton untuk tombol "Pergi"
                  TextButton(
                    onPressed: () {
                      // Aksi ketika tombol "Pergi" ditekan
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 4, 6, 7),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 12.0),
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Pergi Rab, 16 Okt 2024 • 14:55'),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Yogyakarta -> Jakarta',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Handoyo Bus',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Kursi D5',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Pilih Metode Pembayaran',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              children: [
                ListTile(
                  title: const Text('BCA'),
                  leading: Radio(
                    value: true,
                    groupValue: _bcaSelected,
                    onChanged: (value) {
                      setState(() {
                        _bcaSelected = value!;
                        _mandiriSelected = false;
                        _briSelected = false;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Mandiri'),
                  leading: Radio(
                    value: true,
                    groupValue: _mandiriSelected,
                    onChanged: (value) {
                      setState(() {
                        _mandiriSelected = value!;
                        _bcaSelected = false;
                        _briSelected = false;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('BRI'),
                  leading: Radio(
                    value: true,
                    groupValue: _briSelected,
                    onChanged: (value) {
                      setState(() {
                        _briSelected = value!;
                        _bcaSelected = false;
                        _mandiriSelected = false;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Tangani konfirmasi pembayaran
                },
                child: const Text('Konfirmasi Pembayaran'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PembayaranPage(),
  ));
}
