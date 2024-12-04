import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tugas_besar/tokenStorage.dart';

class UserClient {
  static const String url = '192.168.100.89';
  static const String loginEndpoint = '/1_Travel_C_API/public/api/login';


  static Future<bool> login(String email, String password) async {
    try {
      var response = await http.post(
        Uri.http(url, endpoint),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"email": email, "password": password}),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        String token = data['token']; // Misalkan token ada di respons API
        await TokenStorage.saveToken(token); // Simpan token
        print('Login successful, token saved');

        return true;
      } else {
        print('Login failed: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error logging in: $e');
      return false;
    }
  }
}
