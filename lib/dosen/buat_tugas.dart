import 'package:flutter/cupertino.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'daftar_tugas.dart';
import 'homepage.dart';
import 'package:http/http.dart' as http;
import 'notifikasi.dart';
import 'profile.dart';
import 'notif.dart';
import '../models/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dropdown_search/dropdown_search.dart';

class DsnBuatTugas extends StatefulWidget {
  const DsnBuatTugas({super.key, required this.title});

  final String title;

  @override
  State<DsnBuatTugas> createState() => Dsn_BuatTugasState();
}

class Dsn_BuatTugasState extends State<DsnBuatTugas> {
  // TextEditingControllers for all input fields
  final TextEditingController _namaTugasController = TextEditingController();
  final TextEditingController _tanggalDibuatController =
      TextEditingController();
  final TextEditingController _jenisController = TextEditingController();
  final TextEditingController _bobotJamController = TextEditingController();
  final TextEditingController _kuotaController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _fileController = TextEditingController();
  // Data Kompetensi (dapat diambil dari _taskDetail)
  List<Map<String, dynamic>> kompetensiData = [];

  // Menyimpan pilihan kompetensi yang dipilih
  List<String> selectedKompetensiIds = [];
  // Menyimpan nama file tugas yang dipilih atau sudah ada
  String? _selectedFileName;
  String? _selectedJenis;
  List<dynamic> _jenisList = []; // List untuk menyimpan data jenis dari API

  void initState() {
    super.initState();
// Mengambil data kompetensi dari API
    fetchKompetensi();
// Mengambil data Jenis dari API
    fetchJenis();
  }

  // Fungsi untuk mengonfirmasi dan menyimpan perubahan
  Future<void> confirmAdd() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); // Retrieve token
    int? userId = prefs.getInt('user_id'); // Retrieve token

    if (token == null) {
      print("Token not found");
      return;
    }
    // Mempersiapkan data yang akan dikirim
    final addData = {
      'tugas_nama': _namaTugasController.text,
      'tugas_bobot': int.parse(_bobotJamController.text),
      'kuota': int.parse(_kuotaController.text),
      'tugas_tgl_deadline': _deadlineController.text,
      'tugas_desc': _deskripsiController.text,
      'tugas_pembuat_id': userId,
      'kompetensi': selectedKompetensiIds,
      'jenis_id': _selectedJenis,
      'tugas_file': _selectedFileName ??
          '', // Jika file tidak diubah, kirimkan null atau string kosong
    };

// URL dengan query string
    final requestUrl = '${apiUrl}tugas/';

