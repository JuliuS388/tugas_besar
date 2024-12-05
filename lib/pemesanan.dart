import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tugas_besar/entity/Bus.dart';
import 'package:tugas_besar/entity/Jadwal.dart';
import 'package:tugas_besar/entity/Pemesanan.dart';
import 'package:tugas_besar/entity/Penumpang.dart';
import 'package:tugas_besar/client/PemesananClient.dart';
import 'package:tugas_besar/client/PenumpangClient.dart';
import 'package:tugas_besar/pembayaran.dart';
import 'package:tugas_besar/tokenStorage.dart';

class PemesananTiket extends StatefulWidget {
  final Bus bus;
  final Jadwal jadwal;
  final int jumlahKursi;

  const PemesananTiket({
    Key? key,
    required this.bus,
    required this.jadwal,
    required this.jumlahKursi,
  }) : super(key: key);

  @override
  _PemesananTiketState createState() => _PemesananTiketState();
}

class _PemesananTiketState extends State<PemesananTiket> {
  final _formKey = GlobalKey<FormState>();
  late int _jumlahPenumpang;
  late List<Map<String, dynamic>> _penumpangs;

  @override
  void initState() {
    super.initState();
    _jumlahPenumpang = widget.jumlahKursi;
    _initializePenumpangs();
  }

  // Initialize the list of passengers
  void _initializePenumpangs() {
    _penumpangs = List.generate(
      _jumlahPenumpang,
      (index) => {
        'nama': '',
        'jenisKelamin': '',
        'umur': 0,
      },
    );
  }

  // Function to get the user id from SharedPreferences
  Future<int?> getUserId() async {
    final userId = await TokenStorage.getUserId();
    return userId;
  }

  // Function to create the booking
  // Fungsi untuk membuat penumpang terlebih dahulu
  Future<List<int>> _buatPenumpang() async {
    List<int> penumpangIds = [];

    for (var penumpang in _penumpangs) {
      // Validate passenger data before creating
      if (penumpang['nama'] == null || penumpang['nama'].isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Nama penumpang tidak boleh kosong')),
        );
        return [];
      }

      if (penumpang['jenisKelamin'] == null ||
          penumpang['jenisKelamin'].isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Jenis kelamin harus dipilih')),
        );
        return [];
      }

      if (penumpang['umur'] == null || penumpang['umur'] <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Umur penumpang tidak valid')),
        );
        return [];
      }

      var penumpangData = {
        "nama": penumpang['nama'],
        "jenis_kelamin": penumpang['jenisKelamin'],
        "umur": penumpang['umur'],
      };

      Penumpang newPenumpang = Penumpang.fromJson(penumpangData);

      try {
        var response = await PenumpangClient.create(newPenumpang);

        if (response.statusCode == 201) {
          var responseData = json.decode(response.body)['data'];
          penumpangIds.add(responseData['id_penumpang']);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Gagal membuat penumpang: ${response.body}')),
          );
          return [];
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saat membuat penumpang: $e')),
        );
        return [];
      }
    }

    return penumpangIds;
  }

// Fungsi untuk membuat pemesanan
  void _buatPemesanan() async {
    print("Pesan Tiket button clicked"); // Debugging line

    if (_formKey.currentState!.validate()) {
      // Hitung total harga
      double totalPrice = widget.jadwal.harga * _jumlahPenumpang;

      // Membuat penumpang terlebih dahulu dan mendapatkan ID penumpang
      List<int> penumpangIds = await _buatPenumpang();

      if (penumpangIds.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal membuat penumpang')),
        );
        return;
      }

      // Mendapatkan ID user
      int? userId = await getUserId();
      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User tidak ditemukan. Harap login ulang.')),
        );
        return;
      }

      // Membuat objek Pemesanan
      Pemesanan pemesanan = Pemesanan(
        id: null, // ID akan di-generate oleh database
        idUser: userId,
        idJadwal: widget.jadwal.idJadwal,
        namaDestinasi: widget.jadwal.tujuan,
        harga: totalPrice,
        tanggalPemesanan: DateTime.now(),
        idPenumpang: penumpangIds,
      );

      try {
        // Membuat pemesanan
        var response = await PemesananClient.create(pemesanan);

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Pemesanan berhasil!')),
          );
          // Navigasi ke halaman pembayaran jika diperlukan
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Pemesanan gagal!')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('Detail Penumpang'),
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: List.generate(_jumlahPenumpang, (index) {
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Detail Penumpang ${index + 1}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text('Nama:',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Nama penumpang tidak boleh kosong';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _penumpangs[index]['nama'] = value;
                                  });
                                },
                              ),
                              SizedBox(height: 10),
                              Text('Jenis Kelamin:',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Row(
                                children: [
                                  Radio<String>(
                                    value: 'Laki-laki',
                                    groupValue: _penumpangs[index]
                                        ['jenisKelamin'],
                                    onChanged: (value) {
                                      setState(() {
                                        _penumpangs[index]['jenisKelamin'] =
                                            value!;
                                      });
                                    },
                                  ),
                                  Text('Laki-laki'),
                                  Radio<String>(
                                    value: 'Perempuan',
                                    groupValue: _penumpangs[index]
                                        ['jenisKelamin'],
                                    onChanged: (value) {
                                      setState(() {
                                        _penumpangs[index]['jenisKelamin'] =
                                            value!;
                                      });
                                    },
                                  ),
                                  Text('Perempuan'),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text('Umur:',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Umur tidak boleh kosong';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _penumpangs[index]['umur'] =
                                        int.tryParse(value) ?? 0;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue.shade900,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: _buatPemesanan, // Trigger the booking
                child: Text(
                  'Pesan Tiket',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
