import 'package:flutter/material.dart';
import 'package:tugas_besar/detailProfil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(height: 60),
                const Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNuMtV6voiMGgINSW_PbviV6ecO3nMab9uVw&s'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'panjianugrah',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'panjianugrah@gmail.com',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 5),
                TextButton.icon(
                  onPressed: () {
                    // Navigasi ke halaman Detail Profil ketika tombol Detail Akun diklik
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileDetailScreen()),
                    );
                  },
                  icon: const Icon(Icons.person, size: 16, color: Colors.black),
                  label: const Text(
                    'Detail Profil',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ListTile(
                    leading:
                        const Icon(Icons.help_outline, color: Colors.black),
                    title: const Text('Bantuan',
                        style: TextStyle(color: Colors.black)),
                    trailing:
                        const Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () {
                      // Implementasi untuk Bantuan
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.black),
                    title: const Text('Keluar',
                        style: TextStyle(color: Colors.black)),
                    trailing:
                        const Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () {
                      // Implementasi untuk Keluar
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
