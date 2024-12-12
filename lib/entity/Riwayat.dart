// import 'package:tugas_besar/entity/Pemesanan.dart';
// import 'dart:convert';

// class Riwayat {
//   int? id;
//   int? idUser;
//   int? idPemesanan;

//   Riwayat({
//     this.id,
//     required this.idUser,
//     required this.idPemesanan,
//   });

//   factory Riwayat.fromRawJson(String str) => Riwayat.fromJson(json.decode(str));

//   factory Riwayat.fromJson(Map<String, dynamic> json) => Riwayat(
//         id: json["id_riwayat"],
//         idUser: json["id_user"] ?? 0,
//         idPemesanan: json["id_pemesanan"] ?? 0,
//       );

//   String toRawJson() => json.encode(toJson());

//   Map<String, dynamic> toJson() => {
//         "id_riwayat": id,
//         "id_user": idUser ?? 0,
//         "id_pemesanan": idPemesanan ?? 0,
//       };
// }

import 'dart:convert';

class Riwayat {
  int idRiwayat;
  int? idUser;
  int? idPemesanan;
  Map<String, dynamic>? jadwal;
  Map<String, dynamic>? bus;
  
  Riwayat({
    required this.idRiwayat,
    this.jadwal,
    this.bus,
  });

  // Factory constructor untuk membuat objek Riwayat dari JSON
  factory Riwayat.fromRawJson(String str) => Riwayat.fromJson(json.decode(str));

  // Factory constructor untuk parsing JSON
  factory Riwayat.fromJson(Map<String, dynamic> json) => Riwayat(
        idRiwayat: json['id_riwayat'] ?? 0,
        jadwal: json['jadwal'] is Map ? json['jadwal'] : {},
        bus: json['bus'] is Map ? json['bus'] : {},
      );

  // Metode untuk mengonversi objek ke JSON
  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'id_riwayat': idRiwayat,
        'jadwal': jadwal ?? {},
        'bus': bus ?? {},
      };

  // Getter untuk mempermudah akses data
  String get namaBus => bus?['nama'] ?? 'Tidak Diketahui';
  String get kotaAsal => jadwal?['asal'] ?? 'Tidak Diketahui';
  String get kotaTujuan => jadwal?['tujuan'] ?? 'Tidak Diketahui';
  String get waktuKeberangkatan => jadwal?['waktu_keberangkatan'] ?? 'Tidak Diketahui';
  String get waktuKedatangan => jadwal?['waktu_kedatangan'] ?? 'Tidak Diketahui';
  String get tanggal => jadwal?['tanggal'] ?? 'Tidak Diketahui';
  String get kursi => jadwal?['kursi'] ?? 'Tidak Diketahui';
  double get harga => double.tryParse(jadwal?['harga']?.toString() ?? '0') ?? 0;
}