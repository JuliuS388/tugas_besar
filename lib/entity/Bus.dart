import 'dart:convert';

class Bus {
  int id;
  String namaBus;
  String sopirBus;
  String fasilitasBus;

  Bus({
    required this.id,
    required this.namaBus,
    required this.sopirBus,
    required this.fasilitasBus,
  });

  factory Bus.fromRawJson(String str) => Bus.fromJson(json.decode(str));

  factory Bus.fromJson(Map<String, dynamic> json) => Bus(
        id: json["id_bus"],
        namaBus: json["nama_bus"],
        sopirBus: json["sopir_bus"],
        fasilitasBus: json["fasilitas_bus"],
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id_bus": id,
        "nama_bus": namaBus,
        "sopir_bus": sopirBus,
        "fasilitas_bus": fasilitasBus,
      };
}
