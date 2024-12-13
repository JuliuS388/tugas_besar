import 'dart:convert';

class Penumpang {
  int? id;
  String? namaPenumpang;
  String? jenisKelamin;
  int? umur;
  int? idPemesanan;
  String? nomorKursi;

  Penumpang({
    this.id,
    this.namaPenumpang,
    this.jenisKelamin,
    this.umur,
    this.idPemesanan,
    this.nomorKursi,
  });

  factory Penumpang.fromJson(Map<String, dynamic> json) {
    return Penumpang(
      id: json['id_penumpang'],
      namaPenumpang: json['nama_penumpang'],
      jenisKelamin: json['jenis_kelamin'],
      umur: json['umur'],
      idPemesanan: json['id_pemesanan'],
      nomorKursi: json['nomor_kursi'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_penumpang': id,
      'nama_penumpang': namaPenumpang,
      'jenis_kelamin': jenisKelamin,
      'umur': umur,
      'id_pemesanan': idPemesanan,
      'nomor_kursi': nomorKursi,
    };
  }

  String toRawJson() => json.encode(toJson());
}
