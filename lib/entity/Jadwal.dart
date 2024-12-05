import 'dart:convert';
import 'package:tugas_besar/entity/Bus.dart';

class Jadwal {
  int idJadwal;
  DateTime keberangkatan;
  DateTime kedatangan;
  double harga;
  String asal;
  String tujuan;
  Bus bus; // Add bus as an object

  Jadwal({
    this.idJadwal = 0,
    DateTime? keberangkatan,
    DateTime? kedatangan,
    this.harga = 0.0,
    this.asal = 'Asal Tidak Tersedia',
    this.tujuan = 'Tujuan Tidak Tersedia',
    required this.bus, // Required bus object
  })  : keberangkatan = keberangkatan ?? DateTime.now(),
        kedatangan = kedatangan ?? DateTime.now();

  factory Jadwal.fromRawJson(String str) => Jadwal.fromJson(json.decode(str));

  factory Jadwal.fromJson(Map<String, dynamic> json) {
    return Jadwal(
      idJadwal: json["id_jadwal"] ?? 0,
      keberangkatan:
          DateTime.parse(json["keberangkatan"] ?? DateTime.now().toString()),
      kedatangan:
          DateTime.parse(json["kedatangan"] ?? DateTime.now().toString()),
      harga: double.tryParse(json["harga"].toString()) ?? 0.0,
      asal: json["asal"] ?? 'Asal Tidak Tersedia',
      tujuan: json["tujuan"] ?? 'Tujuan Tidak Tersedia',
      bus: Bus.fromJson(json["bus"]), // Create bus object from JSON
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id_jadwal": idJadwal,
        "keberangkatan": keberangkatan.toIso8601String(),
        "kedatangan": kedatangan.toIso8601String(),
        "harga": harga,
        "asal": asal,
        "tujuan": tujuan,
        "bus": bus.toJson(), // Convert bus object to JSON
      };
}
