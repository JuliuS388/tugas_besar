import 'package:flutter/material.dart';
import 'package:tugas_besar/home.dart';
import 'package:tugas_besar/register.dart';
import 'package:tugas_besar/form_component.dart';

class LoginView extends StatefulWidget {
  final Map<String, dynamic>?
      data; // Menggunakan Map<String, dynamic> untuk data
  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false; // Menyimpan status visibilitas password

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? dataForm =
        widget.data; // Menggunakan Map<String, dynamic> untuk dataForm
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0, left: 20.0),
                    child: Text(
                      'Welcome, Traveler',
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'MASUK',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        inputForm(
                          (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return "Email tidak boleh kosong";
                            }
                            return null;
                          },
                          controller: emailController,
                          hintTxt: "Email",
                          iconData: Icons.email,
                        ),
                        const SizedBox(height: 20),
                        inputForm(
                          (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return "Password tidak boleh kosong";
                            }
                            return null;
                          },
                          controller: passwordController,
                          hintTxt: "Password",
                          iconData: Icons.lock,
                          obscureText: true, // Menyembunyikan teks
                          isVisible: _isPasswordVisible, // Status visibility
                          onToggleVisibility: () {
                            setState(() {
                              _isPasswordVisible =
                                  !_isPasswordVisible; // Toggle visibility
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 15,
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Pastikan dataForm tidak null sebelum mengaksesnya
                              if (dataForm != null &&
                                  dataForm['email'] == emailController.text &&
                                  dataForm['password'] ==
                                      passwordController.text) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const HomeView(),
                                  ),
                                );
                              } else {
                                // Tampilkan dialog jika login gagal
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text('Login Gagal'),
                                    content: const Text(
                                        'Email atau Password salah.'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text(
                            'MASUK',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Belum Punya Akun? "),
                            TextButton(
                              onPressed: () {
                                // Kirim data ke halaman pendaftaran
                                Map<String, dynamic> formData = {
                                  'email': emailController.text,
                                  'password': passwordController.text,
                                };
                                pushRegister(context, formData);
                              },
                              child: const Text(
                                'Daftar',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text('Masuk dengan Akun Lain'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.blue.shade900.withOpacity(0.8),
    );
  }

  void pushRegister(BuildContext context, Map<String, dynamic> formData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RegisterView(),
      ),
    );
  }
}
