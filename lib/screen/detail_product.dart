import 'package:expiry_track/utils/palette.dart';
import 'package:expiry_track/widgets/sneakybar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool _isEditing = false;
  final TextEditingController _nameController =
      TextEditingController(text: 'Produk Contoh');
  final TextEditingController _expiryDateController =
      TextEditingController(text: '2024-09-10');
  final TextEditingController _categoryController =
      TextEditingController(text: 'Makanan');
  final TextEditingController _barcodeController =
      TextEditingController(text: '123456789012');

  @override
  void dispose() {
    _nameController.dispose();
    _expiryDateController.dispose();
    _categoryController.dispose();
    _barcodeController.dispose();
    super.dispose();
  }

  String _formatDate(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return date; // Jika format tidak valid, kembalikan tanggal asli
    }
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    // Implement saving changes functionality
    print('Menyimpan perubahan');
    SneakyBar(context, 'Produk berhasil diperbarui');
    _toggleEditMode();
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar produk
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(
                    'assets/images/product.png'), // Ganti dengan gambar produk
                backgroundColor: Palette.secondaryColor,
              ),
            ),
            const SizedBox(height: 16),
            _isEditing ? _buildEditableFields() : _buildReadOnlyFields(),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _isEditing ? _saveChanges : _toggleEditMode,
                  icon: Icon(_isEditing ? Icons.save : Icons.edit),
                  label: Text(_isEditing ? 'Simpan Perubahan' : 'Edit Produk'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _isEditing ? Palette.accentColor : Palette.primaryColor,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _isEditing ? _toggleEditMode() : _showDeleteConfirmation();
                  },
                  icon: Icon(Icons.delete),
                  label: Text(_isEditing ? 'Batal Edit' : 'Hapus Produk'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _isEditing ? Palette.errorColor : Palette.errorColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Nama Produk',
            labelStyle: TextStyle(color: Palette.textSecondaryColor),
            border: OutlineInputBorder(),
          ),
          style: TextStyle(color: Palette.textPrimaryColor),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _expiryDateController,
          decoration: InputDecoration(
            labelText: 'Tanggal Kadaluarsa',
            labelStyle: TextStyle(color: Palette.textSecondaryColor),
            border: OutlineInputBorder(),
          ),
          style: TextStyle(color: Palette.textPrimaryColor),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _categoryController,
          decoration: InputDecoration(
            labelText: 'Kategori',
            labelStyle: TextStyle(color: Palette.textSecondaryColor),
            border: OutlineInputBorder(),
          ),
          style: TextStyle(color: Palette.textPrimaryColor),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _barcodeController,
          decoration: InputDecoration(
            labelText: 'Barcode',
            labelStyle: TextStyle(color: Palette.textSecondaryColor),
            border: OutlineInputBorder(),
          ),
          style: TextStyle(color: Palette.textPrimaryColor),
        ),
      ],
    );
  }

  Widget _buildReadOnlyFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nama Produk: ${_nameController.text}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Palette.textPrimaryColor,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Kadaluarsa: ${_formatDate(_expiryDateController.text)}',
          style: TextStyle(
            fontSize: 16,
            color: Palette.errorColor,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Kategori: ${_categoryController.text}',
          style: TextStyle(
            fontSize: 16,
            color: Palette.textSecondaryColor,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Barcode: ${_barcodeController.text}',
          style: TextStyle(
            fontSize: 16,
            color: Palette.textSecondaryColor,
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
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus produk ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                // Implement delete functionality
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text(
                'Hapus',
                style: TextStyle(color: Palette.errorColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
