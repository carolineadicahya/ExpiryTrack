// import 'package:expiry_track/utils/palette.dart';
// import 'package:flutter/material.dart';

// class Categories extends StatelessWidget {
//   Categories({
//     super.key,
//     required this.currentCat,
//     required this.onCategorySelected, // Callback untuk kategori yang dipilih
//   });

//   final List<String> categories = [
//     "Semua",
//     "Makanan",
//     "Minuman",
//     "Obat Jamu",
//     "Perawatan",
//     "Elektronik"
//   ];

//   final String currentCat;
//   final ValueChanged<String>
//       onCategorySelected; // Callback untuk kategori yang dipilih

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: List.generate(
//           categories.length,
//           (index) => GestureDetector(
//             onTap: () {
//               onCategorySelected(
//                   categories[index]); // Panggil callback saat kategori dipilih
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 color: currentCat == categories[index]
//                     ? Palette.accentColor // Warna kategori yang dipilih
//                     : Colors.transparent, // Warna kategori yang tidak dipilih
//                 borderRadius: BorderRadius.circular(25),
//                 border: Border.all(
//                   color: currentCat == categories[index]
//                       ? Palette
//                           .accentColor // Warna border kategori yang dipilih
//                       : Palette
//                           .primaryColor, // Warna border kategori yang tidak dipilih
//                 ),
//               ),
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 20,
//                 vertical: 10,
//               ),
//               margin: const EdgeInsets.only(right: 20),
//               child: Text(
//                 categories[index],
//                 style: TextStyle(
//                   color: currentCat == categories[index]
//                       ? Colors.white // Warna teks kategori yang dipilih
//                       : Palette
//                           .primaryColor, // Warna teks kategori yang tidak dipilih
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:expiry_track/utils/palette.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  // Menjadikan categories sebagai variabel statis
  static final List<String> categories = [
    "Semua",
    "Makanan",
    "Minuman",
    "Obat Jamu",
    "Perawatan",
    "Elektronik"
  ];

  Categories({
    super.key,
    required this.currentCat,
    required this.onCategorySelected, // Callback untuk kategori yang dipilih
  });

  final String currentCat;
  final ValueChanged<String> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          categories.length,
          (index) => GestureDetector(
            onTap: () {
              onCategorySelected(categories[index]);
            },
            child: Container(
              decoration: BoxDecoration(
                color: currentCat == categories[index]
                    ? Palette.accentColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: currentCat == categories[index]
                      ? Palette.accentColor
                      : Palette.primaryColor,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              margin: const EdgeInsets.only(right: 20),
              child: Text(
                categories[index],
                style: TextStyle(
                  color: currentCat == categories[index]
                      ? Colors.white
                      : Palette.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
