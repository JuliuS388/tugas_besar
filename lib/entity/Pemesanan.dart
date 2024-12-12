import 'dart:convert';

class Pemesanan {
  int? id; // Primary key dari tabel Pemesanan
  int idUser; // Foreign key dari tabel User
  int idJadwal; // Foreign key dari tabel Jadwal
  DateTime tanggalPemesanan; // Tanggal pemesanan
  double harga; // Harga pemesanan

  // Constructor
  Pemesanan({
    this.id, // Nullable, karena di-generate oleh database
    required this.idUser,
    required this.idJadwal,
    required this.tanggalPemesanan,
    required this.harga,
  });

  // Fungsi untuk mengubah Pemesanan menjadi JSON (untuk dikirim ke API)
  Map<String, dynamic> toJson() {
    return {
      "id_pemesanan": id, // Bisa null saat membuat baru
      "id_user": idUser,
      "id_jadwal": idJadwal,
      "tanggal_pemesanan": tanggalPemesanan.toIso8601String(),
      "harga": harga,
    };
  }

  // Fungsi untuk membuat Pemesanan dari JSON (response dari API)
  factory Pemesanan.fromJson(Map<String, dynamic> json) {
    return Pemesanan(
      id: json["id_pemesanan"], // ID pemesanan dari API
      idUser: json["id_user"],
      idJadwal: json["id_jadwal"],
      tanggalPemesanan: DateTime.parse(json["tanggal_pemesanan"]),
      harga: json["harga"].toDouble(),
    );
  }

  // Fungsi untuk mengubah Pemesanan menjadi raw JSON (string JSON)
  String toRawJson() => json.encode(toJson());
}
