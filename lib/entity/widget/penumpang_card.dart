
import 'package:flutter/material.dart';
import 'package:tugas_besar/entity/pembayaran.entity.dart';

class PenumpangCard extends StatelessWidget {
  final Penumpangs penumpang;

  const PenumpangCard({Key? key, required this.penumpang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildInfoTile("Nama", penumpang.namaPenumpang ?? "-"),
          buildInfoTile("Jenis Kelamin", penumpang.jenisKelamin ?? "-"),
          buildInfoTile("Umur", penumpang.umur != null ? "${penumpang.umur} tahun" : "-"),
          buildInfoTile("Nomor Kursi", penumpang.nomorKursi ?? "-"),
        ],
      ),
    );
  }

  Widget buildInfoTile(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 213, 213, 213),
      ),
      width: 245,
      margin: const EdgeInsets.all(5),
      child: Center(
        child: Text("$label: $value"),
      ),
    );
  }
}
