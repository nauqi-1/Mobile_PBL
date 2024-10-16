import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                Icon(Icons.check_circle, color: Colors.green, size: 40),
                SizedBox(height: 10),
                Text("Tugas berhasil dibuat"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
              style: const TextStyle(color: Colors.white, fontSize: 20),
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
                hintText: 'Judul Tugas',
                hintStyle: TextStyle(color: Color(0xffd9d9d9)),
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
                      hintText: 'Bobot Jam',
                      hintStyle: TextStyle(color: Color(0xffd9d9d9)),
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
                      hintText: 'Kuota Mahasiswa',
                      hintStyle: TextStyle(color: Color(0xffd9d9d9)),
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
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () {
                        // Code to select date
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.access_time),
                      onPressed: () {
                        // Code to select time
                      },
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
                hintText: 'Deskripsi',
                hintStyle: TextStyle(color: Color(0xffd9d9d9)),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: _isFormValid
                    ? () async {
                        await _showSuccessPopup();
                      }
                    : null,
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.home_outlined,
                    color: Colors.white, size: 35),
              ),
              IconButton(
                onPressed: () {},
                icon:
                    const Icon(Icons.list_sharp, color: Colors.white, size: 30),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.briefcase,
                    color: Colors.white, size: 30),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.account_circle_outlined,
                    color: Colors.white, size: 35),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
