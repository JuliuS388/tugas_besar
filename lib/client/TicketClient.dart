import 'dart:convert';
import 'package:http/http.dart';
import 'package:tugas_besar/entity/Ticket.dart';

class TicketClient {
  static final String url = '192.168.1.9';
  static final String endpoint = '/Travel_API/api/ticket';

  static Future<List<Tiket>> fetchAllTickets() async {
    try {
      final uri = Uri.http(url, endpoint);
      final response = await get(uri);

      if (response.statusCode != 200) {
        throw Exception(response.reasonPhrase);
      }

      final data = json.decode(response.body)['data'] as List;
      return data.map((json) => Tiket.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Failed to fetch tickets: $e");
    }
  }

  Future<Tiket> createTicket(Tiket tiket) async {
    final response = await post(
      Uri.parse('$url/tikets'),
      headers: {'Content-Type': 'application/json'},
      body: tiket.toRawJson(),
    );

    if (response.statusCode == 201) {
      return Tiket.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create ticket');
    }
  }
}
