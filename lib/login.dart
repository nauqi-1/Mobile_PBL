import 'package:flutter/material.dart';
import 'package:testproject/mahasiswa/homepage.dart';
import 'change_password.dart';
import 'dosen/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _textUsername = TextEditingController();
  String _inputUsername = "";

  final TextEditingController _textPassword = TextEditingController();
  String _inputPassword = "";

  @override
  void dispose() {
    _textUsername.dispose();
    _textPassword.dispose();
    super.dispose();
  }

  void _submitForm() {
    print(_inputUsername);
    print(_inputPassword);

    if (_inputUsername == "mahasiswa" && _inputPassword == "123") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MhsHomepageHutang(),
        ),
      );
    } else if (_inputUsername == "dosen" && _inputPassword == "123") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DsnHomepage(),
        ),
      );
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text(
                'Error',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              content: Text(
                'Username atau Password tidak ditemukan.',
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
            );
          });
    }
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
            const SizedBox(
              height: 70,
            ),
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
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
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
                    onChanged: (username) {
                      setState(() {
                        _inputUsername = username;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Password',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
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
                    onChanged: (password) {
                      setState(() {
                        _inputPassword = password;
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2c2c2c),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          SizedBox(
                            width: 5,
                          ),
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
                        style: TextStyle(
                          color: Colors.black,
                        ),
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
