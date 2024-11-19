import 'package:flutter/material.dart';
import 'package:tugas_besar/editProfil.dart'; // Pastikan untuk mengimpor halaman EditProfileScreen

class ProfileDetailScreen extends StatelessWidget {
  const ProfileDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('Detail Profil'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bagian Profil Utama
              const Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNuMtV6voiMGgINSW_PbviV6ecO3nMab9uVw&s'),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Panji Anugrah',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'panjianugrah@gmail.com',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Informasi Pribadi
              _buildSectionTitle('Informasi Pribadi'),
              _buildDetailItem(
                icon: Icons.person,
                title: 'Nama Lengkap',
                subtitle: 'Panji Anugrah',
              ),
              _buildDetailItem(
                icon: Icons.cake,
                title: 'Tanggal Lahir',
                subtitle: '15 Agustus 1999',
              ),
              _buildDetailItem(
                icon: Icons.phone,
                title: 'Nomor Telepon',
                subtitle: '+62 812-3456-7890',
              ),

              const SizedBox(height: 20),

              // Informasi Akun
              _buildSectionTitle('Informasi Akun'),
              _buildDetailItem(
                icon: Icons.email,
                title: 'Email Terdaftar',
                subtitle: 'panjianugrah@gmail.com',
              ),
              _buildDetailItem(
                icon: Icons.calendar_today,
                title: 'Tanggal Bergabung',
                subtitle: '1 Januari 2023',
              ),

              const SizedBox(height: 30),

              // Tombol Edit Profil
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditProfileScreen()));
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit Profil'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget helper untuk membuat judul section
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    );
  }

  // Widget helper untuk membuat item detail
  Widget _buildDetailItem(
      {required IconData icon,
      required String title,
      required String subtitle}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle),
    );
  }
}
