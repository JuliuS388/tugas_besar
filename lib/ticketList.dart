// import 'package:flutter/material.dart';
// import 'package:dotted_line/dotted_line.dart';
// import 'package:intl/intl.dart';

// class TicketList extends StatefulWidget {
//   final Map? data;
//   const TicketList({super.key, this.data});

//   @override
//   _TicketListState createState() => _TicketListState();
// }

// class _TicketListState extends State<TicketList> {
//   final List<Ticket> tickets = [
//     Ticket(
//       name: 'Handoyo',
//       departureTime: '13:00',
//       departureLocation: 'Grogol',
//       arrivalTime: '03:00',
//       arrivalLocation: 'Terminal Giwangan',
//       price: '200,000',
//       rating: 4.5,
//     ),
//     Ticket(
//       name: 'Haryanto',
//       departureTime: '02:00',
//       departureLocation: 'Grogol',
//       arrivalTime: '16:00',
//       arrivalLocation: 'Terminal Jombor',
//       price: '250,000',
//       rating: 4.5,
//     ),
//     Ticket(
//       name: 'Pt Sinar Jaya Group',
//       departureTime: '23:00',
//       departureLocation: 'Grogol',
//       arrivalTime: '13:00',
//       arrivalLocation: 'Agen Prambanan',
//       price: '198,000',
//       rating: 4.5,
//     ),
//     Ticket(
//       name: 'Agra Mas',
//       departureTime: '03:00',
//       departureLocation: 'Pondok Gede',
//       arrivalTime: '18:00',
//       arrivalLocation: 'Jombor',
//       price: '245,000',
//       rating: 0,
//     ),
//     Ticket(
//       name: 'Gunung Harta',
//       departureTime: '04:15',
//       departureLocation: 'Jatiwaringin',
//       arrivalTime: '16:00',
//       arrivalLocation: 'Semarang',
//       price: '245,000',
//       rating: 0,
//     ),
//     Ticket(
//       name: 'Muji Jaya',
//       departureTime: '02:00',
//       departureLocation: 'Grogol',
//       arrivalTime: '16:00',
//       arrivalLocation: 'Terminal Jombor',
//       price: '250,000',
//       rating: 4.5,
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Text(
//           'Cari Tiket',
//           style: TextStyle(color: Colors.white),
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: tickets.length,
//         itemBuilder: (context, index) {
//           final ticket = tickets[index];
//           return GestureDetector(
//             onTap: () {
//               print("Tiket ${ticket.name} diklik");
//             },
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: Material(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 elevation: 3,
//                 child: InkWell(
//                   borderRadius: BorderRadius.circular(12),
//                   onTap: () {
//                     // Tambahkan aksi ketika tiket diklik
//                     print("Tiket ${ticket.name} diklik");
//                   },
//                   splashColor: Colors.blue.withOpacity(0.2),
//                   highlightColor: Colors.blue.withOpacity(0.1),
//                   child: Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           ticket.name,
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(height: 8),
//                         Row(
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   ticket.departureTime,
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 Text(
//                                   ticket.departureLocation,
//                                   style: TextStyle(color: Colors.grey),
//                                 ),
//                               ],
//                             ),
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                                 child: Column(
//                                   children: [
//                                     DottedLine(
//                                       dashColor: Colors.grey,
//                                       lineThickness: 1.5,
//                                       dashLength: 6,
//                                       dashGapLength: 4,
//                                     ),
//                                     SizedBox(height: 4),
//                                     Text(
//                                       'Durasi: ${_calculateDuration(ticket.departureTime, ticket.arrivalTime)} jam',
//                                       style: TextStyle(color: Colors.grey, fontSize: 12),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Text(
//                                   ticket.arrivalTime,
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 Text(
//                                   ticket.arrivalLocation,
//                                   style: TextStyle(color: Colors.grey),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 16),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'IDR ${ticket.price}',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Row(
//                               children: [
//                                 Icon(Icons.star, color: Colors.orange, size: 16),
//                                 SizedBox(width: 4),
//                                 Text(
//                                   ticket.rating.toString(),
//                                   style: TextStyle(
//                                       fontSize: 14, fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // Fungsi untuk menghitung durasi antara waktu keberangkatan dan kedatangan
//   String _calculateDuration(String departure, String arrival) {
//     try {
//       final format = DateFormat("HH:mm");
//       final departureTime = format.parse(departure);
//       final arrivalTime = format.parse(arrival);
//       var duration = arrivalTime.difference(departureTime);

//       // Jika durasi negatif, tambahkan 24 jam untuk menyesuaikan waktu malam hari
//       if (duration.isNegative) {
//         duration += Duration(hours: 24);
//       }
//       return duration.inHours.toString();
//     } catch (e) {
//       return '-';
//     }
//   }
// }

// class Ticket {
//   final String name;
//   final String departureTime;
//   final String departureLocation;
//   final String arrivalTime;
//   final String arrivalLocation;
//   final String price;
//   final double rating;

//   Ticket({
//     required this.name,
//     required this.departureTime,
//     required this.departureLocation,
//     required this.arrivalTime,
//     required this.arrivalLocation,
//     required this.price,
//     required this.rating,
//   });
// }


import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:intl/intl.dart';
import 'package:tugas_besar/ticket_preview.dart';

class TicketList extends StatefulWidget {
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
    Ticket(
      name: 'Muji Jaya',
      departureTime: '02:00',
      departureLocation: 'Grogol',
      arrivalTime: '16:00',
      arrivalLocation: 'Terminal Jombor',
      price: '250,000',
      rating: 4.5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Cari Tiket',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          final ticket = tickets[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TicketPreview(ticket: ticket),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                elevation: 3,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TicketPreview(ticket: ticket),
                      ),
                    );
                  },
                  splashColor: Colors.blue.withOpacity(0.2),
                  highlightColor: Colors.blue.withOpacity(0.1),
                  child: Container(
                    padding: const EdgeInsets.all(16),
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
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  children: [
                                    DottedLine(
                                      dashColor: Colors.grey,
                                      lineThickness: 1.5,
                                      dashLength: 6,
                                      dashGapLength: 4,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Durasi: ${_calculateDuration(ticket.departureTime, ticket.arrivalTime)} jam',
                                      style: TextStyle(color: Colors.grey, fontSize: 12),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
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
                ),
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
      var duration = arrivalTime.difference(departureTime);

      // Jika durasi negatif, tambahkan 24 jam untuk menyesuaikan waktu malam hari
      if (duration.isNegative) {
        duration += Duration(hours: 24);
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
