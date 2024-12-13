import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tugas_besar/tokenStorage.dart';
import 'package:tugas_besar/entity/Jadwal.dart'; // Gantilah ke entitas Jadwal yang sesuai

class JadwalClient {
  static const String url = '10.0.2.2:8000';
  static const String endpoint = '/api/jadwal/search';

  static Future<List<Jadwal>> fetchFiltered(
      String asal, String tujuan, String keberangkatan) async {
    try {
      String? token = await TokenStorage.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      var response = await http.get(
        Uri.http(url, endpoint, {
          'asal': asal, // Menambahkan asal
          'tujuan': tujuan, // Menambahkan tujuan
          'keberangkatan': keberangkatan, // Menambahkan tanggal keberangkatan
        }),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        var decoded = json.decode(response.body);
        // Pastikan data yang diterima memiliki struktur yang sesuai
        if (decoded != null && decoded['data'] != null) {
          return (decoded['data'] as List)
              .map<Jadwal>((e) => Jadwal.fromJson(e))
              .toList();
        } else {
          return [];
        }
      } else {
        print('Failed to load schedules: ${response.statusCode}');
        throw Exception('Failed to load schedules');
      }
    } catch (e) {
      print('Error fetching schedules: $e');
      rethrow;
    }
  }
}
