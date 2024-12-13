import 'dart:convert';
import 'User.dart';
import 'Penumpang.dart';
import 'Pemesanan.dart';

class Ticket {
  int? id;
  int? pemesanan_id;
  int? user_id;
  int? penumpang_id;
  Pemesanan? pemesanan;
  Penumpang? penumpang;

  Ticket({
    this.id,
    this.pemesanan_id,
    this.user_id,
    this.penumpang_id,
    this.pemesanan,
    this.penumpang,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id_tiket'] != null
          ? int.parse(json['id_tiket'].toString())
          : null,
      pemesanan_id: json['id_pemesanan'] != null
          ? int.parse(json['id_pemesanan'].toString())
          : null,
      user_id: json['id_user'] != null
          ? int.parse(json['id_user'].toString())
          : null,
      penumpang_id: json['id_penumpang'] != null
          ? int.parse(json['id_penumpang'].toString())
          : null,
      pemesanan: json['pemesanan'] != null
          ? Pemesanan.fromJson(json['pemesanan'])
          : null,
      penumpang: json['penumpang'] != null
          ? Penumpang.fromJson(json['penumpang'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_tiket': id,
      'id_pemesanan': pemesanan_id,
      'id_user': user_id,
      'id_penumpang': penumpang_id,
      'pemesanan': pemesanan?.toJson(),
      'penumpang': penumpang?.toJson(),
    };
  }

  String toRawJson() => json.encode(toJson());
}
