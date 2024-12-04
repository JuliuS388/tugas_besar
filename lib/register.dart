import 'package:flutter/material.dart';
import 'package:tugas_besar/login_page.dart';
import 'package:tugas_besar/form_component.dart';
import 'package:tugas_besar/client/UserClientRegister.dart';
import 'package:tugas_besar/entity/User.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Create a new User object with the input data
        User newUser = User(
          id: 0, // The backend will likely generate the ID
          nama: nameController.text,
          username: usernameController.text,
          email: emailController.text,
          password: passwordController.text,
          nomorTelepon: phoneController.text,
        );

        // Use UserClient to create the user
        await UserClientRegister.create(newUser);

        // Show success dialog
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Registrasi Berhasil'),
            content: const Text('Akun Anda telah terdaftar. Silakan login.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LoginView(
                        data: {
                          'email': emailController.text,
                          'password': passwordController.text,
                        },
                      ),
                    ),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } catch (e) {
        // Show error dialog if registration fails
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Registrasi Gagal'),
            content: Text('Terjadi kesalahan: ${e.toString()}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const LoginView()));
            },
            padding: EdgeInsets.zero,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'DAFTAR',
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
                              return "Nama tidak boleh kosong";
                            }
                            return null;
                          },
                          controller: nameController,
                          hintTxt: "Nama Lengkap",
                          iconData: Icons.person,
                        ),
                        const SizedBox(height: 15),
                        inputForm(
                          (value) {
                            if (value == null || value.isEmpty) {
                              return "Username tidak boleh kosong";
                            }
                            return null;
                          },
                          controller: usernameController,
                          hintTxt: "Username",
                          iconData: Icons.account_circle,
                        ),
                        const SizedBox(height: 15),
                        inputForm(
                          (value) {
                            if (value == null || value.isEmpty) {
                              return "Email tidak boleh kosong";
                            }
                            // Basic email validation
                            final emailRegex =
                                RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                            if (!emailRegex.hasMatch(value)) {
                              return "Format email tidak valid";
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
                            if (value.length < 6) {
                              return "Password minimal 6 karakter";
                            }
                            return null;
                          },
                          controller: passwordController,
                          hintTxt: "Password",
                          iconData: Icons.lock,
                          obscureText: !_isPasswordVisible,
                          isVisible: _isPasswordVisible,
                          onToggleVisibility: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
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
                          hintTxt: "Konfirmasi Password",
                          iconData: Icons.lock_outline,
                          obscureText: !_isConfirmPasswordVisible,
                          isVisible: _isConfirmPasswordVisible,
                          onToggleVisibility: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        inputForm(
                          (value) {
                            if (value == null || value.isEmpty) {
                              return "Nomor Telepon tidak boleh kosong";
                            }
                            // Basic phone number validation
                            final phoneRegex = RegExp(r'^[0-9]{10,13}$');
                            if (!phoneRegex.hasMatch(value)) {
                              return "Nomor Telepon tidak valid";
                            }
                            return null;
                          },
                          controller: phoneController,
                          hintTxt: "Nomor Telepon",
                          iconData: Icons.phone,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 20),
                        _isLoading
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
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
                                onPressed: _register,
                                child: const Text(
                                  'DAFTAR',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                        const SizedBox(height: 10),
                        const Text('Daftar dengan Metode Lain'),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Sudah punya akun?'),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const LoginView()));
                              },
                              child: const Text(
                                'Masuk Sekarang!',
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                        )
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
