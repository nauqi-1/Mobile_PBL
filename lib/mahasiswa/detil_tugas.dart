import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'daftar_tersedia.dart';
import 'homepage.dart';
import 'notifikasi.dart';
import 'profile.dart';
import 'daftar_terambil.dart';

class MhsDetilTugas extends StatefulWidget {
  const MhsDetilTugas({super.key});

  @override
  State<MhsDetilTugas> createState() => _MhsDetilTugasState();
}

class _MhsDetilTugasState extends State<MhsDetilTugas> {
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

  void _request() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MhsDaftarTersedia(
                            title: 'Sistem Kompensasi')),
                    (Route<dynamic> route) => false);
              },
              child: const AlertDialog(
                  title: Text(
                    'Permintaan sedang diproses!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  content: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_outline_outlined,
                        size: 50,
                        color: Colors.green,
                      )
                    ],
                  )));
        });
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Judul Tugas\nKompensasi',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'InstrumentSans',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              _buildTextField('Dosen', 'Nama lengkap dosen'),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                      child: _buildTextField('No. HP Dosen', '08xxxxxxxxxx')),
                  const SizedBox(width: 10),
                  Expanded(child: _buildTextField('Jenis', 'Jenis tugas')),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _buildTextField('Bobot Jam', 'Bobot jam')),
                  const SizedBox(width: 10),
                  Expanded(child: _buildTextField('Kuota Mahasiswa', 'Kuota')),
                ],
              ),
              const SizedBox(height: 10),
              _buildTextField('Tenggat Waktu', 'Tanggal\nJam', maxLines: 2),
              const SizedBox(height: 10),
              const Text('Bidang Kompetensi', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 5),
              const Wrap(
                spacing: 8.0,
                children: [
                  Chip(
                      label: Text('Tag', style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.black),
                  Chip(
                      label: Text('Tag', style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.black),
                  Chip(
                      label: Text('Tag', style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.black),
                  Chip(
                      label: Text('Tag', style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.black),
                  Chip(
                      label: Text('Tag', style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.black),
                ],
              ),
              const SizedBox(height: 10),
              _buildTextField('Deskripsi', 'Deskripsi tugas kompen',
                  maxLines: 5),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _request,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'Request',
                    style: TextStyle(fontSize: 16, color: Colors.white),
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

  Widget _buildTextField(String label, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 5),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
          readOnly: true, // Membuat textfield hanya baca
        ),
      ],
    );
  }
}
