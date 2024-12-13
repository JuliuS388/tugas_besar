import 'dart:convert';

class Ulasan {
  final int id;
  final int idUser;
  final int idPemesanan;
  final double rating;
  final String isiUlasan;
  final String jenisUlasan;

  Ulasan({
    required this.id,
    required this.idUser,
    required this.idPemesanan,
    required this.rating,
    required this.isiUlasan,
    required this.jenisUlasan,
  });

  factory Ulasan.fromRawJson(String str) => Ulasan.fromJson(json.decode(str));

  factory Ulasan.fromJson(Map<String, dynamic> json) => Ulasan(
        id: json["id_ulasan"] ?? 0,
        idUser: json["id_user"] ?? 0,
        idPemesanan: json["id_pemesanan"] ?? 0,
        rating: (json["rating"] ?? 0).toDouble(),
        isiUlasan: json["isi_ulasan"] ?? '',
        jenisUlasan: json["jenis_ulasan"] ?? '',
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id_ulasan": id,
        "id_user": idUser,
        "id_pemesanan": idPemesanan,
        "rating": rating,
        "isi_ulasan": isiUlasan,
        "jenis_ulasan": jenisUlasan,
      };
}