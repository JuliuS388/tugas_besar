import 'dart:convert';
import 'package:http/http.dart' as http; // Menggunakan alias untuk http
import 'package:tugas_besar/entity/Ticket.dart';
import 'package:tugas_besar/tokenStorage.dart';

class TicketClient {
  static const String baseUrl = '192.168.1.9'; // Base URL server
  static const String endpoint =
      '/Travel_API/public/api/tiket'; // Endpoint API tiket

  // Fetch All Tickets
  static Future<List<Ticket>> fetchByUser(int userId) async {
    try {
      String? token = await TokenStorage.getToken(); // Ambil token dari storage
      if (token == null) throw Exception("Token is null");

      final response = await http.get(
        Uri.http(baseUrl,
            '$endpoint/user/$userId'), // Endpoint untuk fetch by userId
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        Iterable list = jsonData['data'];
        return list.map((e) => Ticket.fromJson(e)).toList();
      } else {
        throw Exception(
            "Failed to fetch tickets by user: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error in fetchByUser: $e");
      return Future.error(e.toString());
    }
  }

  // Find a Ticket by ID
  static Future<Ticket> find(int id) async {
    try {
      String? token = await TokenStorage.getToken();
      if (token == null) throw Exception("Token is null");

      final response = await http.get(
        Uri.http(baseUrl, '$endpoint/$id'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to fetch ticket: ${response.statusCode}');
      }

      final decoded = json.decode(response.body);
      return Ticket.fromJson(decoded['data']);
    } catch (e) {
      print("Error in find: $e");
      return Future.error(e.toString());
    }
  }

  // Create a new Ticket
  static Future<Ticket> create(Ticket ticket) async {
    try {
      String? token = await TokenStorage.getToken();
      if (token == null) throw Exception("Token is null");

      final response = await http.post(
        Uri.http(baseUrl, endpoint),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: ticket.toRawJson(),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to create ticket: ${response.statusCode}');
      }

      return Ticket.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      print("Error in create: $e");
      return Future.error(e.toString());
    }
  }

  // Update an existing Ticket
  static Future<bool> update(Ticket ticket) async {
    try {
      String? token = await TokenStorage.getToken();
      if (token == null) throw Exception("Token is null");

      final response = await http.put(
        Uri.http(baseUrl, '$endpoint/${ticket.id}'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: ticket.toRawJson(),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update ticket: ${response.statusCode}');
      }

      return true;
    } catch (e) {
      print("Error in update: $e");
      return Future.error(e.toString());
    }
  }

  // Delete a Ticket
  static Future<bool> destroy(int id) async {
    try {
      String? token = await TokenStorage.getToken();
      if (token == null) throw Exception("Token is null");

      final response = await http.delete(
        Uri.http(baseUrl, '$endpoint/$id'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete ticket: ${response.statusCode}');
      }

      return true;
    } catch (e) {
      print("Error in destroy: $e");
      return Future.error(e.toString());
    }
  }
}
