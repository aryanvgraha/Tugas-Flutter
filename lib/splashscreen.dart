import 'dart:async';

import 'package:flutter/material.dart';

import 'screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Durasi splash screen (misalnya 3 detik sebelum pindah ke halaman utama)
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ), // Ganti dengan halaman utama Anda
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // Background gradasi ungu selaras dengan tema aplikasi
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 23, 7, 95),
              Colors.deepPurpleAccent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Unigal pengganti icon toga
            Container(
              width: 190,
              height: 190,
              padding: const EdgeInsets.all(8),

              child: ClipOval(
                child: Image.asset(
                  'assets/logo.png', // Sesuaikan path gambar logo Anda
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback jika gambar belum terbaca
                    return const Icon(
                      Icons.school,
                      size: 50,
                      color: Color.fromARGB(255, 32, 14, 110),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Nama Aplikasi / Kampus
            const Text(
              'Unigal Apps',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Portal Informasi Mahasiswa Universitas Galuh',
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
            const SizedBox(height: 48),
            // Loading Indicator kecil di bawah
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
