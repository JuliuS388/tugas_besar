import 'package:flutter/material.dart';
import 'package:tugas_besar/client/UserClientLogin.dart';
import 'package:tugas_besar/detailProfil.dart';
import 'package:tugas_besar/entity/Profile.dart';
import 'package:tugas_besar/client/profileClient.dart';
import 'package:tugas_besar/login.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: FutureBuilder<Profile>(
        future: ProfilClient.getProfile(), // Fetch the profile data
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Show loading spinner while fetching
          }

          if (snapshot.hasError) {
            return Center(
                child: Text(
                    'Error: ${snapshot.error}')); // Show error if there was a problem fetching the data
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No profile data found'));
          }

          // If profile data is fetched successfully, display it
          final profile = snapshot.data!;

          return Column(
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(profile.imageUrl ??
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNuMtV6voiMGgINSW_PbviV6ecO3nMab9uVw&s'), // Use profile image if available
                    ),
                    const SizedBox(height: 10),
                    Text(
                      profile.username ??
                          'Username', // Use profile name if available
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      profile.email ??
                          'Email', // Use profile email if available
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextButton.icon(
                      onPressed: () {
                        // Navigate to profile detail screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileDetailScreen()),
                        );
                      },
                      icon: const Icon(Icons.person,
                          size: 16, color: Colors.black),
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
                          // Implement action for Bantuan
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
                          UserClientlogin.logout();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginView()),
                            (route) => false,
                          );
                          // Implement action for Keluar (Logout)
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
