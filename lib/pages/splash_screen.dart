import 'package:flutter/material.dart';
import 'dart:async';
import 'login_page.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Menunggu selama 3 detik, kemudian pindah ke halaman login
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                LoginPage()), // Ganti dengan halaman login atau halaman utama Anda
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color(0xFF7B94E4), // Setel warna latar belakang splash screen
      body: Center(
        child: Image.asset(
            'assets/images/login_top_img.png'), // Menampilkan gambar splash screen
      ),
    );
  }
}
