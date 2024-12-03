import 'package:flutter/material.dart';
import 'package:tugas_besar/entity/Bus.dart';
import 'package:tugas_besar/pembayaran.dart';

class PemesananTiket extends StatefulWidget {
  final Bus bus; // Change from separate parameters to bus object
  final int jumlahKursi;

  const PemesananTiket({
    Key? key,
    required this.bus,
    required this.jumlahKursi,
  }) : super(key: key);

  @override
  _PemesananTiketState createState() => _PemesananTiketState();
}

class _PemesananTiketState extends State<PemesananTiket> {
  final _formKey = GlobalKey<FormState>();
  late int _jumlahPenumpang; // Remove initialization
  List<Map<String, dynamic>> _penumpangs = [];

  @override
  void initState() {
    super.initState();
    _jumlahPenumpang = widget.jumlahKursi; // Use passed jumlahKursi
    _initializePenumpangs();
  }

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

  void _updateJumlahPenumpang(String value) {
    int newCount = int.tryParse(value) ?? 1;
    setState(() {
      _jumlahPenumpang = newCount;
      _initializePenumpangs();
    });
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
                              // Judul untuk Detail Penumpang
                              Text(
                                'Detail Penumpang ${index + 1}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Nama:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
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
                              Text(
                                'Jenis Kelamin:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
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
                              Text(
                                'Umur:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyWidget()));
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Pemesanan berhasil!')));
                  }
                },
                child: Text(
                  'Pesan Tiket',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
