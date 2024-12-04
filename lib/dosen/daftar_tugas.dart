import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'buat_tugas.dart';
import 'notifikasi.dart';

class DsnDaftarTugasPage extends StatefulWidget {
  const DsnDaftarTugasPage({super.key, required this.title});

  final String title;

  @override
  State<DsnDaftarTugasPage> createState() => _DaftarTugasState();
}

class _DaftarTugasState extends State<DsnDaftarTugasPage> {
  void _buatTugas() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BuatTugasPage(
          title: 'Sistem Kompensasi',
        ),
      ),
    );
  }

  void _profileDsn() {
    print('Profile Dosen');
    //Navigator.push(
    //    context,
    //    MaterialPageRoute(
    //        builder: (context) =>
    //            const DsnProfilePage(title: 'Sistem Kompensasi')));
  }

  void _detailTugas() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BuatTugasPage(
          title: 'Sistem Kompensasi',
        ),
      ),
    );
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
                onPressed: _notifDsn, // Action for notifications
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                ))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'DAFTAR TUGAS KOMPENSASI',
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'InstrumentSans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _buatTugas,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    fixedSize: const Size(272, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Buat Tugas Baru +',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              for (int i = 0; i < 8; i++)
                GestureDetector(
                  onTap: _detailTugas,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    width: double.infinity,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Judul Tugas',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        Text(
                          'Detail >',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                )
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
            children: [
              IconButton(
                onPressed: () {}, // Replace with actual action
                icon: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                onPressed: () {}, // Replace with actual action
                icon: const Icon(
                  Icons.list_sharp,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {}, // Replace with actual action
                icon: const Icon(
                  CupertinoIcons.briefcase,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: _profileDsn, // Replace with actual action
                icon: const Icon(
                  Icons.account_circle_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
