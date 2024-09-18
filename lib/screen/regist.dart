import 'package:expiry_track/utils/palette.dart';
import 'package:flutter/material.dart';

class Regist extends StatefulWidget {
  @override
  State<Regist> createState() => _RegistState();
}

class _RegistState extends State<Regist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Registration',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Palette.textPrimaryColor,
                  ),
                ),
                Image.asset(
                  'images/regist.png',
                  height: 200,
                  width: 200,
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Palette.textSecondaryColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.secondaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.primaryColor),
                    ),
                  ),
                  cursorColor: Palette.primaryColor,
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Palette.textSecondaryColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.secondaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.primaryColor),
                    ),
                  ),
                  cursorColor: Palette.primaryColor,
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Palette.textSecondaryColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.secondaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.primaryColor),
                    ),
                  ),
                  obscureText: true,
                  cursorColor: Palette.primaryColor,
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(color: Palette.textSecondaryColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.secondaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.primaryColor),
                    ),
                  ),
                  obscureText: true,
                  cursorColor: Palette.primaryColor,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Palette.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/login');
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
