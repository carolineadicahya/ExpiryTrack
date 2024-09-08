import 'package:expiry_track/screen/add_product.dart';
import 'package:expiry_track/screen/detail_product.dart';
import 'package:expiry_track/screen/login.dart';
import 'package:expiry_track/screen/navbar.dart';
import 'package:expiry_track/screen/product.dart';
import 'package:expiry_track/screen/profil.dart';
import 'package:expiry_track/screen/regist.dart';
import 'package:flutter/material.dart';
import 'package:expiry_track/screen/main_menu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expiry_track/utils/palette.dart';
// import 'package:expiry_track/screen/login.dart'; // Tambahkan file login jika ada

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExpiryTrack',
      theme: ThemeData(
        primaryColor: Palette.primaryColor,
        scaffoldBackgroundColor: Palette.scaffoldBackgroundColor,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      initialRoute: "/",
      onGenerateRoute: _onGenerateRoute,
      // routes: {'/': (context) => Login()},
    );
  }
}

Route<dynamic> _onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/":
      return MaterialPageRoute(builder: (BuildContext context) {
        return const Navbar();
      });
    case "/login":
      return MaterialPageRoute(builder: (BuildContext context) {
        return Login();
      });
    case "/regist":
      return MaterialPageRoute(builder: (BuildContext context) {
        return Regist();
      });
    case "/main_menu":
      return MaterialPageRoute(builder: (BuildContext context) {
        return HomePage();
      });
    case "/add_product":
      return MaterialPageRoute(builder: (BuildContext context) {
        return AddProduct();
      });
    case "/product":
      return MaterialPageRoute(builder: (BuildContext context) {
        return Product();
      });
    case "/product_detail":
      return MaterialPageRoute(builder: (BuildContext context) {
        return const ProductDetail();
      });
    case "/profil":
      return MaterialPageRoute(builder: (BuildContext context) {
        return Profil();
      });
    default:
      return MaterialPageRoute(builder: (BuildContext context) {
        return HomePage(); // Ganti dengan halaman yang sesuai
      });
  }
}
