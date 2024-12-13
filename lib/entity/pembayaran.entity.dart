class PembayaranReq {
  int? idPemesanan;
  String? metodePembayaran;

  PembayaranReq({this.idPemesanan, this.metodePembayaran});

  PembayaranReq.fromJson(Map<String, dynamic> json) {
    idPemesanan = json['id_pemesanan'];
    metodePembayaran = json['metode_pembayaran'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_pemesanan'] = this.idPemesanan;
    data['metode_pembayaran'] = this.metodePembayaran;
    return data;
  }
}

class PembayaranRes {
  int? idPemesanan;
  String? metodePembayaran;
  String? updatedAt;
  String? createdAt;
  int? pembayarans;

  PembayaranRes(
      {this.idPemesanan,
      this.metodePembayaran,
      this.updatedAt,
      this.createdAt,
      this.pembayarans});

  PembayaranRes.fromJson(Map<String, dynamic> json) {
    idPemesanan = json['id_pemesanan'];
    metodePembayaran = json['metode_pembayaran'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    pembayarans = json['pembayarans'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_pemesanan'] = this.idPemesanan;
    data['metode_pembayaran'] = this.metodePembayaran;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['pembayarans'] = this.pembayarans;
    return data;
  }
}

class GetPembayaranResponse {
  int? idPembayaran;
  int? idPemesanan;
  String? metodePembayaran;
  String? createdAt;
  String? updatedAt;
  Pemesanan? pemesanan;

  GetPembayaranResponse(
      {this.idPembayaran,
      this.idPemesanan,
      this.metodePembayaran,
      this.createdAt,
      this.updatedAt,
      this.pemesanan});

  GetPembayaranResponse.fromJson(Map<String, dynamic> json) {
    idPembayaran = json['id_pembayaran'];
    idPemesanan = json['id_pemesanan'];
    metodePembayaran = json['metode_pembayaran'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pemesanan = json['pemesanan'] != null
        ? new Pemesanan.fromJson(json['pemesanan'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_pembayaran'] = this.idPembayaran;
    data['id_pemesanan'] = this.idPemesanan;
    data['metode_pembayaran'] = this.metodePembayaran;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pemesanan != null) {
      data['pemesanan'] = this.pemesanan!.toJson();
    }
    return data;
  }
}

class Pemesanan {
  int? idPemesanan;
  int? idUser;
  int? idJadwal;
  String? harga;
  String? tanggalPemesanan;
  String? createdAt;
  String? updatedAt;

  Pemesanan(
      {this.idPemesanan,
      this.idUser,
      this.idJadwal,
      this.harga,
      this.tanggalPemesanan,
      this.createdAt,
      this.updatedAt});

  Pemesanan.fromJson(Map<String, dynamic> json) {
    idPemesanan = json['id_pemesanan'];
    idUser = json['id_user'];
    idJadwal = json['id_jadwal'];
    harga = json['harga'];
    tanggalPemesanan = json['tanggal_pemesanan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_pemesanan'] = this.idPemesanan;
    data['id_user'] = this.idUser;
    data['id_jadwal'] = this.idJadwal;
    data['harga'] = this.harga;
    data['tanggal_pemesanan'] = this.tanggalPemesanan;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class GetDetailPembayaranResponse {
  int? idPemesanan;
  int? idUser;
  int? idJadwal;
  String? harga;
  String? tanggalPemesanan;
  String? createdAt;
  String? updatedAt;
  Jadwal? jadwal;
  List<Penumpangs>? penumpangs;

  GetDetailPembayaranResponse(
      {this.idPemesanan,
      this.idUser,
      this.idJadwal,
      this.harga,
      this.tanggalPemesanan,
      this.createdAt,
      this.updatedAt,
      this.jadwal,
      this.penumpangs});

  GetDetailPembayaranResponse.fromJson(Map<String, dynamic> json) {
    idPemesanan = json['id_pemesanan'];
    idUser = json['id_user'];
    idJadwal = json['id_jadwal'];
    harga = json['harga'];
    tanggalPemesanan = json['tanggal_pemesanan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    jadwal =
        json['jadwal'] != null ? new Jadwal.fromJson(json['jadwal']) : null;
    if (json['penumpangs'] != null) {
      penumpangs = <Penumpangs>[];
      json['penumpangs'].forEach((v) {
        penumpangs!.add(new Penumpangs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_pemesanan'] = this.idPemesanan;
    data['id_user'] = this.idUser;
    data['id_jadwal'] = this.idJadwal;
    data['harga'] = this.harga;
    data['tanggal_pemesanan'] = this.tanggalPemesanan;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.jadwal != null) {
      data['jadwal'] = this.jadwal!.toJson();
    }
    if (this.penumpangs != null) {
      data['penumpangs'] = this.penumpangs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Jadwal {
  int? idJadwal;
  int? idBus;
  String? keberangkatan;
  String? kedatangan;
  String? harga;
  String? asal;
  String? tujuan;
  String? createdAt;
  String? updatedAt;

  Jadwal(
      {this.idJadwal,
      this.idBus,
      this.keberangkatan,
      this.kedatangan,
      this.harga,
      this.asal,
      this.tujuan,
      this.createdAt,
      this.updatedAt});

  Jadwal.fromJson(Map<String, dynamic> json) {
    idJadwal = json['id_jadwal'];
    idBus = json['id_bus'];
    keberangkatan = json['keberangkatan'];
    kedatangan = json['kedatangan'];
    harga = json['harga'];
    asal = json['asal'];
    tujuan = json['tujuan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_jadwal'] = this.idJadwal;
    data['id_bus'] = this.idBus;
    data['keberangkatan'] = this.keberangkatan;
    data['kedatangan'] = this.kedatangan;
    data['harga'] = this.harga;
    data['asal'] = this.asal;
    data['tujuan'] = this.tujuan;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Penumpangs {
  int? idPenumpang;
  int? idPemesanan;
  String? namaPenumpang;
  int? umur;
  String? jenisKelamin;
  String? nomorKursi;
  String? createdAt;
  String? updatedAt;

  Penumpangs(
      {this.idPenumpang,
      this.idPemesanan,
      this.namaPenumpang,
      this.umur,
      this.jenisKelamin,
      this.nomorKursi,
      this.createdAt,
      this.updatedAt});

  Penumpangs.fromJson(Map<String, dynamic> json) {
    idPenumpang = json['id_penumpang'];
    idPemesanan = json['id_pemesanan'];
    namaPenumpang = json['nama_penumpang'];
    umur = json['umur'];
    jenisKelamin = json['jenis_kelamin'];
    nomorKursi = json['nomor_kursi'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_penumpang'] = this.idPenumpang;
    data['id_pemesanan'] = this.idPemesanan;
    data['nama_penumpang'] = this.namaPenumpang;
    data['umur'] = this.umur;
    data['jenis_kelamin'] = this.jenisKelamin;
    data['nomor_kursi'] = this.nomorKursi;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}