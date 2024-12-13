import 'package:flutter/material.dart';
import 'package:tugas_besar/entity/Penumpang.dart';
import 'package:tugas_besar/entity/Pemesanan.dart';
import 'package:tugas_besar/entity/Ticket.dart';
import 'package:tugas_besar/client/PenumpangClient.dart';
import 'package:tugas_besar/client/PemesananClient.dart';
import 'package:tugas_besar/client/TicketClient.dart';
import 'package:tugas_besar/home.dart';
import 'package:tugas_besar/tokenStorage.dart';
import 'dart:ui';
import 'dart:math';

class DetailPenumpang extends StatefulWidget {
  final int idPemesanan;
  final int jumlahKursi;
  final Pemesanan pemesanan;

  const DetailPenumpang({
    super.key,
    required this.pemesanan,
    required this.idPemesanan,
    required this.jumlahKursi,
  });

  @override
  _DetailPenumpangState createState() => _DetailPenumpangState();
}

Future<int?> getUserId() async {
  final userId = await TokenStorage.getUserId();
  print("User ID yang didapat: $userId");
  return userId;
}

class _DetailPenumpangState extends State<DetailPenumpang> {
  final _formKey = GlobalKey<FormState>();
  late int _jumlahPenumpang;
  late List<Map<String, dynamic>> _penumpangs;
  bool _isLoading = false; // Track loading state
  Set<String> generatedSeatNumbers = {};

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
        'nomorKursi': _generateUniqueSeatNumber(),
      },
    );
  }

  // Function to generate a random unique seat number
  String _generateUniqueSeatNumber() {
    Random random = Random();
    String seatNumber;
    List<String> letters = ['A', 'B', 'C', 'D'];
    int number;

    // Keep generating until we get a unique number
    do {
      String letter = letters[random.nextInt(letters.length)];
      number = random.nextInt(10) + 1; // Random number between 1 and 10
      seatNumber = '$letter$number';
    } while (generatedSeatNumbers.contains(seatNumber));

    // Add the generated seat number to the set to track uniqueness
    generatedSeatNumbers.add(seatNumber);
    return seatNumber;
  }

  // Function to get the user id from SharedPreferences
  Future<int?> getUserId() async {
    final userId = await TokenStorage.getUserId();
    return userId;
  }

  // Function to create passengers
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

      // Buat objek penumpang
      var penumpangData = Penumpang(
        namaPenumpang: penumpang['nama'],
        jenisKelamin: penumpang['jenisKelamin'],
        umur: penumpang['umur'],
        idPemesanan: pemesananId,
        nomorKursi: penumpang['nomorKursi'],
      );

      try {
        // Panggil API untuk membuat penumpang
        var createdPenumpang = await PenumpangClient.create(penumpangData);

        // Simpan ID penumpang
        penumpangIds.add(createdPenumpang.id!);

        // Dapatkan `idUser` dari token storage
        final userId = await getUserId();

        // Buat tiket berdasarkan penumpang yang berhasil dibuat
        var tiket = Ticket(
          user_id: userId!,
          pemesanan_id: widget.idPemesanan,
          penumpang_id: createdPenumpang.id!,
          pemesanan: widget.pemesanan,
          penumpang: createdPenumpang,
        );

        // Debug print sebelum membuat ticket
        print('Creating ticket with data: ${tiket.toJson()}');

        try {
          await TicketClient.create(tiket);
        } catch (e) {
          print("Error creating ticket: $e");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error saat membuat tiket: $e')),
          );
        }
      } catch (e) {
        print("Exception occurred: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error saat membuat penumpang atau tiket: $e')),
        );
        return [];
      }
    }

    return penumpangIds;
  }

  // Function to show confirmation dialog before payment
  void _showConfirmationDialog(
      BuildContext context, List<Map<String, dynamic>> penumpangs) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Konfirmasi Data Penumpang',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.blue.shade900),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: List.generate(penumpangs.length, (index) {
                var penumpang = penumpangs[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    elevation: 4.0,
                    shadowColor: Colors.blue.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.person_outline,
                            color: Colors.blue.shade700,
                            size: 30,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Penumpang ${index + 1}',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade700),
                              ),
                              SizedBox(height: 6),
                              Row(
                                children: [
                                  SizedBox(width: 5),
                                  Text('Nama: ${penumpang['nama']}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.blue.shade600)),
                                ],
                              ),
                              SizedBox(height: 6),
                              Row(
                                children: [
                                  SizedBox(width: 5),
                                  Text(
                                      'Jenis Kelamin: ${penumpang['jenisKelamin']}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.blue.shade600)),
                                ],
                              ),
                              SizedBox(height: 6),
                              Row(
                                children: [
                                  SizedBox(width: 5),
                                  Text('Umur: ${penumpang['umur']}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.blue.shade600)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  Text('Batal', style: TextStyle(color: Colors.blue.shade900)),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                List<int> penumpangIds =
                    await _buatPenumpang(widget.idPemesanan);
                if (penumpangIds.isNotEmpty) {
                  // Navigate to PembayaranScreen with idPemesanan
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         PembayaranScreen(idPemesanan: widget.idPemesanan),
                  //   ),
                  // );
                }
              },
              child: Text('Lanjut Pembayaran'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  // Show confirmation dialog for cancellation
  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 30),
              SizedBox(width: 10),
              Text(
                'Konfirmasi Pembatalan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text(
            'Apakah Anda yakin ingin membatalkan pemesanan ini? Tindakan ini tidak dapat dibatalkan.',
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Batal',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                try {
                  PemesananClient.destroy(widget.idPemesanan);
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomeView()),
                  );
                } catch (e) {
                  print("Error occurred while deleting: $e");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Ya, Batalkan',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  // Handle back navigation to show cancel confirmation dialog
  Future<bool> _onWillPop() async {
    _showCancelDialog(context);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          title: Text('Detail Penumpang'),
          backgroundColor: Colors.blue.shade900,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              _showCancelDialog(context);
            },
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      'Silakan Mengisi Data Penumpang',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ),
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
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
                                    Text('Nama:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Row(
                                      children: [
                                        Radio<String>(
                                          value: 'Laki-laki',
                                          groupValue: _penumpangs[index]
                                              ['jenisKelamin'],
                                          onChanged: (value) {
                                            setState(() {
                                              _penumpangs[index]
                                                  ['jenisKelamin'] = value!;
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
                                              _penumpangs[index]
                                                  ['jenisKelamin'] = value!;
                                            });
                                          },
                                        ),
                                        Text('Perempuan'),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Text('Umur:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                    SizedBox(height: 10),
                                    Text(
                                        'Nomor Kursi: ${_penumpangs[index]['nomorKursi']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
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
                        setState(() {
                          _isLoading = true;
                        });

                        // Show confirmation dialog
                        _showConfirmationDialog(context, _penumpangs);

                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    ),
                    child: Text(
                      'Lanjut Pembayaran',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Show loading indicator with blurred background
            if (_isLoading)
              Positioned.fill(
                child: Stack(
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
