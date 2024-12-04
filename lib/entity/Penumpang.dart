import 'dart:convert';

class Penumpang {
  final int? idPenumpang;
  final String nama;
  final String jenisKelamin;
  final int umur;

  Penumpang({
    this.idPenumpang, // Changed to optional
    required this.nama,
    required this.jenisKelamin,
    required this.umur,
  });

  factory Penumpang.fromRawJson(String srt) =>
      Penumpang.fromJson(json.decode(srt));

  factory Penumpang.fromJson(Map<String, dynamic> json) {
    return Penumpang(
      idPenumpang: json['id_penumpang'],
      nama: json['nama_penumpang'] ?? json['nama'], // Handle both possible keys
      jenisKelamin: json['jenis_kelamin'],
      umur: json['umur'],
    );
  }

  Map<String, dynamic> toJson() {
    // For creation, omit idPenumpang
    return {
      'nama_penumpang': nama,
      'jenis_kelamin': jenisKelamin,
      'umur': umur,
    };
  }

  String toRawJson() {
    return json.encode(toJson());
  }
}
