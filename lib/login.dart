import 'package:flutter/material.dart';
import 'package:tugas_besar/home.dart';
import 'package:tugas_besar/register.dart';
import 'package:tugas_besar/form_component.dart';
import 'package:tugas_besar/client/UserClientLogin.dart';
import 'package:tugas_besar/tokenStorage.dart'; // Pastikan import ini ada
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Menyimpan idUser
Future<void> saveUserId(int idUser) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('userId', idUser);
}

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
  bool _isLoading = false;
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      emailController.text = widget.data?['email'] ?? '';
      passwordController.text = widget.data?['password'] ?? '';
    }
    fToast = FToast();
  }

  // Fungsi Login
  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        bool isLoginValid = await UserClientlogin.login(
          emailController.text,
          passwordController.text,
        );

        if (isLoginValid) {
          // Ambil user ID setelah login berhasil
          int? userId = await TokenStorage.getUserId();
          print('Login Berhasil. User ID: $userId');

          // Toast Berhasil Login
          fToast.showToast(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 12.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.green,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 12.0),
                  Text(
                    "Login Berhasil!",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            gravity: ToastGravity.TOP,
            toastDuration: const Duration(seconds: 3),
          );

          // Direct ke halaman login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const HomeView(),
            ),
          );
        } else {
          _showErrorDialog('Email atau Password salah.');
        }
      } catch (e) {
        _showErrorDialog('Terjadi kesalahan: ${e.toString()}');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Alert Gagal
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Login Gagal'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
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
                                (p0) => p0 == null || p0.isEmpty
                                    ? "Email tidak boleh kosong"
                                    : null,
                                controller: emailController,
                                hintTxt: "Email",
                                iconData: Icons.email,
                              ),
                              const SizedBox(height: 20),
                              inputForm(
                                (p0) => p0 == null || p0.isEmpty
                                    ? "Password tidak boleh kosong"
                                    : null,
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
                              _isLoading
                                  ? const CircularProgressIndicator()
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 50,
                                          vertical: 15,
                                        ),
                                      ),
                                      onPressed: _login,
                                      child: const Text(
                                        'Masuk',
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const RegisterView(),
                                        ),
                                      );
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
}
