import 'package:expiry_track/widgets/sneakybar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:expiry_track/utils/palette.dart';
import 'package:intl/intl.dart';

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

  TextEditingController _productNameController = TextEditingController();
  TextEditingController _expirationDateController = TextEditingController();
  TextEditingController _productionPTController = TextEditingController();

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

      if (barcode != "-1") {
        // -1 adalah nilai yang dikembalikan jika pemindaian dibatalkan
        _openProductDetails(barcode);
      }
    } catch (e) {
      setState(() {
        barcode = 'Failed to get barcode';
      });
    }
  }

  Future<void> _openProductDetails(String barcode) async {
    final url =
        'https://www.google.com/search?q=$barcode'; // URL untuk pencarian Google
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _selectExpirationDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _expirationDateController.text =
            DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambahkan Produk'),
        centerTitle: false,
        titleTextStyle: TextStyle(
          // fontWeight: FontWeight.bold,
          fontSize: 18,
          fontStyle: FontStyle.italic,
          color: Palette.scaffoldBackgroundColor,
        ),
        backgroundColor: Palette.primaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _productNameController,
              decoration: InputDecoration(
                labelText: 'Nama Produk',
                labelStyle: TextStyle(color: Palette.textSecondaryColor),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.secondaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.primaryColor),
                ),
              ),
              cursorColor: Palette.primaryColor,
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: InputDecoration(
                labelText: 'Kategori',
                labelStyle: TextStyle(color: Palette.textSecondaryColor),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.secondaryColor),
                ),
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
            TextFormField(
              controller: _expirationDateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Tanggal Kadaluarsa',
                labelStyle: TextStyle(color: Palette.textSecondaryColor),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.secondaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.primaryColor),
                ),
                suffixIcon:
                    Icon(Icons.calendar_today, color: Palette.primaryColor),
              ),
              onTap: () => _selectExpirationDate(context),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _productionPTController,
              decoration: InputDecoration(
                labelText: 'PT Produksi',
                labelStyle: TextStyle(color: Palette.textSecondaryColor),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.secondaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.primaryColor),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_productNameController.text.isNotEmpty &&
                      _expirationDateController.text.isNotEmpty &&
                      _productionPTController.text.isNotEmpty) {
                    // Panggil fungsi onSaveProduct untuk menyimpan produk
                    // widget.onSaveProduct({
                    //   'name': _productNameController.text,
                    //   'expiryDate': _expirationDateController.text,
                    //   'category': selectedCategory,
                    //   'production': _productionPTController.text,
                    // });

                    // Menampilkan SneakyBar
                    SneakyBar(context, "Produk berhasil ditambahkan!");

                    // Reset form setelah penyimpanan
                    _productNameController.clear();
                    _expirationDateController.clear();
                    _productionPTController.clear();
                  } else {
                    SneakyBar(context, "Tolong diisi dengan lengkap!");
                  }
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
