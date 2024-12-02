import 'package:flutter/material.dart';
import 'package:tugas_besar/detailBus.dart';
import 'package:tugas_besar/pembayaran.dart';
import 'package:tugas_besar/ticketList.dart';
import 'package:tugas_besar/ticket_preview.dart';
import 'package:tugas_besar/view_list.dart';
import 'package:tugas_besar/profile.dart';
import 'package:tugas_besar/histori_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _widgetOptions = <Widget>[
    const HomeContent(),
    TicketPreview(
      ticket: Ticket(
        name: 'Contoh Tiket',
        price: 100000.toString(),
        departureTime: '08:00',
        departureLocation: 'Jakarta',
        arrivalTime: '10:00',
        arrivalLocation: 'Bandung',
        rating: 4.5,
      ),
    ),
    HistoriPage(),
    const ProfileScreen(),

    // Add any additional views here as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue.shade900,
        unselectedItemColor: Colors.grey,
        iconSize: 40,
        showUnselectedLabels: false,
        backgroundColor: Colors.blue.shade900,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_document), // Set icon color to white
            label: 'Cetak',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timelapse_rounded), // Set icon color to white
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController dateController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with Bus Image and Logo
            Stack(
              children: [
                // Background bus image
                Container(
                  height: 450, // Set height for header area
                  child: Image.asset(
                    'assets/bus-picture.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                // Overlay logo and search form
                Positioned(
                  top: 50,
                  left: 20,
                  right: 20,
                  child: Column(
                    children: [
                      // Atma Travel logo
                      Image.asset(
                        'assets/logoTravel.png',
                        height: 80,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.blue
                              .shade900, // Background color for better readability
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cari Tiket',
                              style: TextStyle(
                                color: Colors.white, // Warna teks
                                fontSize: 20, // Ukuran font
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Dari',
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Tujuan',
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101),
                                      );
                                      if (pickedDate != null) {
                                        dateController.text =
                                            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                                      }
                                    },
                                    child: AbsorbPointer(
                                      child: TextFormField(
                                        controller: dateController,
                                        decoration: InputDecoration(
                                          hintText: 'Tanggal Berangkat',
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          prefixIcon:
                                              Icon(Icons.calendar_today),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Kursi',
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TicketList()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.yellow,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text('Cari',
                                    style: TextStyle(color: Colors.black)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Promo Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Promo',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // Horizontal Scrollable List for Promo
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // Add your promo items here
                        Container(
                          width: 150,
                          height: 100,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text("Promo 1",
                                  style: TextStyle(color: Colors.white))),
                        ),
                        Container(
                          width: 150,
                          height: 100,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text("Promo 2",
                                  style: TextStyle(color: Colors.white))),
                        ),
                        Container(
                          width: 150,
                          height: 100,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text("Promo 3",
                                  style: TextStyle(color: Colors.white))),
                        ),
                        // Add more promo items as needed
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Tips Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tips',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // Horizontal Scrollable List for Tips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // Add your tips items here
                        Container(
                          width: 150,
                          height: 100,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text("Tips 1",
                                  style: TextStyle(color: Colors.white))),
                        ),
                        Container(
                          width: 150,
                          height: 100,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text("Tips 2",
                                  style: TextStyle(color: Colors.white))),
                        ),
                        Container(
                          width: 150,
                          height: 100,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text("Tips 3",
                                  style: TextStyle(color: Colors.white))),
                        ),
                        // Add more tips items as needed
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