// Debug URL untuk verifikasi
    print("Request URL: $requestUrl");
    try {
      final response = await http.post(
        Uri.parse(requestUrl),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: json.encode(addData), // Tambahkan addData ke body
      );

      if (response.statusCode == 201) {
        // Tugas berhasil diperbarui
        print('Task successfully update.');
        // Tampilkan dialog "Tugas berhasil dihapus!"
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text(
                'Tugas berhasil dibuat!',
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
        // Arahkan kembali ke halaman sebelumnya
        // Navigator.pop(context);
      } else {
        // Tangani kesalahan jika status code bukan 201
        print("Response Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Gagal memperbarui tugas')));
      }
    } catch (e) {
      // Tangani kesalahan jika terjadi error saat request
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
    }
  }

  // Fungsi untuk memilih file
  Future<void> pickFile() async {
    // Membuka FilePicker untuk memilih file
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      // Dapatkan nama file yang dipilih
      String? fileName = result.files.single.name;
      setState(() {
        _selectedFileName = fileName;
      });

      // Implementasikan logika pengunggahan file atau penyimpanan path file di backend
      print('File dipilih: $fileName');
    } else {
      // Pengguna membatalkan pemilihan file
      print('File tidak dipilih');
    }
  }

  // Fungsi untuk mengambil data kompetensi dari API
  Future<void> fetchKompetensi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); // Retrieve token

    if (token == null) {
      print("Token not found");
      return;
    }

    final response = await http.get(
      Uri.parse('${apiUrl}kompetensi'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        kompetensiData = List<Map<String, dynamic>>.from(data);
      });
    } else {
      throw Exception('Failed to load kompetensi');
    }
  }

  // Fungsi untuk mengambil data jenis dari API
  Future<void> fetchJenis() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); // Retrieve token

    if (token == null) {
      print("Token not found");
      return;
    }

    final response = await http.get(
      Uri.parse('${apiUrl}jenis'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body); // Decode JSON response
      setState(() {
        _jenisList = data; // Simpan data jenis ke dalam list
      });
    } else {
      print('Failed to load jenis: ${response.statusCode}');
    }
  }

  @override
  void dispose() {
    // Dispose controllers
    _namaTugasController.dispose();
    _tanggalDibuatController.dispose();
    _jenisController.dispose();
    _bobotJamController.dispose();
    _kuotaController.dispose();
    _deadlineController.dispose();
    _deskripsiController.dispose();
    _fileController.dispose();
    super.dispose();
  }

  Future<void> _selectDeadline(BuildContext context) async {
    // Tampilkan DatePicker
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      // Tampilkan TimePicker
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        // Gabungkan tanggal dan waktu
        final DateTime selectedDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        // Format tanggal dan waktu ke string
        final String formattedDateTime =
            DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTime);

        // Update controller
        _deadlineController.text = formattedDateTime;
      }
    }
  }

  void _NotifDsn() {
    print('Notifikasi Mahasiswa');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const DsnNotif(
                  title: 'Sistem Kompensasi',
                )));
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
                onPressed: _NotifDsn,
                icon: Icon(
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
              TextField(
                controller: _namaTugasController,
                decoration: const InputDecoration(
                  labelText: 'Nama Tugas',
                  hintText: 'Masukkan nama tugas',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Pilih Jenis',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedJenis, // Nilai yang dipilih
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Pilih jenis',
                ),
                items: _jenisList.map((jenis) {
                  return DropdownMenuItem<String>(
                    value:
                        jenis['jenis_id'].toString(), // ID jenis sebagai value
                    child: Text(jenis['jenis_nama']), // Nama jenis ditampilkan
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedJenis = value; // Set nilai yang dipilih
                  });
                },
              ),

              const SizedBox(height: 10),

              // Bobot Jam dan Kuota
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _bobotJamController,
                      decoration: const InputDecoration(
                        labelText: 'Bobot Jam',
                        hintText: 'Masukkan bobot jam',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _kuotaController,
                      decoration: const InputDecoration(
                        labelText: 'Kuota Mahasiswa',
                        hintText: 'Masukkan kuota mahasiswa',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // Tenggat Waktu
              GestureDetector(
                onTap: () => _selectDeadline(context),
                child: AbsorbPointer(
                  // Disable manual editing
                  child: TextField(
                    controller: _deadlineController,
                    decoration: const InputDecoration(
                      labelText: 'Tenggat Waktu',
                      hintText: 'Masukkan Deadline',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today), // Kalender Icon
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Bidang Kompetensi
              const Text('Bidang Kompetensi', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              //Dropdown untuk Kompetensi
              DropdownSearch<Map<String, dynamic>>.multiSelection(
                items: kompetensiData,
                itemAsString: (item) => item['kompetensi_nama'],
                selectedItems: kompetensiData
                    .where((item) => selectedKompetensiIds
                        .contains(item['kompetensi_id'].toString()))
                    .toList(),
                popupProps: const PopupPropsMultiSelection.menu(
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      labelText: 'Cari Kompetensi',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: '-- Pilih Kompetensi --',
                    border: OutlineInputBorder(),
                  ),
                ),
                onChanged: (selectedItems) {
                  setState(() {
                    selectedKompetensiIds = selectedItems
                        .map((item) => item['kompetensi_id'].toString())
                        .toList();
                  });
                },
              ),

              const SizedBox(height: 20),
              // Menampilkan kompetensi yang dipilih
              Wrap(
                spacing: 8.0,
                children: selectedKompetensiIds
                    .map((id) => kompetensiData.firstWhere((item) =>
                        item['kompetensi_id'].toString() ==
                        id)['kompetensi_nama'])
                    .map((nama) => Chip(
                          label: Text(nama,
                              style: const TextStyle(color: Colors.white)),
                          backgroundColor: Colors.black,
                        ))
                    .toList(),
              ),

              const SizedBox(height: 10),
              // Deskripsi
              TextField(
                controller: _deskripsiController,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi',
                  hintText: 'Masukkan deskripsi',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),

              const SizedBox(height: 20),
              // File Penunjang Tugas
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'File Penunjang Tugas',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Container untuk upload file
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed:
                              pickFile, // Memanggil fungsi untuk memilih file
                          icon: const Icon(Icons.upload_file,
                              color: Colors.black),
                        ),
                        const Text(
                          'Upload file',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        if (_selectedFileName !=
                            null) // Menampilkan nama file jika ada
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              _selectedFileName!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: confirmAdd,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          backgroundColor: const Color(0xFF2c2c2c),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.save_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              'Simpan',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )),
                  ]),
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
