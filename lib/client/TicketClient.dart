import 'dart:convert';
import 'package:http/http.dart';
import 'package:tugas_besar/entity/Ticket.dart';
import 'package:tugas_besar/tokenStorage.dart'; // Impor TokenStorage

class TicketClient {
  static const String url = '10.0.2.2:8000';
  static const String endpoint = '/api/tiket';

  static Future<List<Ticket>> fetchByUser(int userId) async {
    try {
      String? token = await TokenStorage.getToken();
      if (token == null) throw Exception("Token is null");

      print('Fetching tickets for user: $userId');
      print('URL: ${Uri.http(url, '$endpoint/user/$userId')}');

      final response = await get(
        Uri.http(url, '$endpoint/user/$userId'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData['data'] != null) {
          try {
            var tickets = (jsonData['data'] as List).map((e) {
              print('Processing ticket data: $e'); // Debug print
              return Ticket.fromJson(e);
            }).toList();
            print('Successfully parsed ${tickets.length} tickets');
            return tickets;
          } catch (e) {
            print('Error parsing ticket data: $e');
            throw Exception('Error parsing ticket data: $e');
          }
        }
        return [];
      } else {
        throw Exception("Failed to fetch tiket: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error in fetchByUser: $e");
      return Future.error(e.toString());
    }
  }

  static Future<Ticket> find(int id) async {
    try {
      String? token =
          await TokenStorage.getToken(); // Ambil token dari tokenStorage
      var response = await get(
        Uri.http(url, '$endpoint/$id'),
        headers: {
          "Authorization": "Bearer $token", // Tambahkan header Authorization
        },
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Ticket.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Ticket> create(Ticket ticket) async {
    try {
      String? token = await TokenStorage.getToken();

      // Debug prints
      print('Creating ticket with URL: ${Uri.http(url, endpoint)}');
      print('Request body: ${jsonEncode(ticket.toJson())}');
      print('Token: $token');

      var response = await post(
        Uri.http(url, endpoint),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json", // Tambahkan header Accept
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(ticket.toJson()),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        try {
          var responseData = jsonDecode(response.body);
          return Ticket.fromJson(responseData['data']);
        } catch (e) {
          print('Error parsing response: $e');
          throw Exception('Invalid response format from server');
        }
      } else {
        print('Server error response: ${response.body}');
        throw Exception(
            'Failed to create ticket. Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('Error in create ticket: $e');
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(Ticket ticket) async {
    try {
      String? token = await TokenStorage.getToken();
      var response = await put(
        Uri.http(url, '$endpoint/${ticket.id}'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(ticket.toJson()),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> destroy(int id) async {
    try {
      String? token =
          await TokenStorage.getToken(); // Ambil token dari tokenStorage
      var response = await delete(
        Uri.http(url, '$endpoint/$id'),
        headers: {
          "Authorization": "Bearer $token", // Tambahkan header Authorization
        },
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return response;
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        throw Exception('Failed to delete tiket');
      }
    } catch (e) {
      print("Exception caught: $e");
      return Future.error('Error during tiket deletion: $e');
    }
  }
}
