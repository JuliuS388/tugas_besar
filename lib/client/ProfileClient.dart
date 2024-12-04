import 'dart:convert';
import 'package:http/http.dart';
import 'package:tugas_besar/entity/Profile.dart';
import 'package:tugas_besar/tokenStorage.dart';

class ProfilClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = 'api/profile';

  static Future<Profile> getProfile() async {
    try {
      String? token = await TokenStorage.getToken();
      var response = await get(
        Uri.http(url, endpoint),
        headers: {"Authorization": "Bearer $token"},
      );
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Profile.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }


  static Future<List<Profile>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Profile.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Profile> find(int id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Profile.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // static Future<Response> create(Profile profile) async {
  //   try {
  //     var response = await post(Uri.http(url, endpoint),
  //         headers: {"Content-Type": "application/json"},
  //         body: profile.toRawJson());

  //     if (response.statusCode != 201) throw Exception(response.reasonPhrase);

  //     return response;
  //   } catch (e) {
  //     return Future.error(e.toString());
  //   }
  // }

  // static Future<Response> update(Profile profile) async {
  //   try {
  //     var response = await put(Uri.http(url, '$endpoint/${profile.id}'),
  //         headers: {"Content-Type": "application/json"},
  //         body: profile.toRawJson());

  //     if (response.statusCode != 200) throw Exception(response.reasonPhrase);

  //     return response;
  //   } catch (e) {
  //     return Future.error(e.toString());
  //   }
  // }

  static Future<Response> destroy(int id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 204) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
