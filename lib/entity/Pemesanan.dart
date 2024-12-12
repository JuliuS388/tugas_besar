import 'dart:convert';
import 'package:tugas_besar/entity/Jadwal.dart';
import 'package:tugas_besar/entity/Bus.dart';

class Pemesanan {
  int? id; // Primary key dari tabel Pemesanan
  int idUser; // Foreign key dari tabel User
  int idJadwal; // Foreign key dari tabel Jadwal
  DateTime tanggalPemesanan; // Tanggal pemesanan
  double harga; // Harga pemesanan
  Jadwal? jadwal; // Tambahkan field jadwal
  Bus? bus; // Tambahkan field bus

  // Constructor
  Pemesanan({
    this.id, // Nullable, karena di-generate oleh database
    required this.idUser,
    required this.idJadwal,
    required this.tanggalPemesanan,
    required this.harga,
    this.jadwal, // Tambahkan parameter jadwal
    this.bus, // Tambahkan parameter bus
  });

  // Fungsi untuk mengubah Pemesanan menjadi JSON (untuk dikirim ke API)
  Map<String, dynamic> toJson() {
    return {
      "id_pemesanan": id, // Bisa null saat membuat baru
      "id_user": idUser,
      "id_jadwal": idJadwal,
      "tanggal_pemesanan": tanggalPemesanan.toIso8601String(),
      "harga": harga,
      "jadwal": jadwal?.toJson(), // Tambahkan jadwal ke JSON
      "bus": bus?.toJson(), // Tambahkan bus ke JSON
    };
  }

  // Fungsi untuk membuat Pemesanan dari JSON (response dari API)
  factory Pemesanan.fromJson(Map<String, dynamic> json) {
    // Print untuk debug
    print("Raw harga value in Pemesanan: ${json["harga"]}");
    
    // Perbaikan parsing harga
    double harga;
    var rawHarga = json["harga"];
    if (rawHarga is String) {
      harga = double.parse(rawHarga);
    } else if (rawHarga is int) {
      harga = rawHarga.toDouble();
    } else if (rawHarga is double) {
      harga = rawHarga;
    } else {
      harga = 0.0;
    }

    return Pemesanan(
      id: json["id_pemesanan"],
      idUser: json["id_user"],
      idJadwal: json["id_jadwal"],
      tanggalPemesanan: DateTime.parse(json["tanggal_pemesanan"]),
      harga: harga,  // Gunakan nilai yang sudah dikonversi
      jadwal: json["jadwal"] != null ? Jadwal.fromJson(json["jadwal"]) : null,
      bus: json["bus"] != null ? Bus.fromJson(json["bus"]) : null,
    );
  }

  // Fungsi untuk mengubah Pemesanan menjadi raw JSON (string JSON)
  String toRawJson() => json.encode(toJson());
}
