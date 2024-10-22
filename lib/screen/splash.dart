import 'dart:async';
import 'package:flutter/material.dart';
import 'package:expiry_track/utils/palette.dart'; // Sesuaikan dengan lokasi Palette Anda

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Timer untuk splash screen selama 3 detik, kemudian ke halaman login
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushNamed('/login'); // Ganti dengan rute login Anda
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white, // Gunakan warna utama dari Palette
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: RadialGradient(
            radius: 0.9,
            colors: [
              Palette.secondaryBackgroundColor, // Warna pertama
              Colors.white, // Warna kedua
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/clock.gif', // Ganti dengan path logo atau gambar Anda
                width: 300,
                height: 300,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Welcome to ExpiryTrack",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Palette.primaryColor,
                    ),
                  ),
                  const SizedBox(
                      height: 10), // Memberi jarak antara dua paragraf
                  const Text(
                    "made by: Caroline Adi Cahya",
                    style: TextStyle(
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Palette.textPrimaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // const CircularProgressIndicator(
              //   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
