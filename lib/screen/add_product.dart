import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:expiry_track/utils/palette.dart'; // Menggunakan Palette untuk warna yang konsisten

class AddProduct extends StatefulWidget {
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String barcode = "Tidak Diketahui";
  String selectedCategory = "Makanan";
  final List<String> categories = [
    'Makanan',
    'Minuman',
    'Elektronik',
    'Obat Jamu'
  ];

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
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Palette.textPrimaryColor,
        ),
        backgroundColor: Palette.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Nama Produk',
                labelStyle: TextStyle(color: Palette.textSecondaryColor),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Palette.primaryColor),
                ),
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: InputDecoration(
                labelText: 'Kategori',
                labelStyle: TextStyle(color: Palette.textSecondaryColor),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Palette.primaryColor),
                ),
              ),
              items: categories.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Tanggal Kadaluarsa',
                labelStyle: TextStyle(color: Palette.textSecondaryColor),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Palette.primaryColor),
                ),
              ),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Implement save functionality
                },
                child: Text('Simpan Produk'),
                style: ElevatedButton.styleFrom(
                  primary: Palette.primaryColor,
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: _scanBarcode,
                icon: Icon(Icons.qr_code_scanner),
                label: Text('Scan Produk'),
                style: ElevatedButton.styleFrom(
                  primary: Palette.accentColor,
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: InkWell(
                onTap: () {
                  if (barcode != "Tidak Diketahui" &&
                      barcode != 'Failed to get barcode') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Barcode: $barcode')),
                    );
                  }
                },
                child: Text(
                  'Scanned Barcode: $barcode',
                  style: TextStyle(
                    fontSize: 16,
                    color: barcode != "Tidak Diketahui" &&
                            barcode != 'Failed to get barcode'
                        ? Colors.blue
                        : Colors.black,
                    decoration: barcode != "Tidak Diketahui" &&
                            barcode != 'Failed to get barcode'
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
