import 'package:flutter/material.dart';
import 'package:tugas_besar/cetakTiket.dart';
import 'package:tugas_besar/ticketList.dart';
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
    TicketList(),
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
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Stack(
                children: [
                  // Background bus image
                  Opacity(
                    opacity: 1.0,
                    child: Container(
                      height: 450,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/bus-picture.jpg'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.40),
                            BlendMode.darken,
                          ),
                        ),
                      ),
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
                          'assets/logoTravel2.png',
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
                                          borderRadius:
                                              BorderRadius.circular(25),
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
                                          borderRadius:
                                              BorderRadius.circular(25),
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
                                          borderRadius:
                                              BorderRadius.circular(25),
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
                                          builder: (context) => Cetaktiket()),
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
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/promo1.jpg'), // Ganti dengan path gambar Anda
                              fit: BoxFit
                                  .cover, // Atur bagaimana gambar ditampilkan
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text("Diskon 20%",
                                  style: TextStyle(color: Colors.white))),
                        ),
                        Container(
                          width: 150,
                          height: 100,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/promo2.jpg'), // Ganti dengan path gambar Anda
                              fit: BoxFit
                                  .cover, // Atur bagaimana gambar ditampilkan
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text("Diskon 10%",
                                  style: TextStyle(color: Colors.white))),
                        ),
                        Container(
                          width: 150,
                          height: 100,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/promo3.jpg'), // Ganti dengan path gambar Anda
                              fit: BoxFit
                                  .cover, // Atur bagaimana gambar ditampilkan
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text("Diskon 5%",
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
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/tips1.jpg'), // Ganti dengan path gambar Anda
                              fit: BoxFit
                                  .cover, // Atur bagaimana gambar ditampilkan
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text("Tips Nyaman Travel",
                                  style: TextStyle(color: Colors.white))),
                        ),
                        Container(
                          width: 150,
                          height: 100,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/tips2.jpg'), // Ganti dengan path gambar Anda
                              fit: BoxFit
                                  .cover, // Atur bagaimana gambar ditampilkan
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text("Tips Supaya Hemat",
                                  style: TextStyle(color: Colors.white))),
                        ),
                        Container(
                          width: 150,
                          height: 100,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/tips3.jpg'), // Ganti dengan path gambar Anda
                              fit: BoxFit
                                  .cover, // Atur bagaimana gambar ditampilkan
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                              alignment: Alignment.center,
                              child: Text("Tips Perjalanan Aman",
                                  style: TextStyle(color: Colors.white))),
                        ),
                        // Add more tips items as needed
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
