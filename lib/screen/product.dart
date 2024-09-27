import 'package:expiry_track/widgets/categories.dart';
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
        title: Text(
          'Produk',
          style: TextStyle(
            // fontWeight: FontWeight.bold,
            fontSize: 18,
            fontStyle: FontStyle.italic,
            color: Palette.scaffoldBackgroundColor,
          ),
        ),
        elevation: 0,
        backgroundColor: Palette.primaryColor,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search_rounded,
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
      body: Column(
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
                      color: Palette.primaryColor),
                  onTap: () {
                    Navigator.of(context).pushNamed('/product_detail');
                  },
                ),
              ),
            ),
          ),
        ],
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
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        // color: Palette.primaryColor,
      ),
      onPressed: () {
        Navigator.of(context).pushNamed('/navbar');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = products
        .where((product) => product.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
          onTap: () {
            close(context, results[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = products
        .where((product) => product.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
          },
        );
      },
    );
  }
}
