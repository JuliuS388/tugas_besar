import 'dart:convert';

class Bus {
  int id;
  String namaBus;
  String supirBus;
  String fasilitasBus;
  double harga; // New field for price

  Bus({
    this.id = 0,
    this.namaBus = 'Nama Bus Tidak Tersedia',
    this.supirBus = 'Supir Tidak Tersedia',
    this.fasilitasBus = 'Fasilitas Tidak Tersedia',
    this.harga = 0.0, // Default value for price
  });

  factory Bus.fromRawJson(String str) => Bus.fromJson(json.decode(str));

  factory Bus.fromJson(Map<String, dynamic> json) {
    // Print out the incoming JSON for debugging
    print('Processing Bus from JSON: $json');

    return Bus(
      id: json["id"] ?? json["id_bus"] ?? 0,
      namaBus: json["nama"] ?? json["nama_bus"] ?? 'Nama Bus Tidak Tersedia',
      supirBus: json["supir"] ?? json["nama_supir"] ?? 'Supir Tidak Tersedia',
      fasilitasBus: json["fasilitas"] ??
          json["fasilitas_bus"] ??
          'Fasilitas Tidak Tersedia',
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id_bus": id,
        "nama_bus": namaBus,
        "nama_supir": supirBus,
        "fasilitas_bus": fasilitasBus,
        "harga": harga, // New field for price
      };
}
