import 'dart:io';

import 'package:expiry_track/screen/detail_product.dart';
import 'package:expiry_track/services/product_service.dart';
import 'package:expiry_track/widgets/categories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expiry_track/utils/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class Product extends StatefulWidget {
  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  ProductService productService = ProductService();

  String _selectedCategory = 'Semua'; // Kategori default

  final List<Map<String, String>> _products = List.generate(
    10,
    (index) => {
      'name': 'Produk ${index + 1}',
      'expiryDate': '2024-09-10',
      'category': Categories.categories[index % Categories.categories.length],
    },
  );

  String _formatDate(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return date; // Jika format tidak valid, kembalikan tanggal asli
    }
  }

  File? _image;
  // final ImagePicker _picker = ImagePicker();

  Future<String> _getImageUrl(String imagePath) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(imagePath);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print('Error fetching image: $e');
      return ''; // Return a default empty string or a placeholder image URL
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Produk'),
        centerTitle: true,
        titleTextStyle: TextStyle(
          // fontWeight: FontWeight.bold,
          fontSize: 18,
          fontStyle: FontStyle.italic,
          color: Palette.scaffoldBackgroundColor,
        ),
        elevation: 0,
        backgroundColor: Palette.primaryColor,
        actions: [
          IconButton(
            icon: Icon(
              CupertinoIcons.search,
            ),
            onPressed: () {
              // Implement search functionality
              showSearch(
                context: context,
                delegate: ProductSearch(),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 16),
            Categories(
              currentCat: _selectedCategory,
              onCategorySelected: (category) {
                setState(() {
                  _selectedCategory = category; // Update kategori yang dipilih
                });
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: productService.getData(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('Tidak ada produk tersedia.'));
                  }

                  // Filter produk berdasarkan kategori yang dipilih
                  final filteredProducts = snapshot.data!.docs.where((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return _selectedCategory == 'Semua' ||
                        data['category'] == _selectedCategory;
                  }).toList();

                  return ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (ctx, i) {
                      final productData =
                          filteredProducts[i].data() as Map<String, dynamic>;

                      return Card(
                        elevation: 0,
                        color: const Color.fromARGB(81, 183, 224, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: Palette.secondaryColor,
                            width: 0.7,
                          ),
                        ),
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: (productData['image'] != null &&
                                    productData['image'].isNotEmpty)
                                ? NetworkImage(
                                    productData['image']) // Gambar dari URL
                                : AssetImage('assets/images/product.png')
                                    as ImageProvider,
                            backgroundColor: Palette.secondaryBackgroundColor,
                          ),
                          title: Text(
                            productData['name'] ?? 'Produk',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Palette.textPrimaryColor,
                            ),
                          ),
                          subtitle: Text(
                            productData['expired'] != null
                                ? 'Kadaluarsa: ${(productData['expired'] as Timestamp).toDate()}'
                                : 'Tanggal kadaluarsa tidak tersedia',
                            style: TextStyle(color: Palette.textSecondaryColor),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios,
                              color: Palette.accentColor),
                          onTap: () {
                            final productId = filteredProducts[i]
                                .id; // Mengambil ID dari snapshot
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetail(id: productId),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, String>> _filteredProducts() {
    if (_selectedCategory == 'Semua') {
      return _products;
    }
    return _products
        .where((product) => product['category'] == _selectedCategory)
        .toList();
  }
}

// Kelas pencarian produk
class ProductSearch extends SearchDelegate<String> {
  final List<String> products =
      List.generate(10, (index) => 'Produk ${index + 1}');

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
            Navigator.of(context).pop();
          },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios_new_rounded,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = products
        .where((product) => product.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return results.isNotEmpty
        ? ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  results[index],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  close(context, results[index]);
                },
              );
            },
          )
        : Center(
            child: Text('Tidak ada produk "$query"'),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = products
        .where((product) => product.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions.isNotEmpty
        ? ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: RichText(
                  text: TextSpan(
                    text: suggestions[index].substring(
                        0,
                        suggestions[index]
                            .toLowerCase()
                            .indexOf(query.toLowerCase())),
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: suggestions[index].substring(
                            suggestions[index]
                                .toLowerCase()
                                .indexOf(query.toLowerCase()),
                            suggestions[index]
                                    .toLowerCase()
                                    .indexOf(query.toLowerCase()) +
                                query.length),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Palette.primaryColor), // Highlighted text
                      ),
                      TextSpan(
                        text: suggestions[index].substring(suggestions[index]
                                .toLowerCase()
                                .indexOf(query.toLowerCase()) +
                            query.length),
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/product_detail');
                  // query = suggestions[index];
                },
              );
            },
          )
        : Center(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center the content vertically
              children: [
                Image.asset(
                  "assets/images/search.png",
                  height: 250,
                  width: 250,
                ),
                Text(
                  'Produk tidak tersedia', // Text indicating no products available
                  style: TextStyle(
                      fontSize: 16,
                      color: Palette
                          .textSecondaryColor), // Customize the text style
                ),
              ],
            ),
          );
  }
}
