import 'dart:convert';
import 'package:http/http.dart';
import 'package:tugas_besar/entity/Pemesanan.dart';
import 'package:tugas_besar/tokenStorage.dart';

class PemesananClient {
  static const String url = '10.0.2.2:8000';
  static const String endpoint = '/api/pemesanan';

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

      // Ambil id_pemesanan dari response
      var idPemesanan = responseData['id_pemesanan'];

      // Setelah mendapatkan id_pemesanan, Anda bisa mengembalikan objek Pemesanan baru
      // Mungkin Anda ingin meng-update objek pemesanan dengan id_pemesanan yang baru
      pemesanan.id = idPemesanan;

      return pemesanan; // Mengembalikan objek Pemesanan dengan id_pemesanan
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
      String? token = await TokenStorage.getToken(); // Get token from storage
      var response = await delete(
        Uri.http(url, '$endpoint/$id'),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return response;
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        throw Exception('Failed to delete pemesanan');
      }
    } catch (e) {
      print("Exception caught: $e");
      return Future.error('Error during pemesanan deletion: $e');
    }
  }
}
