import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tugas_besar/entity/Bus.dart';
import 'package:tugas_besar/entity/Jadwal.dart';
import 'package:tugas_besar/entity/Pemesanan.dart';
import 'package:tugas_besar/entity/Penumpang.dart';
import 'package:tugas_besar/client/PemesananClient.dart';
import 'package:tugas_besar/client/PenumpangClient.dart';
import 'package:tugas_besar/tokenStorage.dart';

class DetailPenumpang extends StatefulWidget {
  final int idPemesanan;
  final int jumlahKursi;

  const DetailPenumpang({
    super.key,
    required this.idPemesanan,
    required this.jumlahKursi,
  });

  @override
  _DetailPenumpangState createState() => _DetailPenumpangState();
}

class _DetailPenumpangState extends State<DetailPenumpang> {
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

  // Fungsi untuk membuat penumpang
  Future<List<int>> _buatPenumpang(int pemesananId) async {
    List<int> penumpangIds = [];

    for (var penumpang in _penumpangs) {
      // Validasi data penumpang
      if (penumpang['nama'] == null || penumpang['nama'].isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nama penumpang tidak boleh kosong')),
        );
        return [];
      }

      if (penumpang['jenisKelamin'] == null ||
          penumpang['jenisKelamin'].isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Jenis kelamin harus dipilih')),
        );
        return [];
      }

      if (penumpang['umur'] == null || penumpang['umur'] <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Umur penumpang tidak valid')),
        );
        return [];
      }

      var penumpangData = {
        "nama_penumpang": penumpang['nama'],
        "jenis_kelamin": penumpang['jenisKelamin'],
        "umur": penumpang['umur'],
        "id_pemesanan": pemesananId,
      };

      try {
        var response =
            await PenumpangClient.create(Penumpang.fromJson(penumpangData));

        if (response.statusCode == 201) {
          var responseData = json.decode(response.body)['data'];
          penumpangIds.add(responseData['id_penumpang']);
        } else {
          print("Error response: ${response.body}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Gagal membuat penumpang: ${response.body}')),
          );
          return [];
        }
      } catch (e) {
        print("Exception occurred: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saat membuat penumpang: $e')),
        );
        return [];
      }
    }

    return penumpangIds;
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
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, create passengers
                  List<int> penumpangIds =
                      await _buatPenumpang(widget.idPemesanan);

                  if (penumpangIds.isNotEmpty) {
                    // Navigate to the payment screen
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         PaymentScreen(penumpangIds: penumpangIds),
                    //   ),
                    // );
                  }
                }
              },
              child: Text('Lanjut Pembayaran'),
            ),
          ],
        ),
      ),
    );
  }
}
