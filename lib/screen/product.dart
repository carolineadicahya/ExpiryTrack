import 'package:flutter/material.dart';

class Product extends StatefulWidget {
  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produk'),
        centerTitle: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Implement filter functionality
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10, // Hardcoded for example
        itemBuilder: (ctx, i) => ListTile(
          title: Text('Produk ${i + 1}'),
          subtitle: Text('Kadaluarsa: 2024-09-10'),
        ),
      ),
    );
  }
}
