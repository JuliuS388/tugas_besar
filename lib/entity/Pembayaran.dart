import 'dart:convert';

class Pembayaran {
  final int id;
  final int idPemesanan;
  final String metodePembayaran;

  Pembayaran({
    required this.id,
    required this.idPemesanan,
    required this.metodePembayaran,
  });

  factory Pembayaran.fromRawJson(String str) =>
      Pembayaran.fromJson(json.decode(str));

  factory Pembayaran.fromJson(Map<String, dynamic> json) => Pembayaran(
        id: json["id_pembayaran"],
        idPemesanan: json["id_pemesanan"],
        metodePembayaran: json["metode_pembayaran"],
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id_pembayaran": id,
        "id_pemesanan": idPemesanan,
        "metode_pembayaran": metodePembayaran,
      };
}
