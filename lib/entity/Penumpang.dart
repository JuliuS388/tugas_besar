import 'dart:convert';

class Penumpang {
  int idPenumpang;
  String namaPenumpang;
  String jenisKelamin;
  int umur;

  Penumpang({
    required this.idPenumpang,
    required this.namaPenumpang,
    required this.jenisKelamin,
    required this.umur,
  });

  factory Penumpang.fromRawJson(String str) =>
      Penumpang.fromJson(json.decode(str));

  factory Penumpang.fromJson(Map<String, dynamic> json) => Penumpang(
        idPenumpang: json["id_penumpang"],
        namaPenumpang: json["nama"],
        jenisKelamin: json["jenis_kelamin"],
        umur: json["umur"],
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id_penumpang": idPenumpang,
        "nama": namaPenumpang,
        "jenis_kelamin": jenisKelamin,
        "umur": umur,
      };
}
