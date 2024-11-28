import 'package:flutter/material.dart';

class UlasanPage extends StatefulWidget {
  @override
  _UlasanPageState createState() => _UlasanPageState();
}

class _UlasanPageState extends State<UlasanPage> {
  int ratingSupir = 4; // Default rating supir
  int ratingFasilitas = 4; // Default rating fasilitas
  final TextEditingController ulasanSupirController = TextEditingController();
  final TextEditingController ulasanFasilitasController = TextEditingController();

  Widget buildRatingRow(int currentRating, Function(int) onRatingSelected) {
    return Row(
      children: List.generate(5, (index) {
        return IconButton(
          onPressed: () {
            onRatingSelected(index + 1); // Update rating saat bintang diklik
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ulasan'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        color: Colors.lightBlue[50],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              // Supir Bus
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Supir Bus',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      buildRatingRow(ratingSupir, (rating) {
                        setState(() {
                          ratingSupir = rating;
                        });
                      }),
                      SizedBox(height: 10),
                      TextField(
                        controller: ulasanSupirController,
                        decoration: InputDecoration(
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

              // Fasilitas Bus
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fasilitas Bus',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      buildRatingRow(ratingFasilitas, (rating) {
                        setState(() {
                          ratingFasilitas = rating;
                        });
                      }),
                      SizedBox(height: 10),
                      TextField(
                        controller: ulasanFasilitasController,
                        decoration: InputDecoration(
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
                  backgroundColor: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: () {
                  // Menampilkan dialog pop-up
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Berhasil Memberi Ulasan'),
                      content: Text('Terima kasih atas ulasan Anda.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Tutup dialog
                            Navigator.pop(context); // Kembali ke halaman sebelumnya
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
