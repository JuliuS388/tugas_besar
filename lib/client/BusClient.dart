import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tugas_besar/tokenStorage.dart';
import 'package:tugas_besar/entity/Bus.dart'; // Import TokenStorage

class BusClient {
  static const String url = '192.168.100.89';
  static const String endpoint = '/1_Travel_C_API/public/api/bus';

  static Future<List<Bus>> fetchFiltered(String asal, String tujuan) async {
    try {
      String? token = await TokenStorage.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      var response = await http.get(
        Uri.http(url, endpoint, {
          'asal': asal, // Menambahkan asal dan tujuan sebagai query parameter
          'tujuan': tujuan,
        }),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        var decoded = json.decode(response.body);
        return decoded.map<Bus>((e) => Bus.fromJson(e)).toList();
      } else {
        print('Failed to load buses: ${response.statusCode}');
        throw Exception('Failed to load buses');
      }
    } catch (e) {
      print('Error fetching buses: $e');
      rethrow;
    }
  }
}
