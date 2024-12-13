import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:tugas_besar/entity/Ticket.dart';

class TicketPreview extends StatelessWidget {
  final Ticket ticket;

  const TicketPreview({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview Tiket"),
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
      ),
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
                          ticket.penumpang?.namaPenumpang ?? "Anonymous",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "IDR ${ticket.pemesanan?.jadwal?.harga ?? 0}/kursi",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          "${ticket.pemesanan?.jadwal?.asal ?? 'N/A'} - ",
                        ),
                        Text(ticket.pemesanan?.jadwal?.tujuan ?? "N/A"),
                      ],
                    ),
                    const Divider(),
                    Text(
                        "Harga/Kursi : IDR ${ticket.pemesanan?.jadwal?.harga ?? 0}"),
                    const SizedBox(height: 4),
                    Text(
                        "Total Harga: IDR ${ticket.pemesanan?.jadwal?.harga ?? 0}"),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () => _generatePdf(context, ticket),
                child: const Text("Cetak PDF",
                    style: TextStyle(color: Colors.white)),
              ),
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
                  "Detail Tiket",
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
                    pw.Text(ticket.penumpang?.namaPenumpang ?? "Anonymous",
                        style: pw.TextStyle(
                            fontSize: 18, fontWeight: pw.FontWeight.bold)),
                    pw.Text("IDR ${ticket.pemesanan?.jadwal?.harga ?? 0}/kursi",
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
                      pw.Text(
                          "Bus: ${ticket.pemesanan?.jadwal?.bus?.namaBus ?? 'N/A'}",
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 4),
                      pw.Text(
                          "Fasilitas: ${ticket.pemesanan?.jadwal?.bus?.fasilitasBus ?? 'N/A'}",
                          style: pw.TextStyle(fontSize: 12)),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        "Rute: ${ticket.pemesanan?.jadwal?.asal ?? 'N/A'} - ${ticket.pemesanan?.jadwal?.tujuan ?? 'N/A'}",
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
                    pw.Text("Total Harga:",
                        style: pw.TextStyle(
                            fontSize: 14, fontWeight: pw.FontWeight.bold)),
                    pw.Text("IDR ${ticket.pemesanan?.jadwal?.harga ?? 0}",
                        style: pw.TextStyle(
                            fontSize: 14, color: PdfColors.red800)),
                  ],
                ),
                pw.SizedBox(height: 12),
                pw.Divider(color: PdfColors.blue800),
                pw.Text("Terima kasih telah memesan!",
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
}
