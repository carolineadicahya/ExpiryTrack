import 'package:expiry_track/widgets/categories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expiry_track/utils/palette.dart'; // Import palette untuk warna yang konsisten

class Product extends StatefulWidget {
  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  String _selectedCategory = 'Semua'; // Kategori default

  final List<Map<String, String>> _products = List.generate(
    10,
    (index) => {
      'name': 'Produk ${index + 1}',
      'expiryDate': '2024-09-10',
      'category': Categories.categories[index % Categories.categories.length],
    },
  );

  @override
  Widget build(BuildContext context) {
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
              child: ListView.builder(
                itemCount: _filteredProducts().length,
                itemBuilder: (ctx, i) => Card(
                  elevation: 0,
                  color: const Color.fromARGB(81, 183, 224, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Palette.secondaryColor,
                      width: 0.7,
                    ),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Palette.primaryColor,
                      child: Text('${i + 1}'),
                    ),
                    title: Text(
                      _filteredProducts()[i]['name']!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Palette.textPrimaryColor,
                      ),
                    ),
                    subtitle: Text(
                      'Kadaluarsa: ${_filteredProducts()[i]['expiryDate']}',
                      style: TextStyle(color: Palette.textSecondaryColor),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: Palette.accentColor),
                    onTap: () {
                      Navigator.of(context).pushNamed('/product_detail');
                    },
                  ),
                ),
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
