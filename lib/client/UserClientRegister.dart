import 'dart:convert';
import 'package:http/http.dart';
import 'package:tugas_besar/entity/User.dart';

class UserClientRegister {
  static const String url = '192.168.100.89';
  static const String endpoint = '/1_Travel_C_API/public/api/register';

  static Future<List<User>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => User.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<User> getUser(String email) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$email'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return User.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<User> find(int id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return User.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(User user) async {
    try {
      var response = await post(Uri.http(url, endpoint),
          headers: {"Content-Type": "application/json"},
          body: user.toRawJson());

      if (response.statusCode != 201) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(User user) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/${user.email}'),
          headers: {"Content-Type": "application/json"},
          body: user.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> destroy(String email) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/$email'));

      if (response.statusCode != 204) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
