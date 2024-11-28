import 'dart:convert';

class Pemesanan {
  final int id;
  final int idUser;
  final int idBus;
  final String namaDestinasi;
  final double harga;
  final DateTime tanggalPemesanan;

  Pemesanan({
    required this.id,
    required this.idUser,
    required this.idBus,
    required this.namaDestinasi,
    required this.harga,
    required this.tanggalPemesanan,
  });

  factory Pemesanan.fromRawJson(String str) =>
      Pemesanan.fromJson(json.decode(str));

  factory Pemesanan.fromJson(Map<String, dynamic> json) => Pemesanan(
        id: json["id_pemesanan"],
        idUser: json["id_user"],
        idBus: json["id_bus"],
        namaDestinasi: json["nama_destinasi"],
        harga: json["harga"].toDouble(),
        tanggalPemesanan: DateTime.parse(json["tanggal_pemesanan"]),
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id_pemesanan": id,
        "id_user": idUser,
        "id_bus": idBus,
        "nama_destinasi": namaDestinasi,
        "harga": harga,
        "tanggal_pemesanan": tanggalPemesanan.toIso8601String(),
      };
}
