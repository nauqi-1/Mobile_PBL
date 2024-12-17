import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testproject/models/login_response.dart';
import 'package:url_launcher/url_launcher.dart';
import 'homepage.dart';
import 'notifikasi.dart';
import 'profile.dart';
import 'daftar_tersedia.dart';
import 'daftar_terambil.dart';

class MhsDetilPengumpulan extends StatefulWidget {
  final int tugasId;
  final LoginResponse loginResponse;
  final Mahasiswa mahasiswa;

  const MhsDetilPengumpulan({
    super.key,
    required this.tugasId,
    required this.loginResponse,
    required this.mahasiswa,
  });

  @override
  State<MhsDetilPengumpulan> createState() => _MhsDetilPengumpulanState();
}

class _MhsDetilPengumpulanState extends State<MhsDetilPengumpulan> {
  Map<String, dynamic> tugasDetail = {};
  bool isLoading = true;
  String? _selectedFileName;
  final TextEditingController _progressController = TextEditingController();
  bool isUpdateEnabled = false;
  bool isSubmitEnabled = false;

  

  @override
  void initState() {
    super.initState();
    _fetchTugasDetail();
  }

  Future<void> _fetchTugasDetail() async {
    try {
      final response = await http.get(
        Uri.parse('${apiUrl}tugas/${widget.tugasId}'),
        headers: {
          'Authorization': 'Bearer ${widget.loginResponse.token}',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          tugasDetail = json.decode(response.body);
          _progressController.text = tugasDetail['tugas_progress'] ?? '';
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch tugas detail');
      }
    } catch (e) {
      print('Error fetching tugas detail: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _downloadFile() async {
    final fileUrl = tugasDetail['tugas_file'] ?? '';
    if (fileUrl.isNotEmpty) {
      final uri = Uri.parse(fileUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        print('Could not launch $fileUrl');
      }
    } else {
      print('No file URL available for download.');
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _selectedFileName = result.files.single.name;
        isSubmitEnabled = true; // Enable submit button after file selection
      });
    }
  }

  void _saveProgress(String value) {
    setState(() {
      isUpdateEnabled = value.isNotEmpty;
    });
  }

  void _updateProgress() async {
    if (_progressController.text.isEmpty) {
      return;
    }

    try {
      final response = await http.put(
        Uri.parse('${apiUrl}tugas/${widget.tugasId}/update-progress'),
        headers: {
          'Authorization': 'Bearer ${widget.loginResponse.token}',
          'Content-Type': 'application/json',
        },
        body: json.encode({'tugas_progress': _progressController.text}),
      );

      if (response.statusCode == 200) {
        _showDialog('Progress berhasil diperbarui!');
      } else {
        throw Exception('Gagal memperbarui progress');
      }
    } catch (e) {
      print('Error updating progress: $e');
      _showDialog('Terjadi kesalahan. Silakan coba lagi.');
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: const Icon(
            Icons.check_circle_outline,
            color: Colors.green,
            size: 50,
          ),
        );
      },
    );
  }

  void _navigateToHome() {
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

  void _navigateToNotification() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MhsNotification(
          loginResponse: widget.loginResponse,
          mahasiswa: widget.mahasiswa,
        ),
      ),
    );
  }

  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MhsProfilePage(
          loginResponse: widget.loginResponse,
          mahasiswa: widget.mahasiswa,
        ),
      ),
    );
  }

  void _navigateToTersedia() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MhsDaftarTersedia(
          loginResponse: widget.loginResponse,
          mahasiswa: widget.mahasiswa,
        ),
      ),
    );
  }

  void _navigateToTerambil() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MhsDaftarTerambil(
          loginResponse: widget.loginResponse,
          mahasiswa: widget.mahasiswa,
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String value, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 5),
        TextField(
          controller: TextEditingController(text: value),
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
          readOnly: true,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff2d1b6b),
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
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: 'I',
                        style: TextStyle(
                            color: Color.fromARGB(255, 254, 192, 26),
                            fontFamily: 'InstrumentSans',
                            fontSize: 19,
                            fontWeight: FontWeight.bold)),
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
                onPressed: _navigateToNotification,
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                )),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tugasDetail['tugas_nama'] ?? 'Judul Tugas',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildTextField('Dosen', tugasDetail['dosen_nama'] ?? ''),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                            child: _buildTextField('No. HP Dosen',
                                tugasDetail['dosen_noHp'] ?? '')),
                        const SizedBox(width: 10),
                        Expanded(
                            child: _buildTextField(
                                'Jenis', tugasDetail['jenis_nama'] ?? '')),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                            child: _buildTextField('Bobot Jam',
                                '${tugasDetail['tugas_bobot'] ?? ''} Jam')),
                        const SizedBox(width: 10),
                        Expanded(
                            child: _buildTextField('Kuota Mahasiswa',
                                '${tugasDetail['kuota'] ?? ''}')),
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            const Text(
                              'Unduh File',
                              style: TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: const Icon(Icons.file_download_outlined),
                              onPressed: _downloadFile,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                        'Tenggat Waktu', tugasDetail['tugas_deadline'] ?? ''),
                    const SizedBox(height: 10),
                    _buildTextField(
                        'Deskripsi', tugasDetail['tugas_desc'] ?? '',
                        maxLines: 3),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Progress', style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 5),
                        TextField(
                          controller: _progressController,
                          maxLines: 3,
                          onChanged: _saveProgress,
                          decoration: InputDecoration(
                            hintText: 'Masukkan progress Anda',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: isUpdateEnabled ? _updateProgress : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Update',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(width: 5),
                                Icon(Icons.refresh),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: isSubmitEnabled ? () {} : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Submit',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(width: 5),
                                Icon(Icons.send),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Container(
        color: const Color(0xff2d1b6b),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: _navigateToHome,
              icon: const Icon(Icons.home_outlined,
                  color: Colors.white, size: 35),
            ),
            IconButton(
              onPressed: _navigateToTersedia,
              icon: const Icon(Icons.list_sharp, color: Colors.white, size: 30),
            ),
            IconButton(
              onPressed: _navigateToTerambil,
              icon: const Icon(CupertinoIcons.briefcase,
                  color: Colors.white, size: 30),
            ),
            IconButton(
              onPressed: _navigateToProfile,
              icon: const Icon(Icons.account_circle_outlined,
                  color: Colors.white, size: 35),
            ),
          ],
        ),
      ),
    );
  }
}
