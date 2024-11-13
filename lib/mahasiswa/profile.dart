import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testproject/mahasiswa/daftar_tersedia.dart';
import '../change_password.dart';
import 'edit_profile.dart';
import 'package:testproject/login.dart';
import 'homepage.dart';
import 'notifikasi.dart';
import 'daftar_terambil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MhsProfilePage extends StatefulWidget {
  const MhsProfilePage({super.key, required this.title});

  final String title;

  @override
  State<MhsProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<MhsProfilePage> {
  SharedPreferences prefs = await.SharedPreferences.getInstance();

  String nama = "Ahmad Husain";
  String nim = "2241760046";
  String prodi = "Sistem Informasi Bisnis";
  String kelas = "3B";
  String noHp = "08xxxxxx";
  String kompetensi = "Video Editing, Photography, Web Design";

  void _editProfile() {
    print('Edit Profile');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const EditProfilePage(
                  title: 'Sistem Kompensasi',
                )));
  }

  void _logOut() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const LoginPage(
                  title: 'Sistem Kompensasi',
                )));
  }

  void _indexMhs() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const MhsHomepageHutang()));
  }

  void _tugasTersedia() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const MhsDaftarTersedia(
                  title: '',
                )));
  }

  void _tugasTerambil() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const MhsDaftarTerambil(
                  title: 'Sistem Kompensasi',
                )));
  }

  void _notifMhs() {
    print('Notifikasi Mahasiswa');
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const MhsNotification()));
  }

  void _profileMhs() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const MhsProfilePage(title: 'Sistem Kompensasi')));
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
                Text(
                  widget.title,
                  style: const TextStyle(
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
                onPressed: _notifMhs,
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                ))
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
              const SizedBox(height: 20),
              const Center(
                  child: Icon(
                Icons.account_circle_outlined,
                size: 100,
              )),
              const SizedBox(height: 20),
              const Text(
                'Nama Lengkap',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 500,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xFFd9d9d9), width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  nama,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'NIM',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 500,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xFFd9d9d9), width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  nim,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Program Studi',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 500,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xFFd9d9d9), width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  prodi,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Kelas',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 500,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xFFd9d9d9), width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  kelas,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'No. HP',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 500,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xFFd9d9d9), width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  noHp,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Kompetensi',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 500,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xFFd9d9d9), width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  kompetensi,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: _editProfile,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        backgroundColor: const Color(0xFF2c2c2c),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.edit_outlined,
                            color: Colors.white,
                          ),
                          Text(
                            'Edit',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )),
                  const SizedBox(width: 20),
                  ElevatedButton(
                      onPressed: _logOut,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        backgroundColor: const Color(0xFF2c2c2c),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(children: <Widget>[
                        Icon(
                          Icons.logout_outlined,
                          color: Colors.white,
                        ),
                        Text(
                          'Log Out',
                          style: TextStyle(color: Colors.white),
                        ),
                      ])),
                ],
              ),
              const SizedBox(height: 20),
              Center(
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
                    'Ganti Password',
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
                    onPressed: _indexMhs,
                    icon: const Icon(
                      Icons.home_outlined,
                      color: Colors.white,
                      size: 35,
                    )),
                IconButton(
                    onPressed: _tugasTersedia,
                    icon: const Icon(
                      Icons.list_sharp,
                      color: Colors.white,
                      size: 30,
                    )),
                IconButton(
                    onPressed: _tugasTerambil,
                    icon: const Icon(
                      CupertinoIcons.briefcase,
                      color: Colors.white,
                      size: 30,
                    )),
                IconButton(
                    onPressed: _profileMhs,
                    icon: const Icon(Icons.account_circle_outlined,
                        color: Colors.white, size: 35))
              ],
            ),
          )),
    );
  }
}
