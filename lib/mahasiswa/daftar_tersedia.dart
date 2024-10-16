import 'package:flutter/material.dart';
import 'detil_tugas.dart';

class MhsDaftarTersedia extends StatelessWidget {
  const MhsDaftarTersedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          const Text(
            'DAFTAR TUGAS\nKOMPENSASI TERSEDIA',
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
            child: ListView.builder(
              itemCount: 10, // Jumlah data dummy
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E0E0), // Warna abu-abu
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: const Text('Judul Tugas'),
                      trailing: const Text(
                        'Detail',
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      onTap: () {
                        // Aksi ketika ditekan (bisa navigasi ke detail)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const MhsDetilTugas(), // Arahkan ke halaman detail tugas
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
    );
  }
}
