import 'package:expiry_track/utils/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _passObscure = true;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.secondaryBackgroundColor,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Image.asset(
                        "assets/images/login.png",
                        scale: 1.1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                decoration: const BoxDecoration(
                  color: Palette.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Log In Now',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Palette.textPrimaryColor,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(CupertinoIcons.at),
                        labelText: 'Email',
                        // filled: true,
                        // fillColor: const Color.fromARGB(81, 183, 224, 255),
                        labelStyle:
                            TextStyle(color: Palette.textSecondaryColor),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Palette.secondaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.primaryColor),
                        ),
                      ),
                      cursorColor: Palette.primaryColor,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          // prefixIcon: Icon(CupertinoIcons.lock),
                          prefixIcon: Icon(CupertinoIcons.lock),
                          labelText: 'Password',
                          labelStyle:
                              TextStyle(color: Palette.textSecondaryColor),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Palette.secondaryColor)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Palette.primaryColor),
                          ),
                          suffixIcon: IconButton(
                              icon: Icon(_passObscure
                                  ? CupertinoIcons.eye_slash
                                  : CupertinoIcons.eye),
                              onPressed: () {
                                setState(() {
                                  _passObscure = !_passObscure;
                                });
                              })),
                      obscureText: _passObscure,
                      cursorColor: Palette.primaryColor,
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Forgot Password?',
                            style: TextStyle(
                                color: Palette.primaryColor,
                                fontSize: 16,
                                fontStyle: FontStyle.italic),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Implementasi ketika teks di-tap
                                Navigator.of(context)
                                    .pushNamed('/reset_password');
                              },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Palette.primaryColor,
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/navbar');
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
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
                              fontStyle: FontStyle.italic,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pushNamed('/regist');
                              },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
