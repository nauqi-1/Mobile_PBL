import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final String apiUrl = 'http://192.168.1.4:8000/api/';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 40, 10, 130)),
        useMaterial3: true,
      ),
      home: const LoginPage(title: 'Sistem Kompensasi'),
    );
  }
}
