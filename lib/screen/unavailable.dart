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
      body: Center(
        child: Text(
          'Tidak ada data',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
