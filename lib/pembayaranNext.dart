import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class Pembayarannext extends StatefulWidget {
  final String? selectedBank;

  Pembayarannext({Key? key, this.selectedBank}) : super(key: key);
  @override
  State<Pembayarannext> createState() => _MyWidgetState();
}

class CountdownContainer extends StatefulWidget {
  @override
  _CountdownContainerState createState() => _CountdownContainerState();
}

class _CountdownContainerState extends State<CountdownContainer> {
  int _start = 1; // 5 menit dalam detik
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start > 0) {
        setState(() {
          _start--;
        });
      } else {
        _timer?.cancel(); // Hentikan timer ketika mencapai 0
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Pastikan untuk membatalkan timer saat widget dibuang
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Menghitung menit dan detik
    int minutes = (_start ~/ 60);
    int seconds = _start % 60;

    return Container(
      margin: EdgeInsets.only(top: 10),
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, // Mengatur jarak antara kedua teks
          children: [
            Text("Selesaikan Dalam"),
            Text(
              '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}', // Menampilkan hitungan mundur dalam format mm:ss
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyWidgetState extends State<Pembayarannext> {
  final List<String> dateTimes = [
    "Pergi Rabu, 16 Okt 2024 - 14:55",
    "Yogyakarta -> Jakarta",
    "Handoyo Bus"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: const Color.fromARGB(255, 198, 237, 255),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text(
          "Lanjutkan Pembayaran",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      body: SingleChildScrollView(
        // Tambahkan SingleChildScrollView di sini
        child: Column(
          children: [
            // Konten lainnya tetap sama
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
            Container(
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: dateTimes.map((dateTime) {
                  return Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 213, 213, 213)),
                    width: 245,
                    margin: EdgeInsets.all(5),
                    child: Center(
                      // Menambahkan Center untuk meratakan teks
                      child: Text(dateTime),
                    ),
                  );
                }).toList(), // Mengonversi iterable ke list
              ),
            ),
            Container(
              child: CountdownContainer(),
            ),
            Container(
              width: 300,
              height: 270,
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
                    child: Column(
                      children: [
                        Row(children: [
                          Text(
                            "Metode Pembayaran",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ]),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical:
                                        5), // Set vertical margin (top and bottom)
                                child: Text(
                                  widget.selectedBank ??
                                      "BCA Virtual", // Menampilkan bank yang dipilih atau default
                                  style: TextStyle(
                                      fontSize:
                                          12), // Optional: You can adjust the font size if needed
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 213, 213, 213),
                          ),
                          width: 245,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Mengatur jarak antara elemen
                            children: [
                              Expanded(
                                // Menggunakan Expanded agar teks dapat mengambil ruang yang tersedia
                                child: Text(
                                  "347 583 478 225",
                                  overflow: TextOverflow
                                      .ellipsis, // Menambahkan overflow jika teks terlalu panjang
                                ),
                              ),
                              IconButton(
                                icon:
                                    Icon(Icons.copy), // Ikon untuk tombol salin
                                onPressed: () {
                                  // Logika untuk menyalin teks
                                  Clipboard.setData(ClipboardData(
                                          text: "347 583 478 225"))
                                      .then((_) {
                                    // Tampilkan snackbar atau notifikasi jika perlu
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Teks disalin ke clipboard!')),
                                    );
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                          width: 245,
                          height: 2,
                          color: const Color.fromARGB(255, 213, 213, 213),
                        ),
                        Container(
                          child: Column(children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Total Pembayaran",
                                style: TextStyle(fontSize: 12),
                              ),
                            )
                          ]),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 213, 213, 213)),
                          width: 245,
                          child: Text("IDR 200.000"),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 50,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.amber[400]),
                          width: 245,
                          child: Row(
                            children: [
                              Icon(Icons.warning_amber),
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                width: 180,
                                height: 50,
                                child: Text(
                                  "Selesaikan Pembayaran ini sebelum memilih Virtual Account untuk pembayaran selanjutnya",
                                  style: TextStyle(fontSize: 10),
                                  maxLines: 3,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 300,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Align(
                      alignment:
                          Alignment.centerLeft, // Mengatur posisi teks ke kiri
                      child: Text(
                        "Cara Membayar",
                        style: TextStyle(
                            fontWeight: FontWeight
                                .bold), // Anda dapat menambahkan gaya teks di sini
                        textAlign: TextAlign.left, // Menyelaraskan teks ke kiri
                      ),
                    ),
                  ),
                  Container(
                    width: 280,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey, // Warna garis tepi
                        width: 1, // Ketebalan garis tepi
                      ),
                      borderRadius: BorderRadius.circular(
                          10), // Menambahkan sudut membulat (opsional)
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Align(
                            alignment: Alignment
                                .centerLeft, // Mengatur posisi teks ke kiri
                            child: Text(
                              "Detail Cara Pembayaran",
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .bold), // Anda dapat menambahkan gaya teks di sini
                              textAlign:
                                  TextAlign.left, // Menyelaraskan teks ke kiri
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Align(
                            alignment: Alignment
                                .centerLeft, // Mengatur posisi teks ke kiri
                            child: Text(
                              "Untuk membayar tiket menggunakan BCA, Anda bisa melakukan pembayaran dengan Virtual Account BCA ",
                              style: TextStyle(
                                  fontSize:
                                      10), // Anda dapat menambahkan gaya teks di sini
                              textAlign:
                                  TextAlign.left, // Menyelaraskan teks ke kiri
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Align(
                            alignment: Alignment
                                .centerLeft, // Mengatur posisi teks ke kiri
                            child: Text(
                              "1. Login ke BCA mobile",
                              style: TextStyle(
                                  fontSize:
                                      10), // Anda dapat menambahkan gaya teks di sini
                              textAlign:
                                  TextAlign.left, // Menyelaraskan teks ke kiri
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Align(
                            alignment: Alignment
                                .centerLeft, // Mengatur posisi teks ke kiri
                            child: Text(
                              "2. Pilih m-Transfer dan pilih BCA Virtual Account",
                              style: TextStyle(
                                  fontSize:
                                      10), // Anda dapat menambahkan gaya teks di sini
                              textAlign:
                                  TextAlign.left, // Menyelaraskan teks ke kiri
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Align(
                            alignment: Alignment
                                .centerLeft, // Mengatur posisi teks ke kiri
                            child: Text(
                              "3. Masukkan nomor Virtual Account BCA dan klik Send",
                              style: TextStyle(
                                  fontSize:
                                      10), // Anda dapat menambahkan gaya teks di sini
                              textAlign:
                                  TextAlign.left, // Menyelaraskan teks ke kiri
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Align(
                            alignment: Alignment
                                .centerLeft, // Mengatur posisi teks ke kiri
                            child: Text(
                              "4. Masukkan nominal",
                              style: TextStyle(
                                  fontSize:
                                      10), // Anda dapat menambahkan gaya teks di sini
                              textAlign:
                                  TextAlign.left, // Menyelaraskan teks ke kiri
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Align(
                            alignment: Alignment
                                .centerLeft, // Mengatur posisi teks ke kiri
                            child: Text(
                              "5. Cek detail transaksi, klik OK",
                              style: TextStyle(
                                  fontSize:
                                      10), // Anda dapat menambahkan gaya teks di sini
                              textAlign:
                                  TextAlign.left, // Menyelaraskan teks ke kiri
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Align(
                            alignment: Alignment
                                .centerLeft, // Mengatur posisi teks ke kiri
                            child: Text(
                              "6. Masukkan PIN dan transaksi berhasil ",
                              style: TextStyle(
                                  fontSize:
                                      10), // Anda dapat menambahkan gaya teks di sini
                              textAlign:
                                  TextAlign.left, // Menyelaraskan teks ke kiri
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

void main() {
  runApp(Pembayarannext());
}
