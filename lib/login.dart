import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:testproject/mahasiswa/homepage.dart';
import 'change_password.dart';
import 'dosen/homepage.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _textUsername = TextEditingController();
  final TextEditingController _textPassword = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _textUsername.dispose();
    _textPassword.dispose();
    super.dispose();
  }

  Future<void> submitForm() async {
    setState(() {
      _isLoading = true;
    });

    const String apiUrl = 'http://192.168.67.76:8000/api/login';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": _textUsername.text,
        "password": _textPassword.text,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print(responseData);
      final int levelId = responseData['user']['level_id'];
      if (levelId == 4) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MhsHomepageHutang(),
          ),
        );
      } else if (levelId == 2 || levelId == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DsnHomepage(),
          ),
        );
      } else {
        _showErrorDialog();
      }
    } else {
      _showErrorDialog();
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text(
            'Error',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          content: Text(
            'Username atau Password tidak ditemukan.',
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff2d1b6b),
        title: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(height: 4),
              RichText(
                text: const TextSpan(children: [
                  TextSpan(
                      text: 'J',
                      style: TextStyle(
                          color: Color.fromARGB(255, 153, 58, 54),
                          fontSize: 19,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: 'T',
                    style: TextStyle(
                        color: Color.fromARGB(255, 240, 85, 41),
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'I',
                    style: TextStyle(
                        color: Color.fromARGB(255, 254, 192, 26),
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ' Polinema',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 70),
            Image.asset(
              'assets/images/logo-polinema.png',
              height: 150,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Username',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _textUsername,
                    decoration: const InputDecoration(
                      hintText: 'Ketik Username',
                      hintStyle: TextStyle(color: Color(0xffd9d9d9)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Color(0xFFd9d9d9),
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Password',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _textPassword,
                    decoration: const InputDecoration(
                      hintText: 'Ketik Password',
                      hintStyle: TextStyle(color: Color(0xffd9d9d9)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Color(0xFFd9d9d9),
                          width: 1.0,
                        ),
                      ),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                      onPressed: _isLoading ? null : submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2c2c2c),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                SizedBox(width: 5),
                                Icon(
                                  Icons.login,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ],
                            )),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChangePasswordPage(
                                    title: 'Sistem Kompensasi',
                                  )),
                        );
                      },
                      child: const Text(
                        'Lupa Password?',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
