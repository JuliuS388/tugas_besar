import 'dart:convert';

class Pemesanan {
  final int? id; // ID bisa nullable, karena di-generate oleh database
  final int idUser;
  final int idJadwal;
  final String namaDestinasi;
  final double harga;
  final DateTime tanggalPemesanan;
  final List<int> idPenumpang; // Menyimpan daftar ID penumpang

  Pemesanan({
    this.id, // Tidak perlu required, bisa null karena auto-increment
    required this.idUser,
    required this.idJadwal,
    required this.namaDestinasi,
    required this.harga,
    required this.tanggalPemesanan,
    required this.idPenumpang,
  });

  // Fungsi untuk mengubah Pemesanan menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      "id_user": idUser,
      "id_jadwal": idJadwal,
      "nama_destinasi": namaDestinasi,
      "harga": harga,
      "tanggal_pemesanan": tanggalPemesanan.toIso8601String(),
      "id_penumpang": idPenumpang, // Kirim ID penumpang
    };
  }

  // Fungsi untuk membuat Pemesanan dari JSON
  factory Pemesanan.fromJson(Map<String, dynamic> json) {
    return Pemesanan(
      id: json[
          "id_pemesanan"], // ID akan diterima dari API setelah pemesanan dibuat
      idUser: json["id_user"],
      idJadwal: json["id_jadwal"],
      namaDestinasi: json["nama_destinasi"],
      harga: json["harga"].toDouble(),
      tanggalPemesanan: DateTime.parse(json["tanggal_pemesanan"]),
      idPenumpang: List<int>.from(json["id_penumpang"].map((x) => x)),
    );
  }

  // Fungsi untuk mengubah Pemesanan menjadi raw JSON untuk dikirim
  String toRawJson() => json.encode(toJson());
}
