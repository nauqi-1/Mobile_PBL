import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  String url_create_data = "http://192.168.1.10:8000/api/tugas/";

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedJenisTugas;
  final int _pembuatId = 2; // User ID langsung diisi dengan nilai 2

  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _judulTugasController.addListener(_checkFormValid);
    _bobotJamController.addListener(_checkFormValid);
    _kuotaMhsController.addListener(_checkFormValid);
    _tenggatController.addListener(_checkFormValid);
    _deskripsiController.addListener(_checkFormValid);
  }

  void _checkFormValid() {
    setState(() {
      _isFormValid = _judulTugasController.text.isNotEmpty &&
          _bobotJamController.text.isNotEmpty &&
          _kuotaMhsController.text.isNotEmpty &&
          _tenggatController.text.isNotEmpty &&
          _deskripsiController.text.isNotEmpty &&
          _selectedJenisTugas != null;
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
          DateFormat('yyyy-MM-dd').format(_selectedDate!);
      final String formattedTime = _selectedTime!.format(context);
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Tugas berhasil dibuat"),
                SizedBox(height: 10),
                Icon(Icons.check_circle, color: Colors.green, size: 40),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> createData(
    String tugasNama,
    String bobotJam,
    String kuotaMahasiswa,
    String tenggatWaktu,
    String deskripsi,
    String jenisTugas,
  ) async {
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    try {
      final response = await http.post(
        Uri.parse(url_create_data),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          'tugas_nama': tugasNama,
          'tugas_bobot': bobotJam,
          'tugas_kuota': kuotaMahasiswa,
          'tugas_tgl_dibuat': formattedDate,
          'tugas_tgl_deadline': tenggatWaktu,
          'tugas_desc': deskripsi,
          'tugas_jenis': jenisTugas,
          'pembuat_id': _pembuatId, // User ID langsung diisi
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _judulTugasController.clear();
        _bobotJamController.clear();
        _kuotaMhsController.clear();
        _tenggatController.clear();
        _deskripsiController.clear();
        _showSuccessPopup();
      } else {
        final errorData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Gagal membuat tugas: ${errorData['message']}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  void _submitData() {
    createData(
      _judulTugasController.text,
      _bobotJamController.text,
      _kuotaMhsController.text,
      _tenggatController.text,
      _deskripsiController.text,
      _selectedJenisTugas ?? '',
    );
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
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _judulTugasController,
              decoration: const InputDecoration(
                labelText: 'Judul Tugas Kompensasi',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _bobotJamController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Bobot Jam',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _kuotaMhsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Kuota Mahasiswa',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _tenggatController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Tenggat Waktu',
                suffixIcon: IntrinsicWidth(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.date_range),
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
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _deskripsiController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Deskripsi Tugas',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value:
                  _selectedJenisTugas, // Nilai yang dipilih, pastikan ini terikat dengan state
              hint: Text('Pilih Jenis Tugas'), // Tambahkan hint jika nilai null
              onChanged: (String? value) {
                setState(() {
                  _selectedJenisTugas = value;
                  _checkFormValid(); // Memastikan validasi form diperbarui
                });
              },
              items: const [
                DropdownMenuItem(
                    value: "pengabdian", child: Text("Pengabdian")),
                DropdownMenuItem(value: "teknis", child: Text("Teknis")),
                DropdownMenuItem(
                    value: "penelitian", child: Text("Penelitian")),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isFormValid ? _submitData : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isFormValid ? Colors.green : Colors.grey,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Buat Tugas +'),
            ),
          ],
        ),
      ),
    );
  }
}
