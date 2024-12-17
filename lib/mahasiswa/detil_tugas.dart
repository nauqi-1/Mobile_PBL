import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testproject/models/login_response.dart';
import 'homepage.dart';
import 'notifikasi.dart';
import 'profile.dart';
import 'daftar_tersedia.dart';
import 'daftar_terambil.dart';

class MhsDetilTugas extends StatefulWidget {
  final LoginResponse loginResponse;
  final Mahasiswa mahasiswa;
  final int tugasId;

  const MhsDetilTugas({
    super.key,
    required this.loginResponse,
    required this.mahasiswa,
    required this.tugasId,
  });

  @override
  State<MhsDetilTugas> createState() => _MhsDetilTugasState();
}

class _MhsDetilTugasState extends State<MhsDetilTugas> {
  final String baseUrl = "http://192.168.1.10:8000/api/";
  Map<String, dynamic>? tugasDetail;
  bool isLoading = true;

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
          "Content-Type": "application/json",
          "Authorization": "Bearer ${widget.loginResponse.token}",
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          tugasDetail = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load tugas detail');
      }
    } catch (e) {
      print("Error fetching tugas detail: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _submitRequest() async {
    // Data untuk dikirimkan ke API
    final Map<String, dynamic> requestData = {
      'tugas_id': widget.tugasId,
      'mhs_id': widget.mahasiswa.mahasiswaId,
      'tugas_pembuat_id': tugasDetail!['pembuat']['id'],
      'status_request': 'pending',
      'tgl_request': DateTime.now().toIso8601String(),
    };

    try {
      final response = await http.post(
        Uri.parse('${apiUrl}request'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${widget.loginResponse.token}",
        },
        body: json.encode(requestData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MhsDaftarTersedia(
                      loginResponse: widget.loginResponse,
                      mahasiswa: widget.mahasiswa,
                    ),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: const AlertDialog(
                title: Text(
                  'Permintaan Berhasil!',
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
              ),
            );
          },
        );
      } else {
        throw Exception('Gagal mengirim request');
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Gagal!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            content: Text(
              e.toString(),
              textAlign: TextAlign.center,
            ),
          );
        },
      );
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff2d1b6b),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                    fontFamily: 'InstrumentSans',
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'J',
                        style: TextStyle(
                          color: Color.fromARGB(255, 153, 58, 54),
                          fontFamily: 'InstrumentSans',
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'T',
                        style: TextStyle(
                          color: Color.fromARGB(255, 240, 85, 41),
                          fontFamily: 'InstrumentSans',
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'I',
                        style: TextStyle(
                          color: Color.fromARGB(255, 254, 192, 26),
                          fontFamily: 'InstrumentSans',
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' Polinema',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'InstrumentSans',
                          fontSize: 19,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: _navigateToNotification,
              icon:
                  const Icon(Icons.notifications_outlined, color: Colors.white),
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : tugasDetail == null
              ? const Center(child: Text('Failed to load tugas detail'))
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tugasDetail!['tugas']['tugas_nama'] ??
                              'Nama tugas tidak ditemukan',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildTextField(
                            'Dosen',
                            tugasDetail!['pembuat']['nama'] ??
                                'Tidak ada data'),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                  'No. HP Dosen',
                                  tugasDetail!['pembuat']['noHp'] ??
                                      'Tidak ada data'),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _buildTextField(
                                  'Jenis',
                                  tugasDetail!['jenis']['jenis_nama'] ??
                                      'Tidak ada data'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField('Bobot Jam',
                                  '${tugasDetail!['tugas']['tugas_bobot']}'),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _buildTextField('Kuota Mahasiswa',
                                  '${tugasDetail!['tugas']['kuota']}'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          'Tenggat Waktu',
                          tugasDetail!['tugas']['tugas_tgl_deadline'] ??
                              'Tidak ada data',
                        ),
                        const SizedBox(height: 10),
                        const Text('Bidang Kompetensi',
                            style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 5),
                        Wrap(
                          spacing: 8.0,
                          children: List<Widget>.generate(
                            tugasDetail!['kompetensi'].length,
                            (index) => Chip(
                              label: Text(
                                tugasDetail!['kompetensi'][index]
                                    ['kompetensi_nama'],
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          'Deskripsi',
                          tugasDetail!['tugas']['tugas_desc'] ??
                              'Tidak ada data',
                          maxLines: 5,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _submitRequest,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: const Text(
                              'Request',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildTextField(String label, String value, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 5),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: value,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          readOnly: true,
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      color: const Color(0xff2d1b6b),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: _navigateToHome,
            icon:
                const Icon(Icons.home_outlined, color: Colors.white, size: 35),
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
    );
  }
}
