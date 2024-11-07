import 'package:flutter/material.dart';
import 'package:tugas_besar/login_page.dart';
import 'package:tugas_besar/form_component.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  void _register() {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> formData = {};
      formData['email'] = emailController.text;
      formData['password'] = passwordController.text;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => LoginView(data: formData),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'REGISTER',
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
                          (value) {
                            if (value == null || value.isEmpty) {
                              return "Username tidak boleh kosong";
                            }
                            return null;
                          },
                          controller: usernameController,
                          hintTxt: "Username",
                          iconData: Icons.person,
                        ),
                        const SizedBox(height: 15),
                        inputForm(
                          (value) {
                            if (value == null || value.isEmpty) {
                              return "Email tidak boleh kosong";
                            }
                            return null;
                          },
                          controller: emailController,
                          hintTxt: "Email",
                          iconData: Icons.email,
                        ),
                        const SizedBox(height: 15),
                        inputForm(
                          (value) {
                            if (value == null || value.isEmpty) {
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
                        const SizedBox(height: 15),
                        inputForm(
                          (value) {
                            if (value == null || value.isEmpty) {
                              return "Konfirmasi Password tidak boleh kosong";
                            } else if (value != passwordController.text) {
                              return "Password tidak cocok";
                            }
                            return null;
                          },
                          controller: confirmPasswordController,
                          hintTxt: "Confirm Password",
                          iconData: Icons.lock_outline,
                          obscureText: true, // Menyembunyikan teks
                          isVisible:
                              _isConfirmPasswordVisible, // Status visibility
                          onToggleVisibility: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible; // Toggle visibility
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        inputForm(
                          (value) {
                            if (value == null || value.isEmpty) {
                              return "Nomor Telepon tidak boleh kosong";
                            }
                            return null;
                          },
                          controller: phoneController,
                          hintTxt: "Nomor Telepon",
                          iconData: Icons.phone,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              // Perbaikan di sini
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 15,
                            ),
                          ),
                          onPressed: _register,
                          child: const Text(
                            'REGISTER',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text('Sign Up With'),
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
}
