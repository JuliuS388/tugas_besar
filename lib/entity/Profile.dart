import 'dart:convert';

class Profile {
  final String? name;
  final String? email;
  final String? imageUrl;
  final int? idUser;
  final String? username;
  final String? noTelp;
  final String? tglUlt;
  final String? tglJoin;
  final String? pass;
  final String? profileImage;

  Profile({this.name, this.email, this.imageUrl, this.idUser, this.username, this.noTelp, this.tglUlt, this.tglJoin, this.pass, this.profileImage});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['nama'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      idUser: json['id_user'],
      username: json['username'],
      noTelp: json['nomor_telepon'],
      tglUlt: json['tanggal_lahir'],
      tglJoin: json['created_at'],
      pass: json['password'],
      profileImage: json['profile_image'],
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() {
    return {
      'nama': name,
      'username': username,
      'email': email,
      'nomor_telepon': noTelp,
      'tanggal_lahir': tglUlt,
      'password': pass,
    };
  }
}
