import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class AddProduct extends StatefulWidget {
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String barcode = "Unknown";

  Future<void> _scanBarcode() async {
    try {
      String scannedBarcode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', // Warna garis batas pemindaian (scan line)
        'Cancel', // Teks tombol untuk membatalkan pemindaian
        true, // Gunakan flashlight saat pemindaian
        ScanMode.BARCODE, // Mode pemindaian (BARCODE atau QR_CODE)
      );
      if (!mounted) return;

      setState(() {
        barcode = scannedBarcode;
      });
    } catch (e) {
      setState(() {
        barcode = 'Failed to get barcode';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambahkan Produk'),
        centerTitle: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Nama Produk'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Kategori'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Tanggal Kadaluarsa'),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement save functionality
              },
              child: Text('Simpan Produk'),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _scanBarcode,
              icon: Icon(Icons.qr_code_scanner),
              label: Text('Scan Produk'),
            ),
            SizedBox(height: 20),
            Text(
              'Scanned Barcode: $barcode',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
