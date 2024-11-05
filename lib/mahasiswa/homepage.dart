import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testproject/mahasiswa/notifikasi.dart';
import 'daftar_tersedia.dart'; // Mengimpor halaman baru
import 'profile.dart';
import 'daftar_terambil.dart';

class MhsHomepageHutang extends StatefulWidget {
  const MhsHomepageHutang({super.key});

  @override
  // ignore: library_private_types_in_public_api
  State<MhsHomepageHutang> createState() => _MhsHomepageHutangState();
}

class _MhsHomepageHutangState extends State<MhsHomepageHutang> {
  void _indexMhs() {
    print('Homepage Mahasiswa');
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const MhsHomepageHutang()));
  }

  void _notifMhs() {
    print('Notifikasi Mahasiswa');
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const MhsNotification()));
  }

  void _profileMhs() {
    print('Profile Mahasiswa');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const MhsProfilePage(title: 'Sistem Kompensasi')));
  }

  void _tugasTersedia() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const MhsDaftarTersedia(
                  title: 'Sistem Kompensasi',
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
            const SizedBox(width: 48),
            /*IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),*/
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 5),
            const Text(
              'Selamat datang,',
              style: TextStyle(
                fontFamily: 'InstrumentSans',
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'NAMA MAHASISWA',
              style: TextStyle(
                fontFamily: 'InstrumentSans',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/images/logo-polinema.png',
              height: 150,
            ),
            const SizedBox(height: 20),
            _buildTextField('Total Absensi Alfa', 'Total jam'),
            const SizedBox(height: 5),
            _buildTextField('Jumlah Absensi Alfa Lunas', 'Jumlah jam'),
            const SizedBox(height: 5),
            _buildTextField('Jumlah Absensi Alfa Belum Lunas', 'Jumlah jam'),
            const SizedBox(height: 5),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Status Ujian Akhir Semester (UAS)',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.red,
                border:
                    Border.all(color: const Color.fromARGB(255, 144, 11, 9)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Belum bisa mengikuti!',
                style: TextStyle(
                  color: Color.fromARGB(255, 144, 11, 9),
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.left,
              ),
            ),
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

  // Fungsi untuk membangun tampilan homepage

  // Fungsi untuk membuat TextField dengan label dan hint
  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label, // Label yang muncul di atas kotak input
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 5),
        TextField(
          decoration: InputDecoration(
            hintText: hint, // Teks yang muncul di dalam kotak
            hintStyle: const TextStyle(
              color: Colors
                  .grey, // Warna teks abu-abu pada "Total jam" dan "Jumlah jam"
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8), // Sudut kotak melengkung
              borderSide: BorderSide(
                color: Colors.grey
                    .withOpacity(0.1), // Warna border dengan opacity 50%
                width: 1, // Lebar garis border
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
          readOnly: true, // Membuat input hanya untuk dibaca, tidak bisa diubah
        ),
      ],
    );
  }
}
