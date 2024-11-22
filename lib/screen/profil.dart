import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expiry_track/widgets/sneakybar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:expiry_track/utils/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class Profil extends StatefulWidget {
  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _nameController = TextEditingController();
  late String _email = 'user@gmail.com'; // or any sensible default value
  String _profilePictureUrl = '';

  bool _isSaving = false;
  bool _isEditing = false;

  File? _image;
  // final ImagePicker _picker = ImagePicker();

  Future<String> _getImageUrl(String imagePath) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(imagePath);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print('Error fetching image: $e');
      return ''; // Return a default empty string or a placeholder image URL
    }
  }

  Future<void> _pickImage() async {
    final _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Mengatur gambar yang dipilih
      });

      // Upload gambar ke Firebase Storage
      try {
        String fileName = pickedFile.name; // Dapatkan nama file dari pickedFile
        Reference storageRef =
            FirebaseStorage.instance.ref().child('profile_pics/$fileName');
        UploadTask uploadTask = storageRef.putFile(_image!);

        // Tunggu upload selesai
        TaskSnapshot snapshot = await uploadTask;

        // Dapatkan URL gambar yang baru di-upload
        String imageUrl = await snapshot.ref.getDownloadURL();
        print('Image URL: $imageUrl'); // Menambahkan log di sini

        // Simpan URL gambar ke Firestore
        await _firestore.collection('user').doc(user!.uid).update({
          'profile_picture': imageUrl,
        });

        // Tampilkan success message
        sneakyBar(context, 'Foto profil berhasil diperbarui');
      } catch (e) {
        sneakyBar(context, 'Gagal mengupload gambar: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    user = _auth.currentUser;

    final profileData =
        await _firestore.collection('user').doc(user!.uid).get();
    if (profileData.exists) {
      setState(() {
        _nameController.text = profileData['name'] ?? 'User';
        _email = profileData['email'] ??
            'user@gmail.com'; // Use default if not found
        _profilePictureUrl = profileData['profile_picture'] ?? '';
        print('Profile picture URL: $_profilePictureUrl');
      });
    } else {
      setState(() {
        _nameController.text = 'User';
        _email = 'user@gmail.com'; // Default value
        _profilePictureUrl = profileData['profile_picture'] ?? '';
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
    await Future.delayed(const Duration(seconds: 1));

    String newName = _nameController.text;
    print('Nama baru: $newName');

    // Mengupdate nama di Firestore
    await _firestore
        .collection('user')
        .doc(user!.uid)
        .update({'name': newName});
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
        title: const Text('Profil'),
        titleTextStyle: const TextStyle(
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
                backgroundImage: (_profilePictureUrl.isNotEmpty)
                    ? NetworkImage((_profilePictureUrl))
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
