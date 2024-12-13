import 'dart:convert';
import 'package:http/http.dart';
import 'package:tugas_besar/entity/Ulasan.dart';
import 'package:tugas_besar/tokenStorage.dart';

class UlasanClient {
  static const String url = '192.168.139.233';
  static const String endpoint = '/Travel_API/public/api/ulasan';

  static Future<T> _authenticatedRequest<T>(
    Future<T> Function(String token) request
  ) async {
    String? token = await TokenStorage.getToken();
    if (token == null) throw Exception("Unauthorized: Token is null");
    return request(token);
  }

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

  static Future<Ulasan> create(Map<String, dynamic> data) async {
    return _authenticatedRequest((token) async {
      try {
        var response = await post(
          Uri.http(url, endpoint),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
          body: jsonEncode({
            "id_user": data['id_user'],
            "id_pemesanan": data['id_pemesanan'],
            "rating": data['rating'],
            "isi_ulasan": data['isi_ulasan'],
            "jenis_ulasan": data['jenis_ulasan'],
          }),
        );

        if (response.statusCode != 201 && response.statusCode != 200) {
          var errorBody = jsonDecode(response.body);
          throw Exception(errorBody['message'] ?? 'Failed to create ulasan');
        }

        var responseData = jsonDecode(response.body);
        return Ulasan.fromJson(responseData['data']);
      } catch (e) {
        throw Exception('Failed to create ulasan: $e');
      }
    });
  }

  static Future<Response> update(Ulasan ulasan) async {
    return _authenticatedRequest((token) async {
      try {
        var response = await put(
          Uri.http(url, '$endpoint/${ulasan.id}'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
          body: ulasan.toRawJson()
        );

        if (response.statusCode != 200) throw Exception(response.reasonPhrase);
        return response;
      } catch (e) {
        return Future.error(e.toString());
      }
    });
  }

  static Future<Response> destroy(int id) async {
    return _authenticatedRequest((token) async {
      try {
        var response = await delete(
          Uri.http(url, '$endpoint/$id'),
          headers: {
            "Authorization": "Bearer $token",
          }
        );

        if (response.statusCode != 204) throw Exception(response.reasonPhrase);
        return response;
      } catch (e) {
        return Future.error(e.toString());
      }
    });
  }
}
