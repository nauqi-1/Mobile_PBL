import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'daftar_tugas.dart';
import 'notifikasi.dart';
import 'package:testproject/dosen/profile.dart';

class DsnHomepage extends StatefulWidget {
  const DsnHomepage({super.key});

  @override
  State<DsnHomepage> createState() => _DsnHomepageState();
}

class _DsnHomepageState extends State<DsnHomepage> {
  void _indexDsn() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const DsnHomepage()));
  }

  void _profileDsn() {
    print('Profile Dosen');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const DsnProfilePage(title: 'Sistem Kompensasi')));
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

  void _notifDsn() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DsnNotifikasiPage(
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
                  style: TextStyle(color: Colors.white, fontSize: 20),
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
            IconButton(
                onPressed: _notifDsn,
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                ))
          ],
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              'Selamat datang,\nUsman Nurhasan, S.Kom., M.T.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Image(
              image: AssetImage('assets/images/logo-polinema.png'),
              height: 150,
            ),
            SizedBox(height: 30),
            InputField(labelText: 'Total Tugas Kompensasi'),
            SizedBox(height: 10),
            InputField(labelText: 'Jumlah Tugas Kompensasi Dikerjakan'),
            SizedBox(height: 10),
            InputField(labelText: 'Jumlah Permintaan Tugas Kompensasi'),
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
                    onPressed: _notifDsn,
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
