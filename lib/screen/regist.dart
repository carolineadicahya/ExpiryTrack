import 'package:expiry_track/utils/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Regist extends StatefulWidget {
  const Regist({super.key});

  @override
  State<Regist> createState() => _RegistState();
}

class _RegistState extends State<Regist> {
  bool _passObscure = true;
  bool _confirmObscure = true;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  String? _validatePassword() {
    if (_passwordController.text != _confirmPasswordController.text) {
      return "Password don't match";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.secondaryBackgroundColor,
      body: Form(
        key: _formKey,
        child: Container(
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
                          "assets/images/regist.png",
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
                        'Sign Up Now',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Palette.textPrimaryColor,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(CupertinoIcons.person),
                          labelText: 'Name',
                          labelStyle:
                              TextStyle(color: Palette.textSecondaryColor),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Palette.secondaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Palette.primaryColor),
                          ),
                        ),
                        cursorColor: Palette.primaryColor,
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(CupertinoIcons.at),
                          labelText: 'Email',
                          labelStyle:
                              TextStyle(color: Palette.textSecondaryColor),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Palette.secondaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Palette.primaryColor),
                          ),
                        ),
                        cursorColor: Palette.primaryColor,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(CupertinoIcons.lock),
                            labelText: 'Password',
                            labelStyle:
                                TextStyle(color: Palette.textSecondaryColor),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Palette.secondaryColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Palette.primaryColor),
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
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(CupertinoIcons.lock),
                            labelText: 'Confirm Password',
                            labelStyle:
                                TextStyle(color: Palette.textSecondaryColor),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Palette.secondaryColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Palette.primaryColor),
                            ),
                            errorStyle: TextStyle(
                              color: Palette
                                  .errorColor, // Warna kustom untuk pesan error
                              fontSize: 14, // Ukuran font pesan error
                            ),
                            suffixIcon: IconButton(
                                icon: Icon(_confirmObscure
                                    ? CupertinoIcons.eye_slash
                                    : CupertinoIcons.eye),
                                onPressed: () {
                                  setState(() {
                                    _confirmObscure = !_confirmObscure;
                                  });
                                })),
                        obscureText: _confirmObscure,
                        cursorColor: Palette.primaryColor,
                        validator: (value) => _validatePassword(),
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
                              )),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.of(context).pushNamed('/login');
                            }
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
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
      ),
    );
  }
}
