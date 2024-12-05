import 'dart:convert';
import 'package:http/http.dart';
import 'package:tugas_besar/entity/Penumpang.dart';
import 'package:tugas_besar/tokenStorage.dart';

class PenumpangClient {
  
  static const String url = '192.168.94.233';
  static const String endpoint = 'Travel_API/public/api/penumpang';

  // Fetch all penumpang
  static Future<List<Penumpang>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));

      if (response.statusCode != 200) {
        throw Exception('Failed to load penumpang: ${response.reasonPhrase}');
      }

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Penumpang.fromJson(e)).toList();
    } catch (e) {
      return Future.error('Error fetching penumpang: $e');
    }
  }

  // Find a specific penumpang by ID
  static Future<Penumpang> find(int id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) {
        throw Exception('Failed to find penumpang: ${response.reasonPhrase}');
      }

      return Penumpang.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error('Error finding penumpang: $e');
    }
  }

  // Create a new penumpang
  static Future<Response> create(Penumpang penumpang) async {
    try {
      String? token = await TokenStorage.getToken();

      if (token == null) {
        throw Exception('No authentication token found');
      }

      var response = await post(
        Uri.http(url, endpoint),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
        body: json.encode({
          'nama_penumpang': penumpang.nama, // Changed from 'nama'
          'jenis_kelamin': penumpang.jenisKelamin,
          'umur': penumpang.umur
        }),
      );

      return response;
    } catch (e) {
      print("API Request Error: $e");
      rethrow;
    }
  }

  // Update an existing penumpang
  static Future<Response> update(Penumpang penumpang) async {
    try {
      var response = await put(
        Uri.http(url, '$endpoint/${penumpang.idPenumpang}'),
        headers: {"Content-Type": "application/json"},
        body: penumpang.toRawJson(),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update penumpang: ${response.reasonPhrase}');
      }

      return response;
    } catch (e) {
      return Future.error('Error updating penumpang: $e');
    }
  }

  // Delete a penumpang
  static Future<Response> destroy(int id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 204) {
        throw Exception('Failed to delete penumpang: ${response.reasonPhrase}');
      }

      return response;
    } catch (e) {
      return Future.error('Error deleting penumpang: $e');
    }
  }
}
