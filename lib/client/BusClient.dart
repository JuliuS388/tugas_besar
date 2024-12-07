import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tugas_besar/tokenStorage.dart';
import 'package:tugas_besar/entity/Bus.dart';

class BusClient {
  static const String url = '192.168.94.233';
  static const String endpoint = 'Travel_API/public/api/bus';

  // Fetch all buses
  static Future<List<Bus>> fetchAll() async {
    try {
      String? token = await TokenStorage.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      var response = await http.get(
        Uri.http(url, endpoint),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        var decoded = json.decode(response.body);

        // Check if the response is empty
        if (decoded == null || decoded.isEmpty) {
          return []; // Return an empty list
        }

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
