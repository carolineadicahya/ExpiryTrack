import 'package:expiry_track/utils/palette.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
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
