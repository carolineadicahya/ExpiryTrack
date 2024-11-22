import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expiry_track/services/product_service.dart';
import 'package:expiry_track/utils/palette.dart';
import 'package:expiry_track/widgets/categories.dart';
import 'package:expiry_track/widgets/sneakybar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io'; // Import untuk menggunakan File
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart'; // Import untuk memilih gambar

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key, required this.id});
  final String id;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final ProductService productService = ProductService();

  bool _isEditing = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _barcodeController = TextEditingController();
  String selectedCategory = "";
  File? _image; // Variabel untuk menyimpan gambar produk
  final ImagePicker _picker = ImagePicker(); // Instance dari ImagePicker

  // Controller untuk tanggal kadaluarsa baru
  List<TextEditingController> _newExpiryDateController = [];
  List<String> _newExpiryDates = [];

  // final ImagePicker _picker = ImagePicker();

  // Future<void> _pickImage() async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.camera);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path); // Mengatur gambar yang dipilih
  //     });
  //   }
  // }

  @override
  void dispose() {
    _nameController.dispose();
    _expiryDateController.dispose();
    _barcodeController.dispose();
    for (var controller in _newExpiryDateController) {
      controller.dispose();
    }
    super.dispose();
  }

  // Fungsi untuk menambahkan controller baru
  void _addNewExpiryDateField() {
    setState(() {
      _newExpiryDateController.add(TextEditingController());
    });
  }

  Future<void> _selectNewExpirationDate(
      TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        String formattedDate = DateFormat('dd/MM/yyyy').format(picked);
        controller.text = formattedDate;
        _newExpiryDates.add(formattedDate);
      });
    }
  }

  String _formatDate(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return date; // Jika format tidak valid, kembalikan tanggal asli
    }
  }

  Future<void> _openProductDetails(String barcode) async {
    final Uri url = Uri.parse('https://www.google.com/search?q=$barcode');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() async {
    try {
      // Ambil tanggal kadaluarsa yang baru dari list _newExpiryDates
      List<Timestamp> newExpiredDates = _newExpiryDates
          .map((date) =>
              Timestamp.fromDate(DateFormat('dd/MM/yyyy').parse(date)))
          .toList();

      // Ambil tanggal kadaluarsa utama dan gabungkan dengan tanggal baru
      DateTime mainExpiryDate =
          DateFormat('dd/MM/yyyy').parse(_expiryDateController.text);
      List<Timestamp> allExpiredDates = [
        Timestamp.fromDate(mainExpiryDate),
        ...newExpiredDates
      ];

      // Update data produk di Firestore
      await productService.updateProduct(
        widget.id,
        {
          'name': _nameController.text,
          'category': selectedCategory,
          'barcode': _barcodeController.text,
          'expired': allExpiredDates // Menyimpan daftar tanggal kadaluarsa baru
        },
      );

      // Tampilkan pesan sukses
      sneakyBar(context, 'Produk berhasil diperbarui');
      _toggleEditMode();
    } catch (e) {
      print('Error updating product: $e');
      sneakyBar(context, 'Terjadi kesalahan saat menyimpan perubahan');
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Mengatur gambar yang dipilih
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk'),
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontStyle: FontStyle.italic,
          color: Palette.scaffoldBackgroundColor,
        ),
        backgroundColor: Palette.primaryColor,
        elevation: 0,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: productService.getDetail(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong!'));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Produk tidak ditemukan'));
          }

          DocumentSnapshot item = snapshot.data!;
          Timestamp timestamp = item['expired'];
          DateTime expired = timestamp?.toDate() ?? DateTime.now();

          String productName = item['name'] ?? '';
          String category = item['category'] ?? '';
          String barcode = item['barcode'] ?? '';

          _nameController.text = productName;
          selectedCategory = category;
          _expiryDateController.text = DateFormat('dd/MM/yyyy').format(expired);
          _barcodeController.text = barcode;

          return Container(
            color: Colors.white,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gambar produk
                    GestureDetector(
                      onTap: _isEditing
                          ? _pickImage
                          : null, // Hanya bisa dipilih saat editing
                      child: Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            color: Palette.secondaryBackgroundColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: (item['image'] != null &&
                                  item['image'].isNotEmpty)
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    item['image'],
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Center(
                                  child: Image.asset(
                                      'assets/images/product.png',
                                      fit: BoxFit.cover))),
                    ),
                    const SizedBox(height: 15),
                    _isEditing
                        ? _buildEditableFields()
                        : _buildReadOnlyFields(),
                    const SizedBox(height: 15),
                    const Divider(color: Palette.textSecondaryColor),
                    const SizedBox(height: 15),
                    _buildActionButtons(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEditableFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(_nameController, 'Nama Produk'),
        const SizedBox(height: 16),
        _buildCategoryDropdown(),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
                child: _buildTextField(
                    _expiryDateController, 'Tanggal Kadaluarsa')),
            IconButton(
              icon: const Icon(Icons.add_rounded),
              onPressed: _addNewExpiryDateField,
              tooltip: 'Tambah Tanggal Kadaluarsa Baru',
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Tampilkan daftar tanggal kadaluarsa baru di sini
        ..._newExpiryDateController.map((controller) {
          return Column(
            children: [
              _buildNewExpiryDateField(controller),
              const SizedBox(height: 16), // Menambahkan jarak setelah field
            ],
          );
        }).toList(),

        _buildTextField(_barcodeController, 'Barcode'),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Palette.textSecondaryColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Palette.secondaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.primaryColor),
        ),
      ),
      style: TextStyle(color: Palette.textPrimaryColor),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedCategory.isEmpty ? null : selectedCategory,
      decoration: InputDecoration(
        labelText: 'Kategori',
        labelStyle: TextStyle(color: Palette.textSecondaryColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Palette.secondaryColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Palette.primaryColor),
        ),
      ),
      items:
          Categories.categories.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedCategory = newValue!;
          print('Selected category: $selectedCategory');
        });
      },
    );
  }

  Widget _buildNewExpiryDateField(TextEditingController controller) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Kadaluarsa Baru',
              labelStyle: TextStyle(color: Palette.textSecondaryColor),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Palette.secondaryColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Palette.primaryColor),
              ),
              suffixIcon:
                  Icon(CupertinoIcons.calendar, color: Palette.primaryColor),
            ),
            onTap: () => _selectNewExpirationDate(controller),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.clear_rounded),
          onPressed: () {
            setState(() {
              _newExpiryDateController.remove(controller);
              controller.dispose(); // Hapus controller yang tidak terpakai
            });
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildReadOnlyFields() {
    return Container(
      // padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        elevation: 2,
        color: Palette.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side: Product name, expiry date, and category
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product name
                    Text(
                      'Nama Produk:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _buildReadOnlyText('${_nameController.text}'),

                    const SizedBox(height: 20),
                    // Category
                    Text(
                      'Kategori:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _buildReadOnlyText('$selectedCategory'),

                    const SizedBox(height: 20),
                    // Expiry date
                    Text(
                      'Tanggal Kadaluarsa:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildReadOnlyText(
                        '• ${_formatDate(_expiryDateController.text)}'),
                    if (_newExpiryDateController.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      ..._newExpiryDateController.map((controller) {
                        return _buildReadOnlyText(
                            '• ${_formatDate(controller.text)}');
                      }).toList(),
                    ],
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              const SizedBox(width: 20),
              // Right side: Barcode logo and code
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Barcode',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Palette.textPrimaryColor,
                    ),
                  ),
                  Icon(
                    CupertinoIcons.barcode,
                    color: Colors.blue,
                    size: 80,
                  ),
                  const SizedBox(height: 8),

                  // Barcode text
                  InkWell(
                    onTap: () =>
                        _openProductDetails('${_barcodeController.text}'),
                    child: Text(
                      _barcodeController.text,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReadOnlyText(String text, {bool isError = false}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        color: isError ? Palette.errorColor : Palette.textPrimaryColor,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            _isEditing ? _saveChanges() : _toggleEditMode();
          },
          icon: Icon(_isEditing
              ? CupertinoIcons.tray_arrow_down
              : CupertinoIcons.pencil_outline),
          label: Text(_isEditing ? 'Simpan Perubahan' : 'Edit Produk'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            backgroundColor: _isEditing
                ? const Color.fromARGB(206, 254, 171, 93)
                : Palette.primaryColor,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            _isEditing ? _toggleEditMode() : _showDeleteConfirmation();
          },
          icon: Icon(CupertinoIcons.delete_solid),
          label: Text(_isEditing ? 'Batal Edit' : 'Hapus Produk'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            backgroundColor: Palette.errorColor,
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text('Konfirmasi Hapus',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text('Apakah Anda yakin menghapus produk ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Batal',
                  style: TextStyle(color: Palette.textPrimaryColor)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
              },
              child:
                  Text('Keluar', style: TextStyle(color: Palette.errorColor)),
            ),
          ],
        );
      },
    );
  }
}
