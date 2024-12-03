import 'dart:convert';

class User {
  final int id;
  final String nama;
  final String username;
  final String email;
  final String password;
  final String nomorTelepon;

  User({
    required this.id,
    required this.nama,
    required this.username,
    required this.email,
    required this.password,
    required this.nomorTelepon,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id_user"],
        nama: json["nama"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        nomorTelepon: json["nomor_telepon"],
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "username": username,
        "email": email,
        "password": password,
        "nomor_telepon": nomorTelepon,
      };
}
