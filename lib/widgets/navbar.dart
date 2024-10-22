import 'package:expiry_track/screen/add_product.dart';
import 'package:expiry_track/screen/main_menu.dart';
import 'package:expiry_track/screen/product.dart';
import 'package:expiry_track/screen/profil.dart';
import 'package:expiry_track/utils/palette.dart';
import 'package:flutter/cupertino.dart';
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
        // backgroundColor: Color(0xFFD1E9F6),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
                selected_index == 0
                    ? CupertinoIcons.house_fill
                    : CupertinoIcons.house,
                size: 30),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
                selected_index == 1
                    ? CupertinoIcons.add_circled_solid
                    : CupertinoIcons.add,
                size: 30),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
                selected_index == 2
                    ? CupertinoIcons.bag_fill
                    : CupertinoIcons.bag,
                size: 30),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
                selected_index == 3
                    ? CupertinoIcons.person_fill
                    : CupertinoIcons.person,
                size: 30),
            label: "",
          ),
        ],
        currentIndex: selected_index,
        onTap: on_itemTapped,
        selectedItemColor: Palette.primaryColor, // Color for selected item
        // selectedItemColor: Palette.accentColor, // Color for selected item
        unselectedItemColor: Colors.black12, // Color for unselected items
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
