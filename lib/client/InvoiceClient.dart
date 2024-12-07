import 'dart:convert';
import 'package:http/http.dart';
import 'package:tugas_besar/entity/Invoice.dart';

class InvoiceClient {
  static const String url = '192.168.94.233';
  static const String endpoint = 'Travel_API/public/api/invoice';

  static Future<List<Invoice>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Invoice.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Invoice> find(int id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Invoice.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(Invoice invoice) async {
    try {
      var response = await post(Uri.http(url, endpoint),
          headers: {"Content-Type": "application/json"},
          body: invoice.toRawJson());

      if (response.statusCode != 201) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(Invoice invoice) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/${invoice.id}'),
          headers: {"Content-Type": "application/json"},
          body: invoice.toRawJson());

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
