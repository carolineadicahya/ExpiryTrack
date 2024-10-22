import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:expiry_track/widgets/categories.dart';
import 'package:expiry_track/widgets/sneakybar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:expiry_track/utils/palette.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String barcode = "Tidak Diketahui";
  String selectedCategory = "Makanan";

  TextEditingController _productNameController = TextEditingController();
  TextEditingController _expirationDateController = TextEditingController();
  TextEditingController _barcodeController = TextEditingController();

  File? _image; // Variabel untuk menyimpan gambar

  final ImagePicker _picker = ImagePicker(); // Instance dari ImagePicker

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Mengatur gambar yang dipilih
      });
    }
  }

  Future<void> _scanBarcode() async {
    try {
      // Waktu maksimum (dalam detik) untuk pemindaian
      int timeoutInSeconds = 10;

      // Menjalankan pemindaian barcode dan mulai menghitung waktu
      String scannedBarcode = await Future.any([
        FlutterBarcodeScanner.scanBarcode(
          '#ff6666',
          'Cancel',
          true,
          ScanMode.BARCODE,
        ),
        Future.delayed(Duration(seconds: timeoutInSeconds), () => "-1")
      ]);

      if (!mounted) return;

      setState(() {
        if (scannedBarcode == "-1") {
          barcode = "Scan timeout or cancelled";
        } else {
          barcode = scannedBarcode;
          _barcodeController.text = barcode;
        }
      });
    } catch (e) {
      setState(() {
        barcode = 'Failed to get barcode';
      });
    }
  }

  Future<void> _openProductDetails(String barcode) async {
    final url = 'https://www.google.com/search?q=$barcode';
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
        automaticallyImplyLeading: false,
        title: Text('Tambahkan Produk'),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontStyle: FontStyle.italic,
          color: Palette.scaffoldBackgroundColor,
        ),
        backgroundColor: Palette.primaryColor,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: DottedBorder(
                  color: Palette.textSecondaryColor,
                  strokeWidth: 1, // Border thickness
                  borderType: BorderType.RRect, // Rounded rectangle type
                  radius: Radius.circular(10), // Same radius as your Container
                  dashPattern: [8, 8], // Dotted pattern with dash lengths
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                          172, 209, 208, 208), // Container background color
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _image == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.cloud_upload,
                                  size: 40, color: Palette.primaryColor),
                              SizedBox(height: 8),
                              Text('Tap untuk tambah foto',
                                  style: TextStyle(
                                      color: Palette.textPrimaryColor)),
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _productNameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(81, 183, 224, 255),
                  labelText: 'Nama Produk',
                  labelStyle: TextStyle(color: Palette.textSecondaryColor),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
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
                  filled: true,
                  fillColor: const Color.fromARGB(81, 183, 224, 255),
                  labelText: 'Kategori',
                  labelStyle: TextStyle(color: Palette.textSecondaryColor),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Palette.secondaryColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Palette.primaryColor),
                  ),
                ),
                items: Categories.categories
                    .map<DropdownMenuItem<String>>((String value) {
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
                  filled: true,
                  fillColor: const Color.fromARGB(81, 183, 224, 255),
                  labelText: 'Tanggal Kadaluarsa',
                  labelStyle: TextStyle(color: Palette.textSecondaryColor),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Palette.secondaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.primaryColor),
                  ),
                  suffixIcon: Icon(CupertinoIcons.calendar,
                      color: Palette.primaryColor),
                ),
                onTap: () => _selectExpirationDate(context),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _barcodeController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(81, 183, 224, 255),
                  labelText: 'Barcode',
                  labelStyle: TextStyle(color: Palette.textSecondaryColor),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Palette.secondaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.primaryColor),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Divider(
                color: Palette.textSecondaryColor,
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _scanBarcode,
                    icon: Icon(CupertinoIcons.barcode_viewfinder),
                    label: Text('Scan Produk'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.accentColor,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(12),
                      // ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_productNameController.text.isNotEmpty &&
                          _expirationDateController.text.isNotEmpty &&
                          _barcodeController.text.isNotEmpty &&
                          _image != null) {
                        // Cek jika gambar sudah diupload
                        SneakyBar(context, "Produk berhasil ditambahkan!");
                        // Reset form setelah penyimpanan
                        _productNameController.clear();
                        _expirationDateController.clear();
                        _barcodeController.clear();
                        setState(() {
                          _image = null; // Reset gambar
                        });
                      } else {
                        SneakyBar(context, "Tolong diisi dengan lengkap!");
                      }
                    },
                    icon: Icon(CupertinoIcons.tray_arrow_down),
                    label: Text('Simpan Produk'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.primaryColor,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(12),
                      // ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Center(
                child: InkWell(
                  onTap: () {
                    if (barcode != "Tidak Diketahui" &&
                        barcode != 'Failed to get barcode') {
                      _openProductDetails(barcode);
                    }
                  },
                  child: Text(
                    'Scanned Barcode: $barcode',
                    style: TextStyle(
                      fontSize: 20,
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
      ),
    );
  }
}
