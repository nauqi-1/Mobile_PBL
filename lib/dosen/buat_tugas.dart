import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BuatTugasPage extends StatefulWidget {
  const BuatTugasPage({super.key, required this.title});

  final String title;

  @override
  State<BuatTugasPage> createState() => _BuatTugasPageState();
}

class _BuatTugasPageState extends State<BuatTugasPage> {
  final TextEditingController _judulTugasController = TextEditingController();
  final TextEditingController _bobotJamController = TextEditingController();
  final TextEditingController _kuotaMhsController = TextEditingController();
  final TextEditingController _tenggatController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  String url_create_data = "http://192.168.56.1:8000/api/tugas/";

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  bool _isFormValid = false;

  void _checkFormValid() {
    setState(() {
      _isFormValid = _judulTugasController.text.isNotEmpty &&
          _bobotJamController.text.isNotEmpty &&
          _kuotaMhsController.text.isNotEmpty &&
          _tenggatController.text.isNotEmpty &&
          _deskripsiController.text.isNotEmpty;
    });
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _updateTenggat();
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
        _updateTenggat();
      });
    }
  }

  void _updateTenggat() {
    if (_selectedDate != null && _selectedTime != null) {
      final String formattedDate =
          "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}";
      final String formattedTime =
          "${_selectedTime!.hour}:${_selectedTime!.minute.toString().padLeft(2, '0')}";
      _tenggatController.text = "$formattedDate $formattedTime";
    }
  }

  Future<void> _showSuccessPopup() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const SizedBox(
            width: 300,
            height: 100,
            child: Column(
              children: [
                SizedBox(height: 10),
                Text("Tugas berhasil dibuat"),
                Icon(Icons.check_circle, color: Colors.green, size: 40),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
              },
            ),
          ],
        );
      },
    );
  }

  // Future<void> _submitData() async {
  //   // Mengumpulkan data dari controller
  //   final data = {
  //     "judul": _judulTugasController.text,
  //     "bobot_jam": _bobotJamController.text,
  //     "kuota_mahasiswa": _kuotaMhsController.text,
  //     "tenggat_waktu": _tenggatController.text,
  //     "deskripsi": _deskripsiController.text,
  //   };

  //   try {
  //     final response = await http.post(
  //       Uri.parse(url_create_data),
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode(data),
  //     );

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       await _showSuccessPopup();
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("Gagal membuat tugas, coba lagi!")),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Error: $e")),
  //     );
  //   }
  // }
  void createData(String tugasNama, String bobotJam, String kuotaMahasiswa,
      String tenggatWaktu, String deskripsi) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token =
        prefs.getString('token'); // Ambil token dari SharedPreferences

    // Ambil tanggal saat ini
    final DateTime now = DateTime.now();
    final String formattedDate =
        DateFormat('yyyy-MM-dd').format(now); // format ke "YYYY-MM-DD"

    try {
      final response = await http.post(
        Uri.parse(url_create_data),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // Tambahkan token ke header
        },
        body: jsonEncode({
          'tugas_nama': tugasNama,
          'tugas_bobot': bobotJam,
          // 'kuota_mahasiswa': kuotaMahasiswa,
          'tugas_tgl_dibuat': formattedDate,
          'tugas_tgl_deadline': tenggatWaktu,
          'tugas_desc': deskripsi,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Tampilkan popup sukses dan kosongkan field
        _judulTugasController.clear();
        _bobotJamController.clear();
        _kuotaMhsController.clear();
        _tenggatController.clear();
        _deskripsiController.clear();
        _showSuccessPopup();
      } else {
        // Jika gagal
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gagal membuat tugas, coba lagi!")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  // Fungsi untuk memanggil createData dengan data dari controller
  void _submitData() {
    createData(
      _judulTugasController.text,
      _bobotJamController.text,
      _kuotaMhsController.text,
      _tenggatController.text,
      _deskripsiController.text,
    );
  }

  @override
  void initState() {
    super.initState();
    _judulTugasController.addListener(_checkFormValid);
    _bobotJamController.addListener(_checkFormValid);
    _kuotaMhsController.addListener(_checkFormValid);
    _tenggatController.addListener(_checkFormValid);
    _deskripsiController.addListener(_checkFormValid);
  }

  @override
  void dispose() {
    _judulTugasController.dispose();
    _bobotJamController.dispose();
    _kuotaMhsController.dispose();
    _tenggatController.dispose();
    _deskripsiController.dispose();
    super.dispose();
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
            Text(
              widget.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'InstrumentSans'),
            ),
            IconButton(
              onPressed: () {},
              icon:
                  const Icon(Icons.notifications_outlined, color: Colors.white),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Judul Tugas Kompensasi"),
            const SizedBox(height: 10),
            TextField(
              controller: _judulTugasController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Bobot Jam"),
                Text("Kuota Mahasiswa"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 130,
                  child: TextField(
                    controller: _bobotJamController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
                SizedBox(
                  width: 130,
                  child: TextField(
                    controller: _kuotaMhsController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text("Tenggat Waktu"),
            const SizedBox(height: 10),
            TextField(
              controller: _tenggatController,
              readOnly: true,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: _selectDate,
                    ),
                    IconButton(
                      icon: const Icon(Icons.access_time),
                      onPressed: _selectTime,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Deskripsi"),
            const SizedBox(height: 10),
            TextField(
              controller: _deskripsiController,
              maxLines: 8,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: _isFormValid ? _submitData : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  minimumSize: const Size(272, 40),
                  backgroundColor: _isFormValid ? Colors.green : Colors.grey,
                ),
                child: const Text("Buat Tugas +"),
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.home, color: Colors.white)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.list, color: Colors.white)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.work, color: Colors.white)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.person, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
