import 'dart:convert';

class Profile {
  final int id;
  final int idUser;

  Profile({
    required this.id,
    required this.idUser,
  });

  factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id_profile"],
        idUser: json["id_user"],
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id_profile": id,
        "id_user": idUser,
      };
}
