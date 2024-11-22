import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expiry_track/utils/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Simulate a delay for saving data
        await Future.delayed(const Duration(seconds: 1));

        //logika regist
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        // Menyimpan data pengguna ke Firestore
        await FirebaseFirestore.instance
            .collection('user')
            .doc(userCredential.user!.uid)
            .set({
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'password': _passwordController.text.trim(),
        });
        await userCredential.user!.sendEmailVerification();

        Navigator.pop(context); // Dismiss loading dialog

        _showAlertDialog("Verifikasi Email",
            "Email untuk verifikasi akun telah dikirim ke alamat yang anda daftarkan. Silakan periksa akun email anda.");
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context); // Dismiss loading dialog if there's an error
        if (e.code == 'email-already-in-use') {
          _showAlertDialog('Akun sudah ada',
              'Email ini sudah terdaftar. Silakan gunakan email lain atau masuk dengan email ini.');
        } else if (e.code == 'invalid-email') {
          _showAlertDialog('Akun Tidak Valid',
              'Silakan gunakan alamat email dengan format yang benar (Contoh: pengguna@gmail.com).');
        } else {
          _showAlertDialog('Terjadi Kesalahan',
              'Mohon perhatikan kembali dan perbaiki data yang anda masukkan.');
        }
        print('Kesalahan saat mendaftar: ${e.code}');
      }
    }
  }

  void _showAlertDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Tutup', style: TextStyle(color: Palette.errorColor)),
            ),
          ],
        );
      },
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);
    if (!regex.hasMatch(value)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 6) {
      return 'Password harus minimal 6 karakter';
    }
    if (!RegExp(r'\d').hasMatch(value)) {
      return 'Password harus mengandung angka';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'Password tidak cocok';
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
                      TextFormField(
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
                          errorStyle: TextStyle(
                            color: Palette
                                .errorColor, // Warna kustom untuk pesan error
                            fontSize: 14, // Ukuran font pesan error
                          ),
                        ),
                        cursorColor: Palette.primaryColor,
                        validator: _validateEmail,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
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
                            errorStyle: TextStyle(
                              color: Palette
                                  .errorColor, // Warna kustom untuk pesan error
                              fontSize: 14, // Ukuran font pesan error
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
                        validator: _validatePassword, // Validasi pada password
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
                        validator: _validateConfirmPassword,
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
                          onPressed: _registerUser,
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
