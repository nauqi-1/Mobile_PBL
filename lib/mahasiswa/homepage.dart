import 'package:flutter/material.dart';
import 'daftar_request.dart'; // Mengimpor halaman baru
import 'profile.dart';

class MhsHomepageHutang extends StatefulWidget {
  const MhsHomepageHutang({super.key});

  @override
  // ignore: library_private_types_in_public_api
  State<MhsHomepageHutang> createState() => _MhsHomepageHutangState();
}

class _MhsHomepageHutangState extends State<MhsHomepageHutang> {
  int _selectedIndex =
      0; // Variabel untuk menyimpan index dari item yang dipilih

  // Daftar halaman yang bisa dinavigasi
  final List<Widget> _pages = [
    const MhsHomepageHutang(), //Halaman Homepage
    const MhsDaftarRequest(), // Halaman Daftar Request
    const MhsProfilePage(title: 'Sistem Kompensasi') //Halaman Profil mahasiswa
    //const Placeholder(), // Tambahkan halaman lainnya di sini
  ];

  // Fungsi untuk mengupdate state saat item di bottom navigation dipilih
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Mengubah indeks yang dipilih
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            const Color.fromARGB(255, 45, 27, 107), // Warna AppBar biru tua
        leading: _selectedIndex == 1
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0; // Kembali ke halaman beranda
                  });
                },
              )
            : null, // Tampilkan tombol back hanya di halaman Daftar Request
        title: Stack(
          children: [
            Align(
              alignment: Alignment.center, // Pusatkan teks di tengah
              child: RichText(
                textAlign: TextAlign.center, // Center alignment untuk teks
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: 'InstrumentSans',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Warna teks default
                  ),
                  children: <TextSpan>[
                    TextSpan(text: 'Sistem Kompensasi\n'), // Teks biasa
                    TextSpan(
                        text: 'J',
                        style:
                            TextStyle(color: Color.fromARGB(255, 153, 58, 54))),
                    TextSpan(
                        text: 'T',
                        style:
                            TextStyle(color: Color.fromARGB(255, 240, 85, 41))),
                    TextSpan(
                        text: 'I',
                        style: TextStyle(
                            color: Color.fromARGB(255, 254, 192, 26))),
                    TextSpan(text: ' Polinema'), // Teks biasa
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight, // Tempatkan ikon di kanan
              child: IconButton(
                icon: const Icon(
                  Icons.notifications_outlined, // Ikon lonceng
                  color: Colors.white,
                ),
                onPressed: () {
                  // Aksi jika ikon notifikasi diklik
                },
              ),
            ),
          ],
        ),
        centerTitle: true, // Membuat judul berada di tengah
      ),
      body: _pages[_selectedIndex], // Panggil halaman sesuai index
      bottomNavigationBar: Container(
        height: 50, // Tinggi BottomAppBar
        color: const Color.fromARGB(255, 45, 27, 107),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home, size: 24),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _selectedIndex = 0; // Pindah ke Beranda
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.menu, size: 24),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _selectedIndex = 1; // Pindah ke Daftar Request
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.cases_outlined, size: 24),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _selectedIndex = 2; // Pindah ke Daftar Tugas
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.person, size: 24),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _selectedIndex = 3; // Pindah ke Profil
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membangun tampilan homepage
  Widget _buildHomepage() {
    return SingleChildScrollView(
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
          const Image(
            image: AssetImage('assets/images/logo_polinema.png'),
            height: 150,
            width: 149,
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
              border: Border.all(color: const Color.fromARGB(255, 144, 11, 9)),
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
    );
  }

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
