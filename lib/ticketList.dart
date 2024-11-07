import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:intl/intl.dart';

class TicketList extends StatefulWidget {
  final Map? data;
  const TicketList({super.key, this.data});

  @override
  _TicketListState createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> {
  final List<Ticket> tickets = [
    Ticket(
      name: 'Handoyo',
      departureTime: '13:00',
      departureLocation: 'Grogol',
      arrivalTime: '03:00',
      arrivalLocation: 'Terminal Giwangan',
      price: '200,000',
      rating: 4.5,
    ),
    Ticket(
      name: 'Haryanto',
      departureTime: '02:00',
      departureLocation: 'Grogol',
      arrivalTime: '16:00',
      arrivalLocation: 'Terminal Jombor',
      price: '250,000',
      rating: 4.5,
    ),
    Ticket(
      name: 'Haryanto',
      departureTime: '03:00',
      departureLocation: 'Kalideres',
      arrivalTime: '16:00',
      arrivalLocation: 'Terminal Jombor',
      price: '250,000',
      rating: 4.5,
    ),
    Ticket(
      name: 'Pt Sinar Jaya Group',
      departureTime: '23:00',
      departureLocation: 'Grogol',
      arrivalTime: '13:00',
      arrivalLocation: 'Agen Prambanan',
      price: '198,000',
      rating: 4.5,
    ),
    Ticket(
      name: 'Agra Mas',
      departureTime: '03:00',
      departureLocation: 'Pondok Gede',
      arrivalTime: '18:00',
      arrivalLocation: 'Jombor',
      price: '245,000',
      rating: 0,
    ),
    Ticket(
      name: 'Gunung Harta',
      departureTime: '04:15',
      departureLocation: 'Jatiwaringin',
      arrivalTime: '16:00',
      arrivalLocation: 'Semarang',
      price: '245,000',
      rating: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.blue,
          title: Row(
            children: [
              Icon(Icons.arrow_back, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Cari Tiket',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          final ticket = tickets[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticket.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ticket.departureTime,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            ticket.departureLocation,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            DottedLine(
                              dashColor: Colors.grey,
                              lineThickness: 1.5,
                              dashLength: 4,
                              dashGapLength: 4,
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Durasi: ${_calculateDuration(ticket.departureTime, ticket.arrivalTime)} jam',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            ticket.arrivalTime,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            ticket.arrivalLocation,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'IDR ${ticket.price}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          SizedBox(width: 4),
                          Text(
                            ticket.rating.toString(),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Fungsi untuk menghitung durasi antara waktu keberangkatan dan kedatangan
  String _calculateDuration(String departure, String arrival) {
    try {
      final format = DateFormat("HH:mm");
      final departureTime = format.parse(departure);
      final arrivalTime = format.parse(arrival);
      final duration = arrivalTime.difference(departureTime);

      if (duration.inMinutes < 0) {
        return (24 + duration.inHours).toString();
      }
      return duration.inHours.toString();
    } catch (e) {
      return '-';
    }
  }
}

class Ticket {
  final String name;
  final String departureTime;
  final String departureLocation;
  final String arrivalTime;
  final String arrivalLocation;
  final String price;
  final double rating;

  Ticket({
    required this.name,
    required this.departureTime,
    required this.departureLocation,
    required this.arrivalTime,
    required this.arrivalLocation,
    required this.price,
    required this.rating,
  });
}