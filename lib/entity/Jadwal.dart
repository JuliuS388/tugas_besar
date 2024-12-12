import 'dart:convert';
import 'package:tugas_besar/entity/Bus.dart';

class Jadwal {
  int idJadwal;
  DateTime keberangkatan;
  DateTime kedatangan;
  double harga;
  String asal;
  String tujuan;
  Bus bus;

  Jadwal({
    this.idJadwal = 0,
    DateTime? keberangkatan,
    DateTime? kedatangan,
    this.harga = 0.0,
    this.asal = 'Asal Tidak Tersedia',
    this.tujuan = 'Tujuan Tidak Tersedia',
    required this.bus,
  })  : keberangkatan = keberangkatan ?? DateTime.now(),
        kedatangan = kedatangan ?? DateTime.now();

  factory Jadwal.fromRawJson(String str) => Jadwal.fromJson(json.decode(str));

  factory Jadwal.fromJson(Map<String, dynamic> json) {
    return Jadwal(
      idJadwal: json["id_jadwal"] ?? 0,
      keberangkatan: _parseDateTime(json["keberangkatan"]),
      kedatangan: _parseDateTime(json["kedatangan"]),
      harga: double.tryParse(json["harga"].toString()) ?? 0.0,
      asal: json["asal"] ?? 'Asal Tidak Tersedia',
      tujuan: json["tujuan"] ?? 'Tujuan Tidak Tersedia',
      bus: Bus.fromJson(json["bus"]),
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
        "bus": bus.toJson(),
      };

  static DateTime _parseDateTime(dynamic value) {
    if (value == null) return DateTime.now();
    try {
      return DateTime.parse(value.toString());
    } catch (e) {
      return DateTime.now();
    }
  }
}
