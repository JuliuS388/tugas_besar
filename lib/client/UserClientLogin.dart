import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tugas_besar/tokenStorage.dart';
import 'package:tugas_besar/entity/User.dart';

class UserClientlogin {
  static const String url = '192.168.175.22';
  static const String loginEndpoint = '/Travel_API/public/api/login';

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
        String token = data['token']; // Misalkan token ada di respons API
        await TokenStorage.saveToken(token); // Simpan token
        print('Login successful, token and user ID saved');

        await TokenStorage.saveUserId(data['id_user']); // Simpan ID user
        print("ID User tersimpan: ${data['id_user']}");

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

  static Future<void> logout() async {
    try {
      await TokenStorage.clearStorage();
      print('Logout successful');
    } catch (e) {
      print('Error Logout');
    }
  }

  static Future<User> find(int id) async {
    try {
      String? token =
          await TokenStorage.getToken(); // Ambil token dari tokenStorage
      var response = await http.get(
        Uri.http(url, '$loginEndpoint/$id'),
        headers: {
          "Authorization": "Bearer $token", // Tambahkan header Authorization
        },
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return User.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
