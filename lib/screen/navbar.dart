import 'package:expiry_track/screen/add_product.dart';
import 'package:expiry_track/screen/main_menu.dart';
import 'package:expiry_track/screen/product.dart';
import 'package:expiry_track/screen/profil.dart';
import 'package:expiry_track/utils/palette.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int selected_index = 0;

  final List<Widget> _widget_options = <Widget>[
    HomePage(),
    AddProduct(),
    Product(),
    Profil()
  ];

  void on_itemTapped(int index) {
    setState(() {
      selected_index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widget_options[selected_index],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.add_rounded), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_rounded), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ""),
        ],
        currentIndex: selected_index,
        onTap: on_itemTapped,
        // backgroundColor: Colors.deepPurple, // Warna latar belakang navbar
        selectedItemColor: Palette.primaryColor, // Warna item yang dipilih
        unselectedItemColor: Colors.black12, // Warna item yang tidak dipilih
        showSelectedLabels:
            false, // Menyembunyikan label untuk item yang dipilih
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
