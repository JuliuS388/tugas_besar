import 'dart:convert';

class Invoice {
  final int id;
  final int idPembayaran;
  final int idPemesanan;

  Invoice({
    required this.id,
    required this.idPembayaran,
    required this.idPemesanan,
  });

  factory Invoice.fromRawJson(String str) => Invoice.fromJson(json.decode(str));

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        id: json["id_invoice"],
        idPembayaran: json["id_pembayaran"],
        idPemesanan: json["id_pemesanan"],
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id_inovice": id,
        "id_pembayaran": idPembayaran,
        "id_pemesanan": idPemesanan,
      };
}
