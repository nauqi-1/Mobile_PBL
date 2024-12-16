import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'buat_tugas.dart';
import 'detil_tugas.dart';
import 'notifikasi.dart';
import '../models/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DsnDaftarTugasPage extends StatefulWidget {
  const DsnDaftarTugasPage({super.key, required this.title});

  final String title;

  @override
  State<DsnDaftarTugasPage> createState() => _DaftarTugasState();
}

class _DaftarTugasState extends State<DsnDaftarTugasPage> {
  List<dynamic> _tasks = [];
  bool isLoading = true; // Menyimpan status loading

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); // Get the saved token

    if (token == null) {
      // Handle case where token is not available
      print("Token not found");
      return;
    }
    final response = await http.get(
      Uri.parse('${apiUrl}tugas/1'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token', // Add token to request headers
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        _tasks = jsonDecode(response.body);
        isLoading = false; // Menyimpan status loading
      });
    } else {
      setState(() {
        isLoading = false;
      });
      // Handle the error
      print('Failed to load tasks');
    }
  }

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
                onPressed: _notifDsn,
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
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true, // Tambahkan ini
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _tasks.length, // Jumlah data dari API
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFE0E0E0), // Warna abu-abu
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              title: Text(_tasks[index]['tugas_nama']),
                              trailing: const Text(
                                'Detail >',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              onTap: () {
                                // Navigasi ke halaman detil tugas dengan mengirim tugas_id
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DsnDetilTugas(
                                      tugasId: _tasks[index]['tugas_id'] ?? 0,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
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
                onPressed: _profileDsn,
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
