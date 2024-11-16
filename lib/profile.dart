import 'package:flutter/material.dart';

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
                SizedBox(height: 60), 
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNuMtV6voiMGgINSW_PbviV6ecO3nMab9uVw&s'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
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
                SizedBox(height: 5),
                TextButton.icon(
                  onPressed: () {
                    
                  },
                  icon: Icon(Icons.edit, size: 16, color: Colors.black),
                  label: Text(
                    'Detail Akun',
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
          SizedBox(height: 30),
          Expanded(
            child: Container(
              color: Colors.white, 
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.help_outline, color: Colors.black),
                    title: Text('Bantuan', style: TextStyle(color: Colors.black)),
                    trailing: Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () {
                      
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.black),
                    title: Text('Keluar', style: TextStyle(color: Colors.black)),
                    trailing: Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () {
                      
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
