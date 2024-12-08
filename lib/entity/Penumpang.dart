import 'dart:convert';

class Penumpang {
  int? id; // Primary key dari tabel Penumpang
  String namaPenumpang; // Nama penumpang
  String jenisKelamin; // Jenis kelamin penumpang
  int umur; // Umur penumpang
  int idPemesanan;
  String
      nomorKursi; // Foreign key untuk menghubungkan penumpang dengan pemesanan

  // Constructor
  Penumpang(
      {this.id, // Nullable, karena ID dibuat oleh database
      required this.namaPenumpang,
      required this.jenisKelamin,
      required this.umur,
      required this.idPemesanan,
      required this.nomorKursi // ID pemesanan yang menghubungkan dengan tabel Pemesanan
      });

  // Fungsi untuk mengubah Penumpang menjadi JSON (untuk dikirim ke API)
  Map<String, dynamic> toJson() {
    return {
      "id_penumpang": id, // ID bisa null saat pembuatan baru
      "id_pemesanan": idPemesanan, // ID pemesanan
      "nama_penumpang": namaPenumpang,
      "jenis_kelamin": jenisKelamin,
      "umur": umur,
      "nomor_kursi": nomorKursi
    };
  }

  // Fungsi untuk membuat Penumpang dari JSON (response dari API)
  factory Penumpang.fromJson(Map<String, dynamic> json) {
    return Penumpang(
        id: json["id_penumpang"], // ID penumpang dari API
        namaPenumpang: json["nama_penumpang"], // Nama penumpang dari API
        jenisKelamin: json["jenis_kelamin"], // Jenis kelamin dari API
        umur: json["umur"], // Umur penumpang dari API
        idPemesanan: json["id_pemesanan"],
        nomorKursi: json["nomor_kursi"] // ID pemesanan dari API
        );
  }

  // Fungsi untuk mengubah Penumpang menjadi raw JSON (string JSON)
  String toRawJson() => json.encode(toJson());
}
