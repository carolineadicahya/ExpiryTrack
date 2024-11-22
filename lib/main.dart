import 'package:expiry_track/screen/add_product.dart';
import 'package:flutter/services.dart';
// import 'package:expiry_track/screen/coffee_order.dart';
import 'package:expiry_track/screen/detail_product.dart';
import 'package:expiry_track/screen/forgot_password.dart';
import 'package:expiry_track/screen/login.dart';
import 'package:expiry_track/widgets/navbar.dart';
import 'package:expiry_track/screen/product.dart';
import 'package:expiry_track/screen/profil.dart';
import 'package:expiry_track/screen/regist.dart';
import 'package:expiry_track/screen/splash.dart';
// import 'package:expiry_track/screen/unavailable.dart';
import 'package:flutter/material.dart';
import 'package:expiry_track/screen/main_menu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expiry_track/utils/palette.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      // DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ExpiryTrack',
      home: const SplashScreen(),
      theme: ThemeData(
        primaryColor: Palette.primaryColor,
        scaffoldBackgroundColor: Palette.scaffoldBackgroundColor,
        textTheme: GoogleFonts.interTextTheme(),
      ),
      initialRoute: "/",
      onGenerateRoute: _onGenerateRoute,
    );
  }
}

Route<dynamic> _onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/login":
      return MaterialPageRoute(builder: (BuildContext context) {
        return const Login();
      });
    case "/regist":
      return MaterialPageRoute(builder: (BuildContext context) {
        return const Regist();
      });
    case "/reset_password":
      return MaterialPageRoute(builder: (BuildContext context) {
        return ForgotPass();
      });
    case "/navbar":
      return MaterialPageRoute(builder: (BuildContext context) {
        return const Navbar();
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
    // case "/product_detail":
    //   return MaterialPageRoute(builder: (BuildContext context) {
    //     return const ProductDetail(id: productId);
    //   });
    case "/profil":
      return MaterialPageRoute(builder: (BuildContext context) {
        return Profil();
      });
    default:
      return MaterialPageRoute(builder: (BuildContext context) {
        return const Login(); // Ganti dengan halaman yang sesuai
        // return CoffeeOrderPage();
      });
  }
}
