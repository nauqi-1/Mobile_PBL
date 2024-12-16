import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'daftar_tugas.dart';
import 'homepage.dart';
import 'package:http/http.dart' as http;
import 'notifikasi.dart';
import 'profile.dart';
import '../models/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DsnDetilTugas extends StatefulWidget {
  final int tugasId; // Tugas ID yang dikirim dari daftar_tugas.dart
  const DsnDetilTugas({super.key, required this.tugasId});

  @override
  State<DsnDetilTugas> createState() => _DsnDetilTugasState();
}

class _DsnDetilTugasState extends State<DsnDetilTugas> {
  Map<String, dynamic>? _taskDetail;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); // Ambil token

    if (token == null) {
      print("Token not found");
      return;
    }

    final response = await http.get(
      Uri.parse('${apiUrl}tugas/${widget.tugasId}'), // Menggunakan tugasId
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        // Parsing detail tugas dari response
        _taskDetail = jsonDecode(response.body);
        isLoading = false;
        print('Task Detail: $_taskDetail');
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print('Failed to load task details');
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
                onPressed: () {},
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
              // Nama Tugas
              _taskDetail != null
                  ? Text(
                      _taskDetail!['tugas_nama'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontFamily: 'InstrumentSans',
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const SizedBox(height: 15),

              // No. HP dan Jenis
              Row(
                children: [
                  Expanded(
                      child: _buildTextField('Tanggal dibuat',
                          _taskDetail!['tugas_tgl_dibuat'] ?? '-')),
                  const SizedBox(width: 10),
                  Expanded(
                      child: _buildTextField('Jenis',
                          _taskDetail!['jenis']?['jenis_nama'] ?? '-')),
                ],
              ),
              const SizedBox(height: 10),

              // Bobot Jam dan Kuota
              Row(
                children: [
                  Expanded(
                      child: _buildTextField(
                          'Bobot Jam', _taskDetail!['tugas_bobot'].toString())),
                  const SizedBox(width: 10),
                  Expanded(
                      child: _buildTextField(
                          'Kuota Mahasiswa', _taskDetail!['kuota'].toString())),
                ],
              ),
              const SizedBox(height: 10),

              // Tenggat Waktu
              _buildTextField(
                  'Tenggat Waktu', _taskDetail!['tugas_tgl_deadline']),
              const SizedBox(height: 10),

              // Bidang Kompetensi
              const Text('Bidang Kompetensi', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 5),
              Wrap(
                spacing: 8.0,
                children: (_taskDetail!['kompetensi'] as List<dynamic>? ?? [])
                    .map((tag) => Chip(
                          label: Text(tag['kompetensi_nama'],
                              style: const TextStyle(color: Colors.white)),
                          backgroundColor: Colors.black,
                        ))
                    .toList(),
              ),
              const SizedBox(height: 10),
              // Deskripsi
              _buildTextField('Deskripsi', _taskDetail!['tugas_desc'],
                  maxLines: 5),
              const SizedBox(height: 20),
              // File Penunjang Tugas
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'File Penunjang Tugas',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  _taskDetail!['tugas_file'] != null &&
                          _taskDetail!['tugas_file'].isNotEmpty
                      ? Row(
                          children: [
                            Icon(Icons.attach_file, color: Colors.black),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                _taskDetail!['tugas_file'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.download,
                                  color: Colors.black),
                              onPressed: () {
                                // Implement file download functionality here
                                print('Download ${_taskDetail!['tugas_file']}');
                              },
                            ),
                          ],
                        )
                      : const Text(
                          'Tidak ada file penunjang.',
                          style: TextStyle(
                              fontSize: 14, fontStyle: FontStyle.italic),
                        ),
                ],
              ),
              const SizedBox(height: 20),

              // Tombol Request
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
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
