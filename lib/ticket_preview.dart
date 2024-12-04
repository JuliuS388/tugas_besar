import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:tugas_besar/ticketList.dart';

class TicketPreview extends StatelessWidget {
  final Ticket ticket;

  const TicketPreview({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Preview Tiket")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ticket.name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "IDR ${ticket.price}/kursi",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text("${ticket.departureTime} - "),
                        Text(ticket.departureLocation),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                        "Durasi: ${_calculateDuration(ticket.departureTime, ticket.arrivalTime)} jam"),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text("${ticket.arrivalTime} - "),
                        Text(ticket.arrivalLocation),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 16),
                        SizedBox(width: 4),
                        Text("${ticket.rating}/5"),
                      ],
                    ),
                    Divider(),
                    Text("Harga/Kursi : IDR ${ticket.price}"),
                    SizedBox(height: 4),
                    Text("Total Harga: IDR ${ticket.price}"),
                    SizedBox(height: 4),
                    Text(
                        "Kode Kursi : D5"), // Replace this if you have seat information
                  ],
                ),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () => _generatePdf(context, ticket),
              child: Text("Cetak PDF"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _generatePdf(BuildContext context, Ticket ticket) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Container(
            padding: pw.EdgeInsets.all(16),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(ticket.name,
                        style: pw.TextStyle(
                            fontSize: 18, fontWeight: pw.FontWeight.bold)),
                    pw.Text("IDR ${ticket.price}/kursi",
                        style: pw.TextStyle(
                            fontSize: 16,
                            color: PdfColors.blue,
                            fontWeight: pw.FontWeight.bold)),
                  ],
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                    "${ticket.departureTime} - ${ticket.departureLocation}"),
                pw.SizedBox(height: 4),
                pw.Text(
                    "Durasi: ${_calculateDuration(ticket.departureTime, ticket.arrivalTime)} jam"),
                pw.SizedBox(height: 8),
                pw.Text("${ticket.arrivalTime} - ${ticket.arrivalLocation}"),
                pw.SizedBox(height: 8),
                pw.Text("Rating: ${ticket.rating}/5"),
                pw.Divider(),
                pw.Text("Harga/Kursi : IDR ${ticket.price}"),
                pw.SizedBox(height: 4),
                pw.Text("Total Harga: IDR ${ticket.price}"),
                pw.SizedBox(height: 4),
                pw.Text("Kode Kursi : D5"), // Replace if you have seat info
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  // Helper function for duration calculation
  String _calculateDuration(String departure, String arrival) {
    try {
      final format = DateFormat("HH:mm");
      final departureTime = format.parse(departure);
      final arrivalTime = format.parse(arrival);
      var duration = arrivalTime.difference(departureTime);

      if (duration.isNegative) {
        duration += Duration(hours: 24);
      }
      return duration.inHours.toString();
    } catch (e) {
      return '-';
    }
  }
}
