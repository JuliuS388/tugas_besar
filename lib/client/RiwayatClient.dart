import 'dart:convert';
import 'package:http/http.dart';
import 'package:tugas_besar/entity/Riwayat.dart';
import 'package:tugas_besar/tokenStorage.dart'; // Impor TokenStorage

class RiwayatClient {
  static const String url = '192.168.139.233';
  static const String endpoint = '/Travel_API/public/api/riwayat';

  static Future<List<Riwayat>> fetchByUser(int userId) async {
    try {
      String? token = await TokenStorage.getToken();
      if (token == null) throw Exception("Token is null");

      final response = await get(
        Uri.http(url, '$endpoint/user/$userId'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        
        // Pastikan data lengkap dengan relasi
        if (jsonData['data'] != null) {
          return (jsonData['data'] as List)
              .map((e) => Riwayat.fromJson(e))
              .toList();
        }
        return [];
      } else {
        throw Exception("Failed to fetch riwayat: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error in fetchByUser: $e");
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
      String? token = await TokenStorage.getToken();
      print('Sending riwayat data: ${jsonEncode(riwayat.toJson())}'); // Debug print

      var response = await post(
        Uri.http(url, endpoint),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(riwayat.toJson()),
      );

      print('Response status: ${response.statusCode}'); // Debug print
      print('Response body: ${response.body}'); // Debug print

      if (response.statusCode == 201) {
        var responseData = jsonDecode(response.body);
        return Riwayat.fromJson(responseData['data']);
      } else {
        throw Exception(jsonDecode(response.body)['message'] ?? 'Failed to create riwayat');
      }
    } catch (e) {
      print('Error in create riwayat: $e'); // Debug print
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(Riwayat riwayat) async {
    try {
      String? token = await TokenStorage.getToken();
      var response = await put(
        Uri.http(url, '$endpoint/${riwayat.idRiwayat}'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(riwayat.toJson()),
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