import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:tugas_besar/entity/Ticket.dart';
import 'package:tugas_besar/client/TicketClient.dart';

class TicketPreview extends StatelessWidget {
  final Ticket ticket;

  const TicketPreview({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Preview Tiket")),
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
                          ticket.user?.nama ?? "Anonymous",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "IDR ${ticket.jadwal?.harga ?? 0}/kursi",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Text(
                    //     "Durasi: ${_calculateDuration(ticket.jadwal?.keberangkatan, ticket.jadwal?.kedatangan)} jam"),
                    // const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          "${ticket.jadwal?.asal} - ",
                        ),
                        Text(ticket.jadwal?.tujuan ?? "Unknown"),
                      ],
                    ),
                    const Divider(),
                    Text("Harga/Kursi : IDR ${ticket.jadwal?.harga ?? 0}"),
                    const SizedBox(height: 4),
                    Text("Total Harga: IDR ${ticket.jadwal?.harga ?? 0}"),
                  ],
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => _generatePdf(context, ticket),
              child: const Text("Cetak PDF"),
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
            padding: const pw.EdgeInsets.all(16),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey, width: 2),
              borderRadius: pw.BorderRadius.circular(8),
              color: PdfColors.lightBlue50,
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "Ticket Details",
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blue800,
                  ),
                ),
                pw.Divider(color: PdfColors.blue800),
                pw.SizedBox(height: 12),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(ticket.user?.nama ?? "Anonymous",
                        style: pw.TextStyle(
                            fontSize: 18, fontWeight: pw.FontWeight.bold)),
                    pw.Text("IDR ${ticket.jadwal?.harga ?? 0}/kursi",
                        style: pw.TextStyle(
                            fontSize: 16,
                            color: PdfColors.blue,
                            fontWeight: pw.FontWeight.bold)),
                  ],
                ),
                pw.SizedBox(height: 8),
                pw.Container(
                  padding: const pw.EdgeInsets.all(8),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.blue200, width: 1),
                    borderRadius: pw.BorderRadius.circular(6),
                    color: PdfColors.white,
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Bus: ${ticket.jadwal?.bus.namaBus}",
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 4),
                      pw.Text("Fasilitas: ${ticket.jadwal?.bus.fasilitasBus}",
                          style: pw.TextStyle(fontSize: 12)),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        "Rute: ${ticket.jadwal?.asal} - ${ticket.jadwal?.tujuan}",
                        style:
                            pw.TextStyle(fontSize: 14, color: PdfColors.black),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 12),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("Harga/Kursi:",
                        style: pw.TextStyle(
                            fontSize: 14, fontWeight: pw.FontWeight.bold)),
                    pw.Text("IDR ${ticket.jadwal?.harga ?? 0}",
                        style: pw.TextStyle(fontSize: 14)),
                  ],
                ),
                pw.SizedBox(height: 4),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("Total Harga:",
                        style: pw.TextStyle(
                            fontSize: 14, fontWeight: pw.FontWeight.bold)),
                    pw.Text("IDR ${ticket.jadwal?.harga ?? 0}",
                        style: pw.TextStyle(
                            fontSize: 14, color: PdfColors.red800)),
                  ],
                ),
                pw.SizedBox(height: 12),
                pw.Divider(color: PdfColors.blue800),
                pw.Text("Thank you for booking with us!",
                    style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.blue800)),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  String _calculateDuration(String? departure, String? arrival) {
    if (departure == null || arrival == null) {
      return '-';
    }

    try {
      final format = DateFormat("HH:mm");
      final departureTime = format.parse(departure);
      final arrivalTime = format.parse(arrival);
      var duration = arrivalTime.difference(departureTime);

      if (duration.isNegative) {
        duration += const Duration(hours: 24);
      }
      return duration.inHours.toString();
    } catch (e) {
      return '-';
    }
  }

  String _formatTime(String? time) {
    if (time == null) return "N/A";
    try {
      final format = DateFormat("HH:mm");
      final dateTime = format.parse(time);
      return DateFormat("HH:mm").format(dateTime);
    } catch (e) {
      return "Invalid Time";
    }
  }
}
