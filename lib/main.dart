import 'package:expiry_track/screen/add_product.dart';
import 'package:expiry_track/screen/detail_product.dart';
import 'package:expiry_track/screen/login.dart';
import 'package:expiry_track/screen/navbar.dart';
import 'package:expiry_track/screen/product.dart';
import 'package:expiry_track/screen/profil.dart';
import 'package:expiry_track/screen/regist.dart';
// import 'package:expiry_track/screen/unavailable.dart';
import 'package:flutter/material.dart';
import 'package:expiry_track/screen/main_menu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expiry_track/utils/palette.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ExpiryTrack',
      theme: ThemeData(
        primaryColor: Palette.primaryColor,
        scaffoldBackgroundColor: Palette.scaffoldBackgroundColor,
        textTheme: GoogleFonts.inriaSansTextTheme(
          Theme.of(context).textTheme.copyWith(
                bodyText1: TextStyle(fontWeight: FontWeight.w400),
                headline1: TextStyle(fontWeight: FontWeight.w700),
              ),
        ),
      ),
      initialRoute: "/",
      onGenerateRoute: _onGenerateRoute,
      // routes: {'/': (context) => Login()},
    );
  }
}

Route<dynamic> _onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/login":
      return MaterialPageRoute(builder: (BuildContext context) {
        return Login();
      });
    case "/regist":
      return MaterialPageRoute(builder: (BuildContext context) {
        return Regist();
      });
    case "/navbar":
      return MaterialPageRoute(builder: (BuildContext context) {
        return Navbar();
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
        return Login(); // Ganti dengan halaman yang sesuai
      });
  }
}
