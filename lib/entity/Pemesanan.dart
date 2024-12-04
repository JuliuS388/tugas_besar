import 'dart:convert';

class Pemesanan {
  final int id;
  final int idUser;
  final int idBus;
  final String namaDestinasi;
  final double harga;
  final DateTime tanggalPemesanan;
  final List<int> idPenumpang; // Menyimpan daftar ID penumpang

  Pemesanan({
    required this.id,
    required this.idUser,
    required this.idBus,
    required this.namaDestinasi,
    required this.harga,
    required this.tanggalPemesanan,
    required this.idPenumpang,
  });

  // Fungsi untuk mengubah Pemesanan menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      "id_pemesanan": id,
      "id_user": idUser,
      "id_bus": idBus,
      "nama_destinasi": namaDestinasi,
      "harga": harga,
      "tanggal_pemesanan": tanggalPemesanan.toIso8601String(),
      "id_penumpang": idPenumpang, // Kirim ID penumpang
    };
  }

  // Fungsi untuk membuat Pemesanan dari JSON
  factory Pemesanan.fromJson(Map<String, dynamic> json) {
    return Pemesanan(
      id: json["id_pemesanan"],
      idUser: json["id_user"],
      idBus: json["id_bus"],
      namaDestinasi: json["nama_destinasi"],
      harga: json["harga"].toDouble(),
      tanggalPemesanan: DateTime.parse(json["tanggal_pemesanan"]),
      idPenumpang: List<int>.from(json["id_penumpang"].map((x) => x)),
    );
  }

  // Fungsi untuk mengubah Pemesanan menjadi raw JSON untuk dikirim
  String toRawJson() => json.encode(toJson());
}
