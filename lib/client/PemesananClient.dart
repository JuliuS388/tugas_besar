import 'dart:convert';
import 'package:http/http.dart';
import 'package:tugas_besar/entity/Pemesanan.dart';
import 'package:tugas_besar/tokenStorage.dart'; // Pastikan import TokenStorage

class PemesananClient {
  static final String url = '192.168.104.30';
  static final String endpoint = '/API_Travel_C/public/api/pemesanan';

  // Fungsi untuk mengambil Bearer Token
  static Future<Map<String, String>> _getHeaders() async {
    final String? token = await TokenStorage.getToken();
    if (token == null)
      throw Exception('Token tidak ditemukan. Harap login ulang.');

    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
  }

  // Fetch All Pemesanan
  static Future<List<Pemesanan>> fetchAll() async {
    try {
      final headers = await _getHeaders(); // Ambil token
      var response = await get(Uri.http(url, endpoint), headers: headers)
          .timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw Exception('Error: ${response.statusCode}, ${response.body}');
      }

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Pemesanan.fromJson(e)).toList();
    } catch (e) {
      return Future.error('Gagal mengambil pemesanan: $e');
    }
  }

  // Find Pemesanan by ID
  static Future<Pemesanan> find(int id) async {
    try {
      final headers = await _getHeaders(); // Ambil token
      var response = await get(Uri.http(url, '$endpoint/$id'), headers: headers)
          .timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw Exception('Error: ${response.statusCode}, ${response.body}');
      }

      return Pemesanan.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error('Gagal mengambil pemesanan dengan ID $id: $e');
    }
  }

  // Create Pemesanan
  static Future<Response> create(Pemesanan pemesanan) async {
    try {
      final headers = await _getHeaders(); // Ambil token
      var response = await post(Uri.http(url, endpoint),
              headers: headers, body: pemesanan.toRawJson())
          .timeout(const Duration(seconds: 15)); // Kirim data pemesanan

      if (response.statusCode != 201) {
        throw Exception('Error: ${response.statusCode}, ${response.body}');
      }

      return response;
    } catch (e) {
      return Future.error('Gagal membuat pemesanan: $e');
    }
  }

  // Update Pemesanan
  static Future<Response> update(Pemesanan pemesanan) async {
    try {
      final headers = await _getHeaders(); // Ambil token
      var response = await put(Uri.http(url, '$endpoint/${pemesanan.id}'),
              headers: headers, body: pemesanan.toRawJson())
          .timeout(const Duration(
              seconds: 15)); // Kirim data pemesanan yang diperbarui

      if (response.statusCode != 200) {
        throw Exception('Error: ${response.statusCode}, ${response.body}');
      }

      return response;
    } catch (e) {
      return Future.error('Gagal memperbarui pemesanan: $e');
    }
  }

  // Delete Pemesanan
  static Future<Response> destroy(int id) async {
    try {
      final headers = await _getHeaders(); // Ambil token
      var response =
          await delete(Uri.http(url, '$endpoint/$id'), headers: headers)
              .timeout(const Duration(seconds: 15));

      if (response.statusCode != 204) {
        throw Exception('Error: ${response.statusCode}, ${response.body}');
      }

      return response;
    } catch (e) {
      return Future.error('Gagal menghapus pemesanan: $e');
    }
  }
}
