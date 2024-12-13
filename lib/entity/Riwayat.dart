import 'package:tugas_besar/entity/Bus.dart';
import 'package:tugas_besar/entity/Jadwal.dart';
import 'package:tugas_besar/entity/Pemesanan.dart';

class Riwayat {
  final int? idRiwayat;
  final int? idUser;
  final int? idPemesanan;
  final String? tanggalTransaksi;
  final Pemesanan? pemesanan;

  Riwayat({
    this.idRiwayat,
    this.idUser,
    this.idPemesanan,
    this.tanggalTransaksi,
    this.pemesanan,
  });

  factory Riwayat.fromJson(Map<String, dynamic> json) {
    return Riwayat(
      idRiwayat: json['id_riwayat'],
      idUser: json['id_user'],
      idPemesanan: json['id_pemesanan'],
      tanggalTransaksi: json['tanggal_transaksi'],
      pemesanan: json['pemesanan'] != null 
          ? Pemesanan.fromJson(json['pemesanan']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_riwayat': idRiwayat,
      'id_user': idUser,
      'id_pemesanan': idPemesanan,
      'tanggal_transaksi': tanggalTransaksi,
      'pemesanan': pemesanan?.toJson(),
    };
  }
}