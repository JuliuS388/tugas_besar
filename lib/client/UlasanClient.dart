import 'dart:convert';
import 'package:http/http.dart';
import 'package:tugas_besar/entity/Ulasan.dart';

class UlasanClient {
  static const String url = '192.168.94.233';
  static const String endpoint = 'Travel_API/public/api/ulasan';

  static Future<List<Ulasan>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Ulasan.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Ulasan> find(int id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Ulasan.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(Ulasan ulasan) async {
    try {
      var response = await post(Uri.http(url, endpoint),
          headers: {"Content-Type": "application/json"},
          body: ulasan.toRawJson());

      if (response.statusCode != 201) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(Ulasan ulasan) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/${ulasan.id}'),
          headers: {"Content-Type": "application/json"},
          body: ulasan.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

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
