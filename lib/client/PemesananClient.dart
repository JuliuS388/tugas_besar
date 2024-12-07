import 'dart:convert';
import 'package:http/http.dart';
import 'package:tugas_besar/entity/Pemesanan.dart';
import 'package:tugas_besar/tokenStorage.dart';

class PemesananClient {
  static const String url = '192.168.100.89';
  static const String endpoint = '/1_Travel_C_API/public/api/pemesanan';

  // Fetch All Pemesanan
  static Future<List<Pemesanan>> fetchAll() async {
    try {
      String? token =
          await TokenStorage.getToken(); // Ambil token dari tokenStorage
      var response = await get(
        Uri.http(url, endpoint),
        headers: {
          "Authorization": "Bearer $token", // Tambahkan header Authorization
        },
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Pemesanan.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Pemesanan> find(int id) async {
    try {
      String? token =
          await TokenStorage.getToken(); // Ambil token dari tokenStorage
      var response = await get(
        Uri.http(url, '$endpoint/$id'),
        headers: {
          "Authorization": "Bearer $token", // Tambahkan header Authorization
        },
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Pemesanan.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Pemesanan> create(Pemesanan pemesanan) async {
    try {
      String? token =
          await TokenStorage.getToken(); // Ambil token dari tokenStorage
      var response = await post(
        Uri.http(url, endpoint),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // Tambahkan header Authorization
        },
        body: pemesanan.toRawJson(),
      );

      if (response.statusCode != 201) throw Exception(response.reasonPhrase);

      var responseData = jsonDecode(response.body);
      return Pemesanan.fromJson(responseData);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(Pemesanan pemesanan) async {
    try {
      String? token =
          await TokenStorage.getToken(); // Ambil token dari tokenStorage
      var response = await put(
        Uri.http(url, '$endpoint/${pemesanan.id}'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // Tambahkan header Authorization
        },
        body: pemesanan.toRawJson(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> destroy(int id) async {
    try {
      String? token =
          await TokenStorage.getToken(); // Ambil token dari tokenStorage
      var response = await delete(
        Uri.http(url, '$endpoint/$id'),
        headers: {
          "Authorization": "Bearer $token", // Tambahkan header Authorization
        },
      );

      if (response.statusCode != 204) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
