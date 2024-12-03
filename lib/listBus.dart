import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:tugas_besar/detailBus.dart';
import 'package:tugas_besar/entity/Bus.dart';
import 'package:tugas_besar/client/BusClient.dart';
import 'package:intl/intl.dart';

class ListBus extends StatefulWidget {
  final String asal;
  final String tujuan;

  const ListBus({super.key, required this.asal, required this.tujuan});

  @override
  State<ListBus> createState() => _ListBusState();
}

class _ListBusState extends State<ListBus> {
  List<Bus> busList = []; // List to store bus data
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBuses(); // Fetch bus data when the page initializes
  }

  Future<void> _fetchBuses() async {
    try {
      List<Bus> fetchedBuses =
          await BusClient.fetchFiltered(widget.asal, widget.tujuan);
      setState(() {
        busList = fetchedBuses; // Update bus list
        isLoading = false; // Stop loading indicator
      });
    } catch (e) {
      print("Error fetching buses: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch buses: $e")),
      );
      setState(() {
        isLoading = false; // Stop loading even on error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text('Cari Tiket', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: busList.length,
              itemBuilder: (context, index) {
                final bus = busList[index];
                return InkWell(
                  onTap: () {
                    try {
                      print("Bus tapped: ${bus.namaBus}");
                      print("Bus details: $bus");
                      if (bus != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailBus(bus: bus),
                          ),
                        );
                      } else {
                        print("Bus object is null");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Bus data is incomplete")),
                        );
                      }
                    } catch (e, stackTrace) {
                      print("Navigation error: $e");
                      print("Stack trace: $stackTrace");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Failed to open bus details: $e")),
                      );
                    }
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      elevation: 3,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bus.namaBus ?? 'Nama Bus Tidak Tersedia',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      bus.asalBus ?? 'Asal Tidak Tersedia',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      bus.tujuanBus ?? 'Tujuan Tidak Tersedia',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Column(
                                      children: [
                                        DottedLine(dashColor: Colors.grey),
                                        SizedBox(height: 4),
                                        Text(
                                          'Durasi: - jam',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
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
                                      bus.tujuanBus ?? 'Tujuan Tidak Tersedia',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      bus.fasilitasBus ??
                                          'Fasilitas Tidak Tersedia',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  String _calculateDuration(String departure, String arrival) {
    try {
      final format = DateFormat("HH:mm");
      final departureTime = format.parse(departure);
      final arrivalTime = format.parse(arrival);
      var duration = arrivalTime.difference(departureTime);

      // If duration is negative, add 24 hours to adjust for overnight travel
      if (duration.isNegative) {
        duration += Duration(hours: 24);
      }
      return duration.inHours.toString();
    } catch (e) {
      return '-';
    }
  }
}
