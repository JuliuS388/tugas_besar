import 'package:tugas_besar/entity/Pemesanan.dart';
import 'dart:convert';

class Riwayat {
  int? id;
  int idUser;
  int idPemesanan;

  Riwayat({
    this.id,
    required this.idUser,
    required this.idPemesanan,
  });

  factory Riwayat.fromRawJson(String str) => Riwayat.fromJson(json.decode(str));

  factory Riwayat.fromJson(Map<String, dynamic> json) => Riwayat(
        id: json["id_riwayat"],
        idUser: json["id_user"],
        idPemesanan: json["id_pemesanan"],
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id_riwayat": id,
        "id_user": idUser,
        "id_pemesanan": idPemesanan,
      };
}
