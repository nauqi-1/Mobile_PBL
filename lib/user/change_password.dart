import 'package:flutter/material.dart';
import 'package:testproject/main.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key, required this.title});

  final String title;

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _textUsername = TextEditingController();
  String _inputUsername = "";

  final TextEditingController _textPassword = TextEditingController();
  String _inputPassword = "";

  final TextEditingController _textConfirmPassword = TextEditingController();
  String _inputConfirmPassword = "";

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _textUsername.dispose();
    _textPassword.dispose();
    _textConfirmPassword.dispose();
    super.dispose();
  }

  void _submitForm() {
    print(_inputUsername);
    print(_inputPassword);
    print(_inputConfirmPassword);

    if (_inputPassword == _inputConfirmPassword) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const MyHomePage(title: 'Sistem Kompensasi')),
                    (Route<dynamic> route) => false);
              },
              child: const AlertDialog(
                title: Text(
                  'Berhasil!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: Text(
                    'Password berhasil diperbarui, silahkan login kembali!'),
              ),
            );
          });
    }

    _textUsername.clear();
    _textPassword.clear();
    _textConfirmPassword.clear();
  }

  void _notificationPage() {
    print("Pergi ke laman notifikasi! :3");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xFF00086B),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
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
                            color: Colors.brown,
                            fontSize: 19,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: 'T',
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'I',
                      style: TextStyle(
                          color: Colors.yellow,
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
            const SizedBox(width: 50),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  'UBAH\nPASSWORD',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 50),
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
                'Password Baru',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _textPassword,
                decoration: const InputDecoration(
                  hintText: 'Ketik Password Baru',
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
              const SizedBox(height: 20),
              const Text(
                'Konfirmasi Password Baru',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _textConfirmPassword,
                decoration: const InputDecoration(
                  hintText: 'Konfirmasi Password Baru',
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
                onChanged: (confirmPassword) {
                  setState(() {
                    _inputConfirmPassword = confirmPassword;
                  });
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2c2c2c),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Konfirmasi',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
