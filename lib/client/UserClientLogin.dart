import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tugas_besar/tokenStorage.dart';

class UserClientlogin {
  static const String url = '192.168.100.89';
  static const String loginEndpoint = '/1_Travel_C_API/public/api/login';

  static Future<bool> login(String email, String password) async {
    try {
      var response = await http.post(
        Uri.http(url, loginEndpoint),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"email": email, "password": password}),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        // Print semua kunci yang ada di data
        print('All keys in response: ${data.keys}');

        // Ambil token
        String? token = data['token'];

        // Ambil user ID dari bagian detail
        int? userId;
        if (data.containsKey('detail') && data['detail'] is Map) {
          userId = data['detail']['id_user'];
        }

        // Simpan token
        if (token != null) {
          await TokenStorage.saveToken(token);
          print('Token saved successfully');
        } else {
          print('No token found in response');
          return false;
        }

        // Simpan user ID jika ditemukan
        if (userId != null) {
          await TokenStorage.saveUserId(userId);
          print('User ID saved successfully: $userId');
        } else {
          print('No user ID found in response');
          return false;
        }

        print('Login successful');
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
