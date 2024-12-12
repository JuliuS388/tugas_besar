import 'dart:convert';
import 'package:http/http.dart';
import 'package:tugas_besar/entity/Pembayaran.dart';
import 'package:tugas_besar/entity/pembayaran.entity.dart';
import 'package:tugas_besar/tokenStorage.dart';

class PembayaranClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/pembayaran';

  static Future<List<Pembayaran>> fetchAll() async {
    try {
      
      var response = await get(Uri.http(url, endpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Pembayaran.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<GetPembayaranResponse> find(int id) async {
    try {
      String? token =
          await TokenStorage.getToken();
      var response = await get(
        Uri.http(url, '${endpoint}/$id'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return GetPembayaranResponse.fromJson(json.decode(response.body));
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<PembayaranRes> create(PembayaranReq pembayaran) async {
    print("ini pembayaran");
    try {
      String? token =
          await TokenStorage.getToken();
      var response = await post(
        Uri.http(url, endpoint),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
          body: json.encode(pembayaran));

      if (response.statusCode != 201) throw Exception(response.reasonPhrase);

      return PembayaranRes.fromJson(json.decode(response.body));
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(Pembayaran pembayaran) async {
    try {
      var response = await put(
          Uri.http(url, '$endpoint/${pembayaran.idPemesanan}'),
          headers: {"Content-Type": "application/json"},
          body: pembayaran.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> destroy(int id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 204) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<GetDetailPembayaranResponse> searchJadwalbyIdJadwal(int id) async {
    try {
      String? token =
          await TokenStorage.getToken();
      var response = await get(
        Uri.http(url, 'api/pemesanan/jadwal/$id'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      return GetDetailPembayaranResponse.fromJson(json.decode(response.body));
    }catch (e) {
      throw e;
    }
  }
}
