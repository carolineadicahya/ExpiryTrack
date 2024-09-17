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
    // Data produk hardcoded
    final String productName = 'Produk Contoh';
    final String expiryDate = '2024-09-10';
    final String category = 'Makanan';
    final String barcode = '123456789012';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Produk',
          style: TextStyle(
            color: Palette.textPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Palette.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              child: ListTile(
                title: Text(
                  productName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Palette.textPrimaryColor,
                  ),
                ),
                subtitle: Text(
                  'Kategori: $category',
                  style: TextStyle(
                    color: Palette.textSecondaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kadaluarsa:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Palette.textPrimaryColor,
                  ),
                ),
                Text(
                  expiryDate,
                  style: TextStyle(
                    fontSize: 16,
                    color: Palette.errorColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Barcode:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Palette.textPrimaryColor,
                  ),
                ),
                Text(
                  barcode,
                  style: TextStyle(
                    fontSize: 16,
                    color: Palette.textSecondaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Implement edit product functionality
                  },
                  icon: Icon(Icons.edit),
                  label: Text('Edit Produk'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Palette.accentColor,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Implement delete product functionality
                    _showDeleteConfirmation();
                  },
                  icon: Icon(Icons.delete),
                  label: Text('Hapus Produk'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Palette.errorColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Konfirmasi penghapusan produk
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
