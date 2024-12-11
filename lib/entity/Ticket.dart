import 'dart:convert';
import 'package:tugas_besar/entity/Bus.dart';
import 'package:tugas_besar/entity/Jadwal.dart';
import 'package:tugas_besar/entity/Pemesanan.dart';
import 'package:tugas_besar/entity/Penumpang.dart';

class Tiket {
  int? idTiket; // ID Tiket
  int? idUser;
  Pemesanan pemesanan; // Referensi ke Pemesanan
  Penumpang penumpang; // Referensi ke Penumpang
  Jadwal jadwal; // Referensi ke Jadwal

  // Constructor
  Tiket({
    this.idTiket,
    required this.pemesanan,
    required this.penumpang,
    this.idUser,
    required this.jadwal,
  });

  // Fungsi untuk membuat Tiket dari JSON (response dari API)
  factory Tiket.fromJson(Map<String, dynamic> json) {
    return Tiket(
      idTiket: json["id_tiket"],
      pemesanan: Pemesanan.fromJson(json["pemesanan"]),
      penumpang: Penumpang.fromJson(json["penumpang"]),
      idUser: json["id_user"],
      jadwal: Jadwal.fromJson(json["jadwal"]),
    );
  }

  // Fungsi untuk mengubah Tiket menjadi JSON (untuk dikirim ke API)
  Map<String, dynamic> toJson() {
    return {
      "id_tiket": idTiket,
      "pemesanan": pemesanan.toJson(),
      "penumpang": penumpang.toJson(),
      "id_user": idUser,
      "jadwal": jadwal.toJson(),
    };
  }

  // Fungsi untuk mengubah Tiket menjadi raw JSON (string JSON)
  String toRawJson() => json.encode(toJson());

  // Fungsi untuk membuat Tiket dari raw JSON (string JSON)
  factory Tiket.fromRawJson(String str) => Tiket.fromJson(json.decode(str));
}
