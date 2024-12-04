import 'package:flutter/material.dart';
import 'package:tugas_besar/editProfil.dart'; // Ensure you have the EditProfileScreen imported
import 'package:tugas_besar/entity/Profile.dart'; // Import the Profile class
import 'package:tugas_besar/client/ProfileClient.dart'; // Import the ProfilClient
import 'package:intl/intl.dart';

class ProfileDetailScreen extends StatelessWidget {
  const ProfileDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
        title: const Text('Detail Profil'),
      ),
      body: FutureBuilder<Profile>(
        future: ProfilClient.getProfile(), // Fetch profile data
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No profile data available'));
          }

          Profile profile = snapshot.data!; // Extract the profile data

          String formattedJoinDate = formatJoinDate(profile.tglJoin);

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Header
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(profile.imageUrl ?? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNuMtV6voiMGgINSW_PbviV6ecO3nMab9uVw&s'),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          profile.username ?? 'No Name',
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          profile.email ?? 'No Email',
                          style: const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Personal Information Section
                  _buildSectionTitle('Informasi Pribadi'),
                  _buildDetailItem(
                    icon: Icons.person,
                    title: 'Nama Lengkap',
                    subtitle: profile.name ?? 'No Name',
                  ),
                  _buildDetailItem(
                    icon: Icons.cake,
                    title: 'Tanggal Lahir',
                    subtitle: profile.tglUlt ?? 'No Birthdate',
                  ),
                  _buildDetailItem(
                    icon: Icons.phone,
                    title: 'Nomor Telepon',
                    subtitle: profile.noTelp ?? 'No Phone Number',
                  ),

                  const SizedBox(height: 20),

                  // Account Information Section
                  _buildSectionTitle('Informasi Akun'),
                  _buildDetailItem(
                    icon: Icons.email,
                    title: 'Email Terdaftar',
                    subtitle: profile.email ?? 'No Email',
                  ),
                  _buildDetailItem(
                    icon: Icons.calendar_today,
                    title: 'Tanggal Bergabung',
                    subtitle: formattedJoinDate,
                  ),

                  const SizedBox(height: 30),

                  // Edit Profile Button
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfileScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit Profil'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 50),
                        backgroundColor: Colors.blue.shade900,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget helper for creating section titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 13, 71, 161),
        ),
      ),
    );
  }

  // Widget helper for creating detail items
  Widget _buildDetailItem({required IconData icon, required String title, required String subtitle}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue.shade900),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle),
    );
  }

  String formatJoinDate(String? tanggalJoin) {
    if (tanggalJoin == null) {
      return 'No Join Date';
    }

    // Parse the date string (ISO 8601 format) to a DateTime object
    DateTime dateTime = DateTime.parse(tanggalJoin);

    // Use the intl package to format the date as "day month year"
    return DateFormat('d MMMM yyyy').format(dateTime);  // Indonesian locale
  }
}
