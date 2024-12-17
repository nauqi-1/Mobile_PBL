import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'daftar_tugas.dart';
import 'notif.dart';
import 'package:testproject/dosen/profile.dart';
import '../models/login_response.dart';

class DsnHomepage extends StatefulWidget {
  final Dosen dosen;
  final LoginResponse loginResponse;
  const DsnHomepage(
      {super.key, required this.dosen, required this.loginResponse});

  @override
  State<DsnHomepage> createState() => _DsnHomepageState();
}

class _DsnHomepageState extends State<DsnHomepage> {
  void _indexDsn() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DsnHomepage(
                dosen: widget.dosen, loginResponse: widget.loginResponse)));
  }

  void _profileDsn() {
    print('Profile Dosen');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DsnProfilePage(
                dosen: widget.dosen, loginResponse: widget.loginResponse)));
  }

  void _daftarTugas() {
    print('Daftar Tugas');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const DsnDaftarTugasPage(
                  title: 'Sistem Kompensasi',
                )));
  }

  void _NotifDsn() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DsnNotif(
          title: 'Sistem Kompensasi',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff2d1b6b),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Sistem Kompensasi',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'InstrumentSans'),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                        text: 'J',
                        style: TextStyle(
                            color: Color.fromARGB(255, 153, 58, 54),
                            fontFamily: 'InstrumentSans',
                            fontSize: 19,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: 'T',
                      style: TextStyle(
                          color: Color.fromARGB(255, 240, 85, 41),
                          fontFamily: 'InstrumentSans',
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'I',
                      style: TextStyle(
                          color: Color.fromARGB(255, 254, 192, 26),
                          fontFamily: 'InstrumentSans',
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ' Polinema',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'InstrumentSans',
                        fontSize: 19,
                      ),
                    ),
                  ]),
                )
              ],
            ),
            IconButton(
                onPressed: _NotifDsn,
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                ))
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Selamat datang,',
              style: TextStyle(
                fontFamily: 'InstrumentSans',
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.dosen.dosenNama,
              style: const TextStyle(
                fontFamily: 'InstrumentSans',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Image(
              image: AssetImage('assets/images/logo-polinema.png'),
              height: 150,
            ),
            const SizedBox(height: 30),
            const InputField(labelText: 'Total Tugas Kompensasi'),
            const SizedBox(height: 10),
            const InputField(labelText: 'Jumlah Tugas Kompensasi Dikerjakan'),
            const SizedBox(height: 10),
            const InputField(labelText: 'Jumlah Permintaan Tugas Kompensasi'),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
          height: 70,
          child: Container(
            color: const Color(0xff2d1b6b),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: _indexDsn,
                    icon: const Icon(
                      Icons.home_outlined,
                      color: Colors.white,
                      size: 35,
                    )),
                IconButton(
                    onPressed: _daftarTugas,
                    icon: const Icon(
                      Icons.list_sharp,
                      color: Colors.white,
                      size: 30,
                    )),
                IconButton(
                    onPressed: _NotifDsn,
                    icon: const Icon(
                      CupertinoIcons.briefcase,
                      color: Colors.white,
                      size: 30,
                    )),
                IconButton(
                    onPressed: _profileDsn,
                    icon: const Icon(Icons.account_circle_outlined,
                        color: Colors.white, size: 35))
              ],
            ),
          )),
    );
  }
}

class InputField extends StatelessWidget {
  final String labelText;
  const InputField({super.key, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
    );
  }
}
