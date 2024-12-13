import 'dart:convert';
import 'package:http/http.dart';
import 'package:tugas_besar/entity/Penumpang.dart';
import 'package:tugas_besar/tokenStorage.dart';

class PenumpangClient {
  static const String url = '192.168.175.22';
  static const String endpoint = '/Travel_API/public/api/penumpang';

  // Fetch All Penumpang
  static Future<List<Penumpang>> fetchAll() async {
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

      return list.map((e) => Penumpang.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Find Penumpang by ID
  static Future<Penumpang> find(int id) async {
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

      return Penumpang.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Create a new Penumpang
  static Future<Penumpang> create(Penumpang penumpang) async {
    try {
      String? token =
          await TokenStorage.getToken(); // Ambil token dari tokenStorage
      var response = await post(
        Uri.http(url, endpoint),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // Tambahkan header Authorization
        },
        body: penumpang.toRawJson(),
      );

      if (response.statusCode != 201) throw Exception(response.reasonPhrase);

      print("Response Body: ${response.body}");
      try {
        var responseData = jsonDecode(response.body);
        return Penumpang.fromJson(responseData);
      } catch (e) {
        print('Error while parsing JSON: $e');
        return Future.error(e.toString());
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Update an existing Penumpang
  static Future<Response> update(Penumpang penumpang) async {
    try {
      String? token =
          await TokenStorage.getToken(); // Ambil token dari tokenStorage
      var response = await put(
        Uri.http(url, '$endpoint/${penumpang.id}'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // Tambahkan header Authorization
        },
        body: penumpang.toRawJson(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Delete a Penumpang
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
