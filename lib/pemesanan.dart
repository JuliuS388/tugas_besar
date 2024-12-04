import 'package:flutter/material.dart';
import 'package:tugas_besar/entity/Bus.dart';
import 'package:tugas_besar/entity/Pemesanan.dart';
import 'package:tugas_besar/client/PemesananClient.dart';
import 'package:tugas_besar/pembayaran.dart';
import 'package:tugas_besar/tokenStorage.dart';

class PemesananTiket extends StatefulWidget {
  final Bus bus;
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
  late int _jumlahPenumpang;
  late List<Map<String, dynamic>> _penumpangs;

  @override
  void initState() {
    super.initState();
    _jumlahPenumpang = widget.jumlahKursi;
    _initializePenumpangs();
  }

  // Inisialisasi daftar penumpang dengan jumlah yang sesuai
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

  // Fungsi untuk mengambil id_user dari SharedPreferences
  Future<int?> getUserId() async {
    // Gunakan metode getUserId dari TokenStorage
    final userId = await TokenStorage.getUserId();

    // Print untuk debugging
    print('Retrieved User ID: $userId');

    return userId;
  }

  // Fungsi untuk mengirim pemesanan
  void _buatPemesanan() async {
    if (_formKey.currentState!.validate()) {
      // Map the list of penumpang to a list of their IDs (assuming each penumpang has a unique ID)
      List<int> penumpangIds = List.generate(
        _penumpangs.length,
        (index) => index + 1, // Replace with actual penumpang IDs if available
      );

      // Ambil id_user dari shared_preferences
      int? userId = await getUserId();
      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User tidak ditemukan. Harap login ulang.')),
        );
        return;
      }

      // Create the Pemesanan object
      Pemesanan pemesanan = Pemesanan(
        id: 1, // Unique ID for pemesanan
        idUser: userId,
        idBus: widget.bus.id,
        namaDestinasi: widget.bus.tujuanBus,
        harga: widget.bus.harga * _jumlahPenumpang,
        tanggalPemesanan: DateTime.now(),
        idPenumpang: penumpangIds, // Pass the list of penumpang IDs
      );

      try {
        var response = await PemesananClient.create(pemesanan);

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Pemesanan berhasil!')),
          );
          // Navigate to payment page if needed
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => PembayaranPage()),
          // );
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
                onPressed: _buatPemesanan, // Mengirimkan pemesanan
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
