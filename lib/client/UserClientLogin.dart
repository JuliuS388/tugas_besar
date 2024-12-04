import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tugas_besar/tokenStorage.dart';

<<<<<<< HEAD
class UserClientLogin{
  static const String url = '192.168.100.89';
  static const String loginEndpoint = '/1_Travel_C_API/public/api/login';

=======
class UserClientlogin {
  static const String url = '192.168.146.22';
  static const String loginEndpoint = '/Travel_API/public/api/login';
>>>>>>> 1f04bac8b38af03a38e4a42c96e4ab337ae8df43

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
