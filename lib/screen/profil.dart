import 'package:expiry_track/widgets/sneakybar.dart';
import 'package:flutter/material.dart';
import 'package:expiry_track/utils/palette.dart';

class Profil extends StatefulWidget {
  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final TextEditingController _nameController =
      TextEditingController(text: 'John Doe');
  final String _email = 'johndoe@example.com';

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    // Logika untuk menyimpan nama baru
    String newName = _nameController.text;
    // Simulasi penyimpanan
    print('Nama baru: $newName');
    // Tampilkan SneakyBar
    SneakyBar(context, 'Nama berhasil diperbarui');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontStyle: FontStyle.italic,
          color: Palette.scaffoldBackgroundColor,
        ),
        backgroundColor: Palette.primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.logout_rounded),
            onPressed: () {
              Navigator.of(context).pushNamed('/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Ikon profil pengguna
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/profile.png'),
              backgroundColor: Palette.secondaryColor,
            ),
            SizedBox(height: 20),
            // Nama pengguna dengan TextEditingController
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nama',
                labelStyle: TextStyle(color: Palette.textSecondaryColor),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.secondaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.primaryColor),
                ),
              ),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Palette.textPrimaryColor,
              ),
            ),
            SizedBox(height: 8),
            // Email pengguna sebagai Text
            Text(
              'Email: $_email',
              style: TextStyle(
                fontSize: 16,
                color: Palette.textSecondaryColor,
              ),
            ),
            SizedBox(height: 30),
            Divider(
              color: Palette.textSecondaryColor,
            ),
            SizedBox(height: 20),
            // Tombol simpan perubahan
            ElevatedButton(
              onPressed: _saveChanges,
              child: Text('Simpan Perubahan'),
              style: ElevatedButton.styleFrom(
                primary: Palette.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
