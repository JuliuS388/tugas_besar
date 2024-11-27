import 'package:flutter/material.dart';
import 'package:tugas_besar/home.dart';
import 'package:tugas_besar/register.dart';
import 'package:tugas_besar/form_component.dart';

class LoginView extends StatefulWidget {
  final Map<String, dynamic>? data;
  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? dataForm = widget.data;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 20.0, left: 20.0),
              child: const Text(
                'Welcome, Traveler',
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                                obscureText: true,
                                isVisible: _isPasswordVisible,
                                onToggleVisibility: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
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
                                    if (dataForm != null &&
                                        dataForm['email'] ==
                                            emailController.text &&
                                        dataForm['password'] ==
                                            passwordController.text) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const HomeView(),
                                        ),
                                      );
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: const Text('Login Gagal'),
                                          content: const Text(
                                              'Email atau Password salah.'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
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
                              const Text("Masuk dengan Metode Lain"),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Belum Punya Akun? "),
                                  TextButton(
                                    onPressed: () {
                                      Map<String, dynamic> formData = {
                                        'email': emailController.text,
                                        'password': passwordController.text,
                                      };
                                      pushRegister(context, formData);
                                    },
                                    child: const Text(
                                      'Daftar Sekarang!',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
