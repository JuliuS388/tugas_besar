import 'dart:convert';
import 'package:http/http.dart' as http;

class UserClient {
  static const String url = '192.168.100.89';
  static const String endpoint = '/1_Travel_C_API/public/api/login';

  static Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.http(url, endpoint),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return true; // Login berhasil
      } else {
        print('Login failed: ${response.body}');
        return false; // Login gagal
      }
    } catch (e) {
      print('Error during login: $e');
      return false;
    }
  }
}
