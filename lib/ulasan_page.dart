import 'package:flutter/material.dart';
import 'package:tugas_besar/client/UlasanClient.dart';

class UlasanPage extends StatefulWidget {
  final int idPemesanan;
  final int idUser;

  const UlasanPage({
    Key? key,
    required this.idPemesanan,
    required this.idUser,
  }) : super(key: key);

  @override
  _UlasanPageState createState() => _UlasanPageState();
}

class _UlasanPageState extends State<UlasanPage> {
  double rating = 4.0;
  final TextEditingController isiUlasanController = TextEditingController();
  String jenisUlasan = 'supir'; // Default value

  Widget buildRatingRow(double currentRating, Function(double) onRatingSelected) {
    return Row(
      children: List.generate(5, (index) {
        return IconButton(
          onPressed: () {
            onRatingSelected((index + 1).toDouble());
          },
          icon: Icon(
            index < currentRating ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 30,
          ),
        );
      }),
    );
  }

  Future<void> submitUlasan() async {
    if (isiUlasanController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mohon isi ulasan terlebih dahulu')),
      );
      return;
    }

    try {
      final Map<String, dynamic> data = {
        'id_user': widget.idUser,
        'id_pemesanan': widget.idPemesanan,
        'rating': rating.toInt(),
        'isi_ulasan': isiUlasanController.text.trim(),
        'jenis_ulasan': jenisUlasan,
      };

      await UlasanClient.create(data);
      
      if (!mounted) return;
      
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Berhasil'),
          content: const Text('Ulasan berhasil dikirim'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Return to previous screen
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal mengirim ulasan: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ulasan',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Container(
        color: Colors.lightBlue[50],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Jenis Ulasan Dropdown
                      DropdownButtonFormField<String>(
                        value: jenisUlasan,
                        decoration: InputDecoration(
                          labelText: 'Jenis Ulasan',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        items: ['supir', 'fasilitas'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value.toUpperCase()),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            jenisUlasan = newValue!;
                          });
                        },
                      ),
                      SizedBox(height: 20),

                      // Rating
                      Text(
                        'Rating',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      buildRatingRow(rating, (newRating) {
                        setState(() {
                          rating = newRating;
                        });
                      }),
                      SizedBox(height: 20),

                      // Isi Ulasan
                      TextField(
                        controller: isiUlasanController,
                        decoration: InputDecoration(
                          labelText: 'Isi Ulasan',
                          hintText: 'Tulis ulasan Anda',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Tombol Submit
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: submitUlasan,
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
