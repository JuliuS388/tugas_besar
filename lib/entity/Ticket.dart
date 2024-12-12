import 'dart:convert';
import 'User.dart';
import 'Penumpang.dart';
import 'Pemesanan.dart';
import 'Jadwal.dart';

class Ticket {
  int? id;
  User? user;
  Pemesanan? pemesanan;
  Jadwal? jadwal;

  Ticket({
    this.id,
    this.user,
    this.pemesanan,
    this.jadwal,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: int.tryParse(json['id_tiket'].toString()), // Convert id_tiket ke int
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      pemesanan: json['pemesanan'] != null
          ? Pemesanan.fromJson(json['pemesanan'])
          : null,
      jadwal: json['pemesanan']?['jadwal'] != null
          ? Jadwal.fromJson(json['pemesanan']['jadwal'])
          : null, // Mengambil jadwal dari pemesanan
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_tiket": id,
      "user": user?.toJson(),
      "pemesanan": pemesanan?.toJson(),
      "jadwal": jadwal?.toJson(),
    };
  }

  String toRawJson() => json.encode(toJson());
}
