import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TicketPreview(),
    );
  }
}

class TicketPreview extends StatelessWidget {
  final String companyName = "Handoyo";
  final String departureTime = "13:00";
  final String departureLocation = "Pulo Gadung";
  final String arrivalTime = "03:00";
  final String arrivalLocation = "Terminal Jombor";
  final String price = "IDR 200,000";
  final String seatCode = "D5";
  final double rating = 4.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Preview")),
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
                          companyName,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          price + "/kursi",
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
                        Text("$departureTime - "),
                        Text(departureLocation),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text("14 jam"),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text("$arrivalTime - "),
                        Text(arrivalLocation),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 16),
                        SizedBox(width: 4),
                        Text("$rating/5"),
                      ],
                    ),
                    Divider(),
                    Text("Harga/Kursi : $price"),
                    SizedBox(height: 4),
                    Text("Total Harga: $price"),
                    SizedBox(height: 4),
                    Text("Kode Kursi : $seatCode"),
                  ],
                ),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () => _generatePdf(context),
              child: Text("Cetak PDF"),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _generatePdf(BuildContext context) async {
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
                    pw.Text(companyName,
                        style: pw.TextStyle(
                            fontSize: 18, fontWeight: pw.FontWeight.bold)),
                    pw.Text(price + "/kursi",
                        style: pw.TextStyle(
                            fontSize: 16,
                            color: PdfColors.blue,
                            fontWeight: pw.FontWeight.bold)),
                  ],
                ),
                pw.SizedBox(height: 8),
                pw.Text("$departureTime - $departureLocation"),
                pw.SizedBox(height: 4),
                pw.Text("14 jam"),
                pw.SizedBox(height: 8),
                pw.Text("$arrivalTime - $arrivalLocation"),
                pw.SizedBox(height: 8),
                pw.Text("Rating: $rating/5"),
                pw.Divider(),
                pw.Text("Harga/Kursi : $price"),
                pw.SizedBox(height: 4),
                pw.Text("Total Harga: $price"),
                pw.SizedBox(height: 4),
                pw.Text("Kode Kursi : $seatCode"),
              ],
            ),
          );
        },
      ),
    );

    // Print or save the PDF
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
