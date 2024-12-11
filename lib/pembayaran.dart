import 'package:flutter/material.dart';
import 'package:tugas_besar/pembayaranNext.dart';

class Pembayaran extends StatefulWidget {
  final int idPemesanan; // Hanya menerima idPemesanan

  // Konstruktor untuk menerima idPemesanan
  const Pembayaran({
    Key? key,
    required this.idPemesanan,
  }) : super(key: key);

  @override
  State<Pembayaran> createState() => _PembayaranState();
}

class _PembayaranState extends State<Pembayaran> {
  String? _selectedBank;

  // Variabel untuk menyimpan data penumpang berdasarkan idPemesanan
  late String nama;
  late String jenisKelamin;
  late int umur;
  late String nomorKursi;

  final List<String> dateTimes = [
    "Pergi Rabu, 16 Okt 2024 - 14:55",
    "Yogyakarta -> Jakarta",
    "Handoyo Bus"
  ];

  // Fungsi untuk mengambil data penumpang berdasarkan idPemesanan
  void _getPenumpangData() {
    // Mengambil data berdasarkan idPemesanan
    // Data ini bisa berasal dari API, database, atau sumber lokal
    // Misalnya, jika idPemesanan = 1, kita bisa memberikan data dummy:
    if (widget.idPemesanan == 1) {
      nama = 'John Doe';
      jenisKelamin = 'Laki-laki';
      umur = 30;
      nomorKursi = 'A1';
    } else {
      // Data lainnya bisa diambil dengan cara yang serupa
      nama = 'Jane Smith';
      jenisKelamin = 'Perempuan';
      umur = 25;
      nomorKursi = 'B2';
    }
  }

  @override
  void initState() {
    super.initState();
    _getPenumpangData(); // Mengambil data penumpang berdasarkan idPemesanan
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: const Color.fromARGB(255, 198, 237, 255),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title:
            Text("Lanjutkan Pembayaran", style: TextStyle(color: Colors.white)),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }), // logika tombol appbar
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Menampilkan tahapan pembayaran
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("  1. Pilih Metode"),
                  Text("  - "),
                  Text("2. Bayar"),
                  Text("  -  "),
                  Text("3. Selesai"),
                ],
              ),
            ),

            // Menampilkan informasi pemesanan
            Container(
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 213, 213, 213)),
                    width: 245,
                    margin: EdgeInsets.all(5),
                    child: Center(
                      child: Text("Nama: $nama"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 213, 213, 213)),
                    width: 245,
                    margin: EdgeInsets.all(5),
                    child: Center(
                      child: Text("Jenis Kelamin: $jenisKelamin"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 213, 213, 213)),
                    width: 245,
                    margin: EdgeInsets.all(5),
                    child: Center(
                      child: Text("Umur: $umur tahun"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 213, 213, 213)),
                    width: 245,
                    margin: EdgeInsets.all(5),
                    child: Center(
                      child: Text("Nomor Kursi: $nomorKursi"),
                    ),
                  ),
                ],
              ),
            ),

            // Pilih metode pembayaran
            Container(
              width: 300,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.fromLTRB(0, 10, 0, 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    width: 245,
                    child: Text(
                      "Metode Pembayaran",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  _buildBankOption(
                      "assets/images/BCA.png", "BCA Virtual Account"),
                  _buildBankOption(
                      "assets/images/Mandiri.png", "Mandiri Virtual Account"),
                  _buildBankOption(
                      "assets/images/BRI.png", "BRI Virtual Account"),
                ],
              ),
            ),

            // Menampilkan informasi tagihan dan tombol bayar
            Container(
              width: 300,
              margin: EdgeInsets.only(top: 100),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min, // Mengatur ukuran kolom agar tidak mengambil ruang penuh
                children: [
                  // Menampilkan informasi IDR
                  Container(
                    padding: EdgeInsets.only(left: 30, top: 20),
                    margin: EdgeInsets.only(bottom: 1),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("IDR 200.000"),
                    ),
                  ),
                  // Tombol Bayar Sekarang
                  Container(
                    width: 300,
                    margin: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: _selectedBank != null
                          ? () {
                              // Navigate to the next payment page with the selected bank
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pembayarannext(
                                      selectedBank: _selectedBank),
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedBank != null
                            ? Colors.blue.shade900
                            : Colors.grey, // Change color based on selection
                        padding: const EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Bayar Sekarang",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  // Fungsi untuk membuat opsi bank
  Widget _buildBankOption(String img, String bankName) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 213, 213, 213)),
      width: 245,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                img,
                width: 25,
                height: 35,
              ),
              SizedBox(width: 8),
              Text(bankName),
            ],
          ),
          Radio<String>(
            value: bankName,
            groupValue: _selectedBank,
            onChanged: (String? value) {
              setState(() {
                _selectedBank = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(Pembayaran(
    idPemesanan: 1, // Contoh idPemesanan
  ));
}
