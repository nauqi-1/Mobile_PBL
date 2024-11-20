import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../change_password.dart';
import 'edit_profile.dart';
import 'daftar_tugas.dart';
import 'package:testproject/login.dart';
import 'homepage.dart';
import '../models/login_response.dart';

class DsnProfilePage extends StatefulWidget {
  final Dosen dosen;
  final LoginResponse loginResponse;
  const DsnProfilePage(
      {super.key, required this.dosen, required this.loginResponse});

  @override
  State<DsnProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<DsnProfilePage> {
  String nama = "Pak Hasan";
  String nip = "19208080";
  String prodi = "Sistem Informasi Bisnis";
  String noHp = "08xxxxxx";

  void _indexDsn() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DsnHomepage(
                  dosen: widget.dosen,
                  loginResponse: widget.loginResponse,
                )));
  }

  void _notifDsn() {
    print('Notifikasi Dosen');
  }

  void _profileDsn() {
    print('Profile Dosen');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DsnProfilePage(
                  dosen: widget.dosen,
                  loginResponse: widget.loginResponse,
                )));
  }

  void _editProfile() {
    print('Edit Profile');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditProfilePage(
                  dosen: widget.dosen,
                  loginResponse: widget.loginResponse,
                )));
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

  void _logOut() {
    print('Log Out');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const LoginPage(
                  title: 'Sistem Kompensasi',
                )));
  }

  void _indexMhs() {
    print('Index Mahasiswa');
  }

  void _notifMhs() {
    print('Notifikasi Mahasiswa');
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
                  widget.dosen.dosenNama,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'NIP / NIDN',
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
                  widget.dosen.dosenNip,
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
                  widget.dosen.dosenProdi,
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
                  widget.dosen.dosenNoHp,
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
                          builder: (context) => const ChangePasswordPage()),
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
