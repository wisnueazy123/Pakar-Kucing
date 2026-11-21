import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';

void main() {
  runApp(const PakarKucingApp());
}

/// Aplikasi Sistem Pakar Diagnosa Penyakit Kucing.
class PakarKucingApp extends StatelessWidget {
  const PakarKucingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pakar Kucing',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD4A373),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5E6D3),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF8B5E3C),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 2,
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color(0xFF8B5E3C),
          contentTextStyle: TextStyle(color: Colors.white),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
