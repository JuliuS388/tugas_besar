import 'package:flutter/material.dart';

class UlasanPage extends StatefulWidget {
  @override
  _UlasanPageState createState() => _UlasanPageState();
}

class _UlasanPageState extends State<UlasanPage> {
  double ratingSupir = 4.0;
  double ratingFasilitas = 4.0;
  final TextEditingController ulasanSupirController = TextEditingController();
  final TextEditingController ulasanFasilitasController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ulasan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Supir Bus'),
            Slider(
              value: ratingSupir,
              min: 1,
              max: 5,
              divisions: 4,
              label: ratingSupir.toString(),
              onChanged: (value) {
                setState(() {
                  ratingSupir = value;
                });
              },
            ),
            TextField(
              controller: ulasanSupirController,
              decoration: InputDecoration(
                labelText: 'Tulis ulasan Anda',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            Text('Fasilitas Bus'),
            Slider(
              value: ratingFasilitas,
              min: 1,
              max: 5,
              divisions: 4,
              label: ratingFasilitas.toString(),
              onChanged: (value) {
                setState(() {
                  ratingFasilitas = value;
                });
              },
            ),
            TextField(
              controller: ulasanFasilitasController,
              decoration: InputDecoration(
                labelText: 'Tulis ulasan Anda',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Berhasil Memberi Ulasan'),
                    content: Text('Terima kasih atas ulasan Anda.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
