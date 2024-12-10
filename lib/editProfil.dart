import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tugas_besar/client/EditProfileClient.dart';
import 'package:tugas_besar/entity/Profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tugas_besar/tokenStorage.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  XFile? _image;
  final String apiUrl = 'http://10.0.2.2:8000/api/user/update';

  final _namaLengkapController = TextEditingController();
  final _tanggalLahirController = TextEditingController();
  final _nomorTeleponController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _konfirmasiPasswordController = TextEditingController();
  final _usernameController = TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      _image = pickedFile;
    });
  }

  Future<bool> updateProfile() async {
    try {
      final String? token = await TokenStorage.getToken(); // Replace with actual token from storage

      if (token == null) {
        print("Token is missing");
        return false;
      }

      // Prepare the profile data from text fields
      Map<String, dynamic> profileData = {
        'nama': _namaLengkapController.text,
        'username': _usernameController.text,
        'nomor_telepon': _nomorTeleponController.text,
        'tanggal_lahir': _tanggalLahirController.text,
      };

      // Send PUT request
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Include the token for authentication
        },
        body: json.encode(profileData),
      );

      if (response.statusCode == 200) {
        // Success
        print('Profile updated successfully');
        return true;
      } else {
        // Handle failure
        print('Failed to update profile: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error occurred: $e');
      return false;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _tanggalLahirController.text = picked.toIso8601String();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text('Profile Update'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              // Avatar Image Picker
              Center(
                child: GestureDetector(
                  onTap: () => _pickImage(ImageSource.gallery),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: _image != null
                        ? FileImage(File(_image!.path))
                        : const NetworkImage(
                            'https://example.com/default-avatar.png') as ImageProvider,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Name Input
              _buildTextFormField(
                controller: _namaLengkapController,
                label: 'Name',
                icon: Icons.person,
              ),
              const SizedBox(height: 20),

              // Email Input
              _buildTextFormField(
                controller: _usernameController,
                label: 'Username',
                icon: Icons.person,
              ),
              const SizedBox(height: 20),


              // Phone Number Input
              _buildTextFormField(
                controller: _nomorTeleponController,
                label: 'Phone Number',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),

              // Date of Birth Input
              TextFormField(
                controller: _tanggalLahirController,
                decoration: InputDecoration(
                  labelText: 'Date of Birth (YYYY-MM-DD)',
                  prefixIcon: const Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                readOnly: true,
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      _tanggalLahirController.text = picked.toIso8601String();
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              // Update Profile Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                ),
                onPressed: () async {
                  bool success = await updateProfile();
                  String message = success ? 'Profile Updated!' : 'Profile Update Failed!';
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text(message),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Update Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      obscureText: obscureText,
    );
  }
}
