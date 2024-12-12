import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tugas_besar/entity/Profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tugas_besar/tokenStorage.dart';
import 'package:tugas_besar/client/ProfileClient.dart';
import 'package:tugas_besar/camera.dart';
import 'package:camera/camera.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  XFile? _image;
  Profile? _profile; // To hold the fetched profile data
  final String apiUrl = 'http://10.0.2.2:8000/api/user/update';

  final _namaLengkapController = TextEditingController();
  final _tanggalLahirController = TextEditingController();
  final _nomorTeleponController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _konfirmasiPasswordController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProfileData(); // Fetch the profile data when the screen initializes
  }

  Future<void> _fetchProfileData() async {
    try {
      Profile profile = await ProfilClient.getProfile(); // Fetch profile data
      setState(() {
        _profile = profile;
        _namaLengkapController.text = profile.name ?? '';
        _usernameController.text = profile.username ?? '';
        _nomorTeleponController.text = profile.noTelp ?? '';
        _tanggalLahirController.text = profile.tglUlt ?? '';
      });
    } catch (e) {
      print('Error fetching profile data: $e');
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      _image = pickedFile;
    });
  }

  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //Ambil Foto Menggunakan Kamera Custom
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Ambil Foto'),
              onTap: () {
                Navigator.pop(context);
                _navigateToCustomCamera();
              },
            ),
            //Memilih Foto dari Galeri Pengguna
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Pilih dari Galeri'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _navigateToCustomCamera() async {
    try {
      // Dapatkan daftar kamera
      final cameras = await availableCameras();

      if (cameras.isNotEmpty) {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CameraView(cameras: cameras),
          ),
        );

        // Cek apakah ada hasil dari kamera
        if (result != null) {
          setState(() {
            _image = result; // Simpan hasil foto dari kamera custom
          });
        }
      } else {
        // Tampilkan pesan jika tidak ada kamera yang tersedia
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tidak ada kamera yang tersedia')),
        );
      }
    } catch (e) {
      print('Kesalahan saat mengakses kamera: $e');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal membuka kamera: $e')),
      );
    }
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

      if (response.statusCode != 200) {
        print('Failed to update profile: ${response.body}');
        return false;
      }

      // Handle image upload separately if an image is selected
      if (_image != null) {
        var imageUploadRequest = http.MultipartRequest('POST', Uri.parse('http://10.0.2.2:8000/api/user/upload-image'));
        imageUploadRequest.headers['Authorization'] = 'Bearer $token';
        var file = await http.MultipartFile.fromPath('profile_image', _image!.path);
        imageUploadRequest.files.add(file);

        var imageUploadResponse = await imageUploadRequest.send();

        if (imageUploadResponse.statusCode != 200) {
          var responseBody = await imageUploadResponse.stream.bytesToString();
          print('Failed to upload profile image: $responseBody');
          return false;
        }
      }

      print('Profile updated successfully');
      return true;
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
      foregroundColor: Colors.white,
      title: const Text('Profile Update'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            // Avatar Image Picker
            Center(
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () => _pickImage(ImageSource.gallery),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: _image != null
                          ? FileImage(File(_image!.path))
                          : (_profile?.profileImage != null
                              ? NetworkImage(_profile!.profileImage!)
                              : const NetworkImage('https://example.com/default-avatar.png')) as ImageProvider,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _showImageSourceOptions,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
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

            // Username Input
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
                foregroundColor: Colors.white,
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
                        onPressed: () {
                          Navigator.of(context).pop();
                          if (success) {
                            Navigator.pop(context, true);
                          }
                        },
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
      keyboardType: keyboardType,
    );
  }
}
