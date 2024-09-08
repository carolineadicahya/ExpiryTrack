import 'package:expiry_track/utils/palette.dart';
import 'package:flutter/material.dart';

class Unavailable extends StatefulWidget {
  const Unavailable({super.key});

  @override
  State<Unavailable> createState() => _UnavailableState();
}

class _UnavailableState extends State<Unavailable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambahkan Data',
          style: TextStyle(color: Palette.textPrimaryColor),
        ),
        backgroundColor: Palette.primaryColor,
      ),
      body: Center(
        child: Text(
          'Tidak ada data',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
