import 'dart:convert';
import 'package:http/http.dart';
import 'package:tugas_besar/entity/Riwayat.dart';
import 'package:tugas_besar/tokenStorage.dart'; // Impor TokenStorage

class RiwayatClient {
  static const String url = '192.168.139.233';
  static const String endpoint = '/Travel_API/public/api/riwayat';

  static Future<List<Riwayat>> fetchAll() async {
    try {
      String? token = await TokenStorage.getToken(); // Ambil token dari tokenStorage
      var response = await get(
        Uri.http(url, endpoint),
        headers: {
          "Authorization": "Bearer $token", // Tambahkan header Authorization
        },
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Riwayat.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Riwayat> find(int id) async {
    try {
      String? token = await TokenStorage.getToken(); // Ambil token dari tokenStorage
      var response = await get(
        Uri.http(url, '$endpoint/$id'),
        headers: {
          "Authorization": "Bearer $token", // Tambahkan header Authorization
        },
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Riwayat.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Riwayat> create(Riwayat riwayat) async {
    try {
      String? token = await TokenStorage.getToken(); // Ambil token dari tokenStorage
      var response = await post(
        Uri.http(url, endpoint),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // Tambahkan header Authorization
        },
        body: riwayat.toRawJson(),
      );

      if (response.statusCode != 201) throw Exception(response.reasonPhrase);

      var responseData = jsonDecode(response.body);
      return Riwayat.fromJson(responseData);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(Riwayat riwayat) async {
    try {
      String? token = await TokenStorage.getToken(); // Ambil token dari tokenStorage
      var response = await put(
        Uri.http(url, '$endpoint/${riwayat.id}'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // Tambahkan header Authorization
        },
        body: riwayat.toRawJson(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> destroy(int id) async {
    try {
      String? token = await TokenStorage.getToken(); // Ambil token dari tokenStorage
      var response = await delete(
        Uri.http(url, '$endpoint/$id'),
        headers: {
          "Authorization": "Bearer $token", // Tambahkan header Authorization
        },
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return response;
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        throw Exception('Failed to delete riwayat');
      }
    } catch (e) {
      print("Exception caught: $e");
      return Future.error('Error during riwayat deletion: $e');
    }
  }
}