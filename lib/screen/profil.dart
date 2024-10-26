import 'dart:io';

import 'package:expiry_track/widgets/sneakybar.dart';
import 'package:flutter/material.dart';
import 'package:expiry_track/utils/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class Profil extends StatefulWidget {
  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final TextEditingController _nameController =
      TextEditingController(text: 'Carol');
  final String _email = 'caroline@example.com';
  bool _isSaving = false;
  bool _isEditing = false;

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Mengatur gambar yang dipilih
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _toggleEdit() => setState(() => _isEditing = !_isEditing);

  Future<void> _saveChanges() async {
    setState(() {
      _isSaving = true;
    });

    // Simulate a delay for saving data
    await Future.delayed(const Duration(seconds: 2));

    String newName = _nameController.text;
    print('Nama baru: $newName');
    sneakyBar(context, 'Nama berhasil diperbarui');
    _toggleEdit();

    setState(() {
      _isSaving = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Profil'),
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontStyle: FontStyle.italic,
          color: Palette.scaffoldBackgroundColor,
        ),
        backgroundColor: Palette.primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.pencil_outline),
            tooltip: 'Edit Profil',
            onPressed: _toggleEdit, // Mengubah mode edit
            iconSize: 24,
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: _image != null
                    ? FileImage(_image!) // Display selected image
                    : AssetImage('assets/images/profile.png')
                        as ImageProvider, // Default image
                backgroundColor: Palette.secondaryColor,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Palette.primaryColor,
                          child: Icon(CupertinoIcons.camera,
                              color: Colors.white, size: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Row untuk menampilkan nama dan ikon edit
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tampilkan TextFormField atau Text
                  _isEditing
                      ? Expanded(
                          child: TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Nama',
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
                            ),
                            style: TextStyle(
                              fontSize: 18,
                              color: Palette.textPrimaryColor,
                            ),
                          ),
                        )
                      : Expanded(
                          child: Center(
                            child: Text(
                              _nameController.text,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Palette.textPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Email: $_email',
                style: TextStyle(
                  fontSize: 18,
                  color: Palette.textPrimaryColor,
                ),
              ),
              SizedBox(height: 25),
              Divider(color: Palette.textSecondaryColor),
              SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _isSaving ? Colors.grey : Palette.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _isSaving ? null : _saveChanges,
                  child: _isSaving
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Simpan Perubahan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _showLogoutConfirmation();
                  },
                  icon: Icon(Icons.logout_rounded),
                  label: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16, // Set the font size to 16
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Palette.errorColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text('Keluar', style: TextStyle(fontWeight: FontWeight.bold)),
          content:
              Text('Apakah Anda yakin ingin keluar dari aplikasi ExpiryTrack?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Batal',
                  style: TextStyle(color: Palette.textPrimaryColor)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
              },
              child:
                  Text('Keluar', style: TextStyle(color: Palette.errorColor)),
            ),
          ],
        );
      },
    );
  }
}
