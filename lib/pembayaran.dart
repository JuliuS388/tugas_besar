import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String? _selectedBank;

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
          backgroundColor: Colors.blue,
          title: Text("Lanjutkan Pembayaran"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {}), // logika tombol appbar
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.circle),
                  Text("Pilih Metode - "),
                  Icon(Icons.circle),
                  Text("Bayar - "),
                  Icon(Icons.circle),
                  Text("Selesai"),
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
                  _buildBankOption("BCA Virtual Account"),
                  _buildBankOption("Mandiri Virtual Account"),
                  _buildBankOption("BRI Virtual Account"),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 135),
              color: Colors.white,
              width: double.infinity,
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 30),
                    margin: EdgeInsets.only(bottom: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("IDR 200.000"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Action to perform when the button is pressed
                      print("Button pressed!");
                    },
                    child: Container(
                      width: 300,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Bayar Sekarang",
                          style: TextStyle(
                            color:
                                Colors.white, // Change text color for contrast
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBankOption(String bankName) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 213, 213, 213)),
      width: 245,
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Mengatur jarak antara elemen
        children: [
          Row(
            children: [
              Icon(Icons.account_balance),
              SizedBox(width: 8), // Jarak antara icon dan teks
              Text(bankName),
            ],
          ),
          Radio<String>(
            value:
                bankName, // Nilai yang akan disimpan saat radio button dipilih
            groupValue: _selectedBank, // Grup yang sama untuk radio button
            onChanged: (String? value) {
              setState(() {
                _selectedBank = value; // Mengupdate nilai yang dipilih
              });
            },
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MyWidget());
}
