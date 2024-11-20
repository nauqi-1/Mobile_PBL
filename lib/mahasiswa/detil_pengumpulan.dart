import 'package:file_picker/file_picker.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'daftar_tersedia.dart';
import 'homepage.dart';
import 'notifikasi.dart';
import 'profile.dart';
import 'daftar_terambil.dart';

class MhsDetilPengumpulan extends StatefulWidget {
  const MhsDetilPengumpulan({super.key});

  @override
  State<MhsDetilPengumpulan> createState() => _MhsDetilPengumpulanState();
}

class _MhsDetilPengumpulanState extends State<MhsDetilPengumpulan> {
  String? _selectedFileName; // Menyimpan nama file yang dipilih
  final TextEditingController _progressController =
      TextEditingController(); // Controller untuk progress
  bool isSubmitEnabled = false; // Status tombol submit

  // Fungsi untuk memilih file
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _selectedFileName =
            result.files.single.name; // Menyimpan nama file yang dipilih
        isSubmitEnabled =
            true; // Mengaktifkan tombol submit setelah file dipilih
      });
    }
  }

  // Fungsi untuk menyimpan progress secara otomatis
  void _saveProgress(String value) {
    // Di sini Anda bisa menyimpan nilai progress ke server atau database lokal
    print("Progress disimpan: $value"); // Simulasi penyimpanan progress
  }

  void _indexMhs() {
    print("homepage");
    //  Navigator.push(context,
    //      MaterialPageRoute(builder: (context) => const MhsHomepageHutang()));
  }

  void _notifMhs() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const MhsNotification()));
  }

  void _profileMhs() {
    //Navigator.push(
    //    context,
    //    MaterialPageRoute(
    //        builder: (context) =>
    //            const MhsProfilePage(title: 'Sistem Kompensasi')));
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

  void _submit() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MhsDaftarTerambil(
                            title: 'Sistem Kompensasi')),
                    (Route<dynamic> route) => false);
              },
              child: const AlertDialog(
                  title: Text(
                    'Tugas berhasil dikumpulkan!',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildTextField('Bobot Jam', 'Bobot jam')),
                  const SizedBox(width: 10),
                  Expanded(child: _buildTextField('Kuota Mahasiswa', 'Kuota')),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      const Text(
                        'Unduh File',
                        style: TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        icon: const Icon(Icons.file_download_outlined,
                            color: Colors.black),
                        onPressed: () {
                          // Aksi untuk mengunduh file
                        },
                      ),
                    ],
                  ),
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
              const SizedBox(height: 10),
              // Field Progress yang dapat diisi pengguna
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Progress', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _progressController,
                    maxLines: 2,
                    onChanged: _saveProgress, // Menyimpan progress otomatis
                    decoration: InputDecoration(
                      hintText:
                          'Penjelasan singkat progress yang telah dikerjakan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Pengumpulan', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed:
                              _pickFile, // Memanggil fungsi untuk memilih file
                          icon: const Icon(Icons.upload_file,
                              color: Colors.black),
                        ),
                        const Text(
                          'Upload file',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        if (_selectedFileName !=
                            null) // Menampilkan nama file jika ada
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              _selectedFileName!,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black87),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isSubmitEnabled
                      ? _submit
                      : null, // Mengaktifkan tombol submit hanya jika ada file
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isSubmitEnabled ? Colors.blue : Colors.grey,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Submit',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(width: 8), // Spasi antara teks dan ikon
                      Icon(Icons.send, color: Colors.white), // Ikon kirim
                    ],
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
