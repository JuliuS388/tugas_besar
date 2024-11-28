import 'dart:convert';

class Riwayat {
  final int id;
  final int idUser;
  final int idPemesanan;
  final String tanggalTransaksi;

  Riwayat({
    required this.id,
    required this.idUser,
    required this.idPemesanan,
    required this.tanggalTransaksi,
  });

  factory Riwayat.fromRawJson(String str) => Riwayat.fromJson(json.decode(str));

  factory Riwayat.fromJson(Map<String, dynamic> json) => Riwayat(
        id: json["id_riwayat"],
        idUser: json["id_user"],
        idPemesanan: json["id_pemesanan"],
        tanggalTransaksi: json["tanggal_transaksi"],
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id_riwayat": id,
        "id_user": idUser,
        "id_pemesanan": idPemesanan,
        "tanggal_transaksi": tanggalTransaksi,
      };
}
