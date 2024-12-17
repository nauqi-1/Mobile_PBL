
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testproject/models/login_response.dart';
import 'daftar_tersedia.dart';
import 'homepage.dart';
import 'notifikasi.dart';
import 'profile.dart';
import 'detil_pengumpulan.dart';

class MhsDaftarTerambil extends StatefulWidget {
  final LoginResponse loginResponse;
  final Mahasiswa mahasiswa;
  const MhsDaftarTerambil(
      {super.key, required this.loginResponse, required this.mahasiswa});

  @override
  State<MhsDaftarTerambil> createState() => _MhsDaftarTerambilState();
}

class _MhsDaftarTerambilState extends State<MhsDaftarTerambil> {
  List tugasTerambilList = []; // Menyimpan daftar tugas terambil dari API
  bool isLoading = true; // Menyimpan status loading
 

  // Fungsi untuk mengambil data tugas terambil dari API
  Future<void> fetchTugasTerambil() async {
    try {
      final response = await http.get(
        Uri.parse('${apiUrl}tugas-mahasiswa/${widget.mahasiswa.mahasiswa_id}'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${widget.loginResponse.token}",
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          tugasTerambilList = json.decode(response.body); // Parsing JSON
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load tugas terambil');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTugasTerambil(); // Memanggil fungsi untuk mengambil data saat halaman dimuat
  }

  void _indexMhs() {
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
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MhsNotification(
                  loginResponse: widget.loginResponse,
                  mahasiswa: widget.mahasiswa,
                )));
  }

  void _profileMhs() {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              'DAFTAR TUGAS\nKOMPENSASI TERAMBIL',
              style: TextStyle(
                fontFamily: 'InstrumentSans',
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: tugasTerambilList.length, // Jumlah data dari API
                      itemBuilder: (context, index) {
                        final tugas = tugasTerambilList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFE0E0E0), // Warna abu-abu
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              title: Text(tugas['tugas']['tugas_nama']),
                              subtitle: Text("Status: ${tugas['status']}"),
                              trailing: const Text(
                                'Detail >',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              onTap: () {
                                // Navigasi ke halaman detil pengumpulan
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MhsDetilPengumpulan(
                                      tugasId: tugas['tugas_id'],
                                      loginResponse: widget.loginResponse,
                                      mahasiswa: widget.mahasiswa,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
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
}