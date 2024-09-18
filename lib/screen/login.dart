import 'package:expiry_track/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
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
              // Input Email
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
              // Input Password
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
              // Baris untuk "Forgot Password?" di sebelah kanan
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Forgot Password?',
                      style: TextStyle(
                        color: Palette.primaryColor,
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Implementasi ketika teks di-tap
                          Navigator.of(context).pushNamed('/forgot_password');
                        },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Tombol Login
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Palette.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/navbar');
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              // Tautan untuk pendaftaran
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(
                        color: Palette.textPrimaryColor,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: 'Register',
                      style: TextStyle(
                        color: Palette.accentColor,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushNamed('/regist');
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
