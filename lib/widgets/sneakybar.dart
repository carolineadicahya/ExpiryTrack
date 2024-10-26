import 'package:flutter/material.dart';
import 'package:expiry_track/utils/palette.dart';

void sneakyBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(
        color: Palette.scaffoldBackgroundColor,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: Palette.primaryColor,
    duration: const Duration(seconds: 2), // Durasi SneakyBar
    behavior: SnackBarBehavior.floating, // Agar SneakyBar tampak melayang
    margin: const EdgeInsets.all(16), // Margin di sekeliling SneakyBar
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  // Menampilkan SnackBar
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
