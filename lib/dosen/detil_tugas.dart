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

  Future<void> _deleteTask(int tugasId) async {
    print('Deleting Tugas with ID: $tugasId');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); // Retrieve token

    if (token == null) {
      print("Token not found");
      return;
    }

    try {
      final response = await http.delete(
        Uri.parse(
            '${apiUrl}tugas/$tugasId'), // Correctly use tugasId in the URL
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print('Task successfully deleted.');
        // Tampilkan dialog "Tugas berhasil dihapus!"
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text(
                'Tugas berhasil dihapus!',
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

        // Optionally refresh the task list or navigate back
        // Navigator.of(context).pop(); // Close dialog or current screen
      } else {
        print('Failed to delete task. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Error deleting task: $e');
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

              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Edit Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DsnEditTugas(taskDetail: _taskDetail!),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      backgroundColor: const Color(0xFF2c2c2c),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Edit',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Delete Button
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Yakin Menghapus Tugas?',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                // Yes Button
                                ElevatedButton(
                                  onPressed: () {
                                    _deleteTask(_taskDetail!['tugas_id']);
                                    Navigator.of(context).pop(); // Close dialog
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'Ya',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                                // No Button
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close dialog
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'Tidak',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      backgroundColor: const Color(0xFF2c2c2c),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.delete_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Hapus',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ],
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
