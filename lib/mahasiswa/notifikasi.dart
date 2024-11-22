import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testproject/models/login_response.dart';
import 'daftar_tersedia.dart'; // Mengimpor halaman baru
import 'profile.dart';
import 'homepage.dart';
import 'daftar_terambil.dart';

class MhsNotification extends StatefulWidget {
  final LoginResponse loginResponse;
  final Mahasiswa mahasiswa;
  const MhsNotification(
      {super.key, required this.loginResponse, required this.mahasiswa});
  @override
  State<MhsNotification> createState() => _MhsNotificationState();
}

class _MhsNotificationState extends State<MhsNotification> {
  final List<String> notifications = [
    "Hasil tugas diterima!",
    "Hasil tugas ditolak!",
    "Selesaikan tugas!",
    "Request diterima!",
    "Request ditolak!",
    "Notifikasi",
    "Notifikasi",
    "Notifikasi",
    "Notifikasi",
    "Notifikasi",
    "Notifikasi",
  ];
  void _indexMhs() {
    print('Homepage Mahasiswa');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MhsHomepageHutang(
          loginResponse: widget.loginResponse,
          mahasiswa: widget.mahasiswa,
        ),
      ),
    );
  }

  void _notifMhs() {
    print('Notifikasi Mahasiswa');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MhsNotification(
                  loginResponse: widget.loginResponse,
                  mahasiswa: widget.mahasiswa,
                )));
  }

  void _profileMhs() {
    print('Profile Mahasiswa');
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MhsProfilePage(
                loginResponse: widget.loginResponse,
                mahasiswa: widget.mahasiswa,
              )),
    );
  }

  void _tugasTersedia() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MhsDaftarTersedia(
                loginResponse: widget.loginResponse,
                mahasiswa: widget.mahasiswa,
              )),
    );
  }

  void _tugasTerambil() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MhsDaftarTerambil(
                loginResponse: widget.loginResponse,
                mahasiswa: widget.mahasiswa,
              )),
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
                onPressed: _notifMhs,
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                ))
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notifications[index]),
            trailing: ElevatedButton(
              child: const Text("Detail"),
              onPressed: () {
                // Implement detail functionality here
              },
            ),
          );
        },
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
