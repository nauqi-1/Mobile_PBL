import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'daftar_tugas.dart';
import 'edit_tugas.dart';
import 'homepage.dart';
import 'package:http/http.dart' as http;
import 'notifikasi.dart';
import 'profile.dart';
import '../models/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailRequestPage extends StatefulWidget {
  final int requestId; // Tugas ID yang dikirim dari daftar_tugas.dart
  const DetailRequestPage({super.key, required this.requestId});

  @override
  State<DetailRequestPage> createState() => _DetailRequestPageState();
}

class _DetailRequestPageState extends State<DetailRequestPage> {
  Map<String, dynamic>? __reqDetail;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _fetchReq();
  }

  Future<void> _fetchReq() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); // Ambil token

    if (token == null) {
      print("Token not found");
      return;
    }

    final response = await http.get(
      Uri.parse('${apiUrl}request/${widget.requestId}'), // Menggunakan tugasId
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        // Parsing detail tugas dari response
        __reqDetail = jsonDecode(response.body);
        isLoading = false;
        print('req Detail: $__reqDetail');
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print('Failed requestId: ${widget.requestId}');
      print('Failed to load task details');
    }
  }

  Future<void> confirmAccept(int idRequest) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); // Retrieve token

    if (token == null) {
      print("Token not found");
      return;
    }

    // URL untuk API confirm_accept dengan query string id_request
    final requestUrl = '${apiUrl}request/accept_ajax/?id_request=$idRequest';

    print("Request URL: $requestUrl"); // Debug URL

    try {
      final response = await http.put(
        Uri.parse(requestUrl),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Jika berhasil
        print('Request berhasil dikonfirmasi.');

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text(
                'Request Berhasil Dikonfirmasi!',
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
                  ),
                ],
              ),
            );
          },
        );
      } else {
        // Jika gagal
        print("Response Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text(
                'Kuota untuk tugas ini sudah penuh!',
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
                  ),
                ],
              ),
            );
          },
        );
      }
    } catch (e) {
      // Tangani error jika terjadi masalah saat HTTP request
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }

  Future<void> confirmDenied(int idRequest) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); // Retrieve token

    if (token == null) {
      print("Token not found");
      return;
    }

    // URL untuk API confirm_accept dengan query string id_request
    final requestUrl = '${apiUrl}request/denied_ajax/?id_request=$idRequest';

    print("Request URL: $requestUrl"); // Debug URL

    try {
      final response = await http.put(
        Uri.parse(requestUrl),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Jika berhasil
        print('Request berhasil ditolak.');

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text(
                'Request Berhasil ditolak!',
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
                  ),
                ],
              ),
            );
          },
        );
      } else {
        // Jika gagal
        print("Response Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");
      }
    } catch (e) {
      // Tangani error jika terjadi masalah saat HTTP request
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
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
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                ))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            __reqDetail != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Kolom Tugas Nama
                      Text(
                        __reqDetail!['tugas']?['tugas_nama'] ?? '-',
                        style: const TextStyle(
                          fontSize: 24,
                          fontFamily: 'InstrumentSans',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Kolom Nama Mahasiswa
                      const Text(
                        'Nama Mahasiswa',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        __reqDetail!['mahasiswa']?['mahasiswa_nama'] ?? '-',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),

                      // Kolom NIM
                      const Text(
                        'NIM',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        __reqDetail!['mahasiswa']?['mahasiswa_nim'] ?? '-',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),

                      // Kolom Program Studi
                      const Text(
                        'Program Studi',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        __reqDetail!['mahasiswa']?['mahasiswa_prodi'] ?? '-',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),

                      // Kolom Kelas
                      const Text(
                        'Kelas',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        __reqDetail!['mahasiswa']?['mahasiswa_kelas'] ?? '-',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),

                      // Kolom No. HP
                      const Text(
                        'No. HP',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        __reqDetail!['mahasiswa']?['mahasiswa_no_hp'] ?? '-',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    confirmAccept(__reqDetail!['id_request']);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    fixedSize: const Size(130, 40),
                  ),
                  child: const Text('Terima'),
                ),
                ElevatedButton(
                  onPressed: () {
                    confirmDenied(__reqDetail!['id_request']);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    fixedSize: const Size(130, 40),
                  ),
                  child: const Text('Tolak'),
                ),
              ],
            )
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
                    onPressed: () {},
                    icon: const Icon(
                      Icons.home_outlined,
                      color: Colors.white,
                      size: 35,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.list_sharp,
                      color: Colors.white,
                      size: 30,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.briefcase,
                      color: Colors.white,
                      size: 30,
                    )),
                IconButton(
                    onPressed: () {},
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
