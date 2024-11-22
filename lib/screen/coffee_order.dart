// import 'package:flutter/material.dart';

// class CoffeeOrderPage extends StatefulWidget {
//   @override
//   _CoffeeOrderPageState createState() => _CoffeeOrderPageState();
// }

// class _CoffeeOrderPageState extends State<CoffeeOrderPage> {
//   String _orderType = 'delivery'; // Default to delivery
//   String _paymentMethod = 'cash'; // Default to cash
//   int _coffeeCount = 1;
//   double _discount = 10.0;
//   double _coffeePrice = 45000.0; // Set price to IDR
//   double _deliveryFee = 10000.0; // Delivery fee
//   TextEditingController _addressController = TextEditingController();
//   TextEditingController _noteController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     double subtotal = _coffeePrice * _coffeeCount;
//     double total = subtotal -
//         (_discount / 100 * subtotal) +
//         (_orderType == 'delivery' ? _deliveryFee : 0);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Order Coffee',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: PaletteColor.darkMocha,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Container(
//         color: Colors.white,
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             // Delivery or Pickup Selection
//             _buildOrderTypeSelection(),
//             SizedBox(height: 16),

//             // Address Input (only for delivery)
//             if (_orderType == 'delivery') _buildAddressField(),

//             SizedBox(height: 16),

//             // Coffee Image and Details
//             _buildCoffeeDetails(),

//             SizedBox(height: 16),

//             // Discount Card
//             _buildDiscountCard(),

//             SizedBox(height: 16),

//             // Payment Summary
//             _buildPaymentSummary(subtotal, total),

//             SizedBox(height: 16),

//             // Payment Method Selection
//             _buildPaymentMethodSelection(),

//             // Submit Button
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 // Handle order submission logic
//                 _showOrderConfirmationDialog(subtotal, total);
//               },
//               style: ElevatedButton.styleFrom(
//                 primary: PaletteColor.coffeeBrown,
//                 padding: EdgeInsets.symmetric(vertical: 16),
//                 textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 shape: RoundedRectangleBorder(
//                   borderRadius:
//                       BorderRadius.circular(24), // Added border radius
//                 ),
//               ),
//               child: Text('Order'),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildOrderTypeSelection() {
//     return Container(
//       padding:
//           const EdgeInsets.all(16.0), // Tambahkan padding di sekitar container
//       child: Center(
//         child: Container(
//           width: double.infinity, // Stretch the container to full width
//           decoration: BoxDecoration(
//             color: Colors.white, // Background color of the container
//             borderRadius: BorderRadius.circular(24), // Rounded corners
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2), // Shadow color
//                 spreadRadius: 1,
//                 blurRadius: 5,
//                 offset: Offset(0, 3), // Position of shadow
//               ),
//             ],
//           ),
//           child: ToggleButtons(
//             isSelected: [_orderType == 'delivery', _orderType == 'pickup'],
//             onPressed: (int index) {
//               setState(() {
//                 _orderType = index == 0 ? 'delivery' : 'pickup';
//               });
//             },
//             selectedColor: Colors.white, // Text color when selected
//             fillColor:
//                 PaletteColor.coffeeBrown, // Background color when selected
//             color: PaletteColor.darkMocha, // Text color when not selected
//             children: [
//               Padding(
//                   padding: const EdgeInsets.symmetric(
//                       vertical: 12.0,
//                       horizontal: 16.0), // Set vertical padding for height

//                   child: Text('Delivery')), // Center text within padding
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                     vertical: 12.0,
//                     horizontal: 16.0), // Set vertical padding for height
//                 child:
//                     Center(child: Text('Pickup')), // Center text within padding
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAddressField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Delivery Address',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//               SizedBox(
//                 height: 4,
//               ),
//               Text('Jl. Kpg Sutoyo',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//               SizedBox(height: 4),
//               Text('Kpg. Sutoyo no. 620, Blitzen, Tanjung Balai',
//                   style: TextStyle(color: Colors.grey)),
//             ],
//           ),
//         ),
//         Row(
//           children: [
//             // Edit Address Button
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(
//                     color: PaletteColor.darkEspresso), // Border color
//                 borderRadius: BorderRadius.circular(8), // Rounded corners
//               ),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.edit, size: 16),
//                     onPressed: () {
//                       _addressController.text;
//                     },
//                   ),
//                   Text(
//                     'Edit Address',
//                     style: TextStyle(fontSize: 9), // Text size
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(width: 9),
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(
//                     color: PaletteColor.darkEspresso), // Border color
//                 borderRadius: BorderRadius.circular(8), // Rounded corners
//               ),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.edit, size: 16),
//                     onPressed: () {
//                       _noteController.text;
//                     },
//                   ),
//                   Text(
//                     'Add Notes',
//                     style: TextStyle(fontSize: 9), // Text size
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildCoffeeDetails() {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8.0),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Image.asset(
//                   'images/kopi.png', // Update this path if needed
//                   width: 50,
//                   height: 50,
//                   fit: BoxFit.cover, // Adjust the image to fit
//                 ),
//                 SizedBox(width: 16), // Space between image and text
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Cappuccino',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       'Deep Foam',
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.remove),
//                   onPressed: () {
//                     setState(() {
//                       if (_coffeeCount > 1) _coffeeCount--;
//                     });
//                   },
//                 ),
//                 Text(
//                   '$_coffeeCount',
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.add),
//                   onPressed: () {
//                     setState(() {
//                       _coffeeCount++;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDiscountCard() {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(24), // Added border radius
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Text('1 Discount applies >',
//             style: TextStyle(fontWeight: FontWeight.bold)),
//       ),
//     );
//   }

//   Widget _buildPaymentSummary(double subtotal, double total) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Payment Summary',
//               style: TextStyle(fontWeight: FontWeight.bold)),
//           SizedBox(height: 8),
//           _buildSummaryRow('Price', subtotal, isBold: true, fontSize: 14),
//           _buildSummaryRow('Delivery Fee', _deliveryFee,
//               isBold: true, fontSize: 14),
//         ],
//       ),
//     );
//   }

// // Modify _buildSummaryRow to accept fontSize
//   Widget _buildSummaryRow(String title, double amount,
//       {bool isBold = false, double fontSize = 16}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(title,
//             style: TextStyle(
//                 fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//                 fontSize: fontSize)),
//         Text('Rp. ${amount.toStringAsFixed(0)}',
//             style: TextStyle(
//                 fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//                 fontSize: fontSize)),
//       ],
//     );
//   }

//   Widget _buildPaymentMethodSelection() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             Icon(Icons.wallet, color: PaletteColor.darkMocha),
//             SizedBox(width: 8),
//             Text('Cash/E-Wallet', style: TextStyle(fontSize: 16)),
//           ],
//         ),
//         Text(
//             'Rp. ${(_coffeePrice * _coffeeCount + (_orderType == 'delivery' ? _deliveryFee : 0)).toStringAsFixed(0)}',
//             style: TextStyle(fontWeight: FontWeight.bold)),
//       ],
//     );
//   }

//   void _showOrderConfirmationDialog(double subtotal, double total) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(24), // Added border radius
//           ),
//           title: Text('Confirm Your Order'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('Subtotal: Rp. ${subtotal.toStringAsFixed(0)}'),
//               if (_orderType == 'delivery')
//                 Text('Delivery Fee: Rp. ${_deliveryFee.toStringAsFixed(0)}'),
//               Text('Total: Rp. ${total.toStringAsFixed(0)}',
//                   style: TextStyle(fontWeight: FontWeight.bold)),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Handle order submission logic here
//                 Navigator.of(context).pop(); // Close the dialog
//                 // Perform further actions
//               },
//               child: Text('Confirm Order'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// // Palet warna yang digunakan
// class PaletteColor {
//   static const Color coffeeBrown = Color(0xFF6F4E37); // Warna utama
//   static const Color creamyBeige = Color(0xFFD7CCC8); // Warna sekunder
//   static const Color darkEspresso = Color(0xFF3E2723); // Aksen
//   static const Color coffeeFoam = Color(0xFFF5F5DC); // Latar belakang
//   static const Color darkMocha = Color(0xFF4E342E); // Warna teks
//   static const Color caramel =
//       Color.fromARGB(255, 144, 96, 5); // Sorotan (misal tombol Order)
// }

// import 'package:expiry_track/utils/palette.dart';
// import 'package:expiry_track/widgets/categories.dart';
// import 'package:expiry_track/widgets/sneakybar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'dart:io'; // Import untuk menggunakan File
// import 'package:image_picker/image_picker.dart';
// import 'package:url_launcher/url_launcher.dart'; // Import untuk memilih gambar

// class ProductDetail extends StatefulWidget {
//   const ProductDetail({super.key});

//   @override
//   State<ProductDetail> createState() => _ProductDetailState();
// }

// class _ProductDetailState extends State<ProductDetail> {
//   bool _isEditing = false;
//   final TextEditingController _nameController =
//       TextEditingController(text: 'Produk Contoh');
//   final TextEditingController _expiryDateController =
//       TextEditingController(text: '20/03/2024');
//   final TextEditingController _barcodeController =
//       TextEditingController(text: '123456789012');
//   String selectedCategory = "Makanan";
//   File? _image; // Variabel untuk menyimpan gambar produk
//   final ImagePicker _picker = ImagePicker(); // Instance dari ImagePicker

//   // Controller untuk tanggal kadaluarsa baru
//   List<TextEditingController> _newExpiryDateController = [];
//   List<String> _newExpiryDates =
//       []; // List untuk menyimpan tanggal kadaluarsa baru

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _expiryDateController.dispose();
//     _barcodeController.dispose();
//     for (var controller in _newExpiryDateController) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   // Fungsi untuk menambahkan controller baru
//   void _addNewExpiryDateField() {
//     setState(() {
//       _newExpiryDateController.add(TextEditingController());
//     });
//   }

//   Future<void> _selectNewExpirationDate(
//       TextEditingController controller) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2101),
//     );

//     if (picked != null) {
//       setState(() {
//         String formattedDate = DateFormat('dd/MM/yyyy').format(picked);
//         controller.text = formattedDate;
//         _newExpiryDates.add(formattedDate);
//       });
//     }
//   }

//   String _formatDate(String date) {
//     try {
//       DateTime parsedDate = DateTime.parse(date);
//       return DateFormat('dd/MM/yyyy').format(parsedDate);
//     } catch (e) {
//       return date; // Jika format tidak valid, kembalikan tanggal asli
//     }
//   }

//   Future<void> _openProductDetails(String barcode) async {
//     final Uri url = Uri.parse('https://www.google.com/search?q=$barcode');
//     if (await canLaunchUrl(url)) {
//       await launchUrl(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   void _toggleEditMode() {
//     setState(() {
//       _isEditing = !_isEditing;
//     });
//   }

//   void _saveChanges() {
//     // Implement saving changes functionality
//     print('Menyimpan perubahan');
//     sneakyBar(context, 'Produk berhasil diperbarui');
//     _toggleEditMode();
//   }

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path); // Mengatur gambar yang dipilih
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detail Produk'),
//         centerTitle: false,
//         titleTextStyle: TextStyle(
//           fontSize: 18,
//           fontStyle: FontStyle.italic,
//           color: Palette.scaffoldBackgroundColor,
//         ),
//         backgroundColor: Palette.primaryColor,
//         elevation: 0,
//       ),
//       body: Container(
//         color: Colors.white,
//         height: double.infinity,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Gambar produk
//                 GestureDetector(
//                   onTap: _isEditing
//                       ? _pickImage
//                       : null, // Hanya bisa dipilih saat editing
//                   child: Container(
//                     width: double.infinity,
//                     height: 300,
//                     decoration: BoxDecoration(
//                       color: Palette.secondaryBackgroundColor,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: _image == null
//                         ? Center(
//                             child: Image.asset('assets/images/product.png',
//                                 fit: BoxFit.cover))
//                         : ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: Image.file(
//                               _image!,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//                 _isEditing ? _buildEditableFields() : _buildReadOnlyFields(),
//                 const SizedBox(height: 15),
//                 const Divider(color: Palette.textSecondaryColor),
//                 const SizedBox(height: 15),
//                 _buildActionButtons(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildEditableFields() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildTextField(_nameController, 'Nama Produk'),
//         const SizedBox(height: 16),
//         _buildCategoryDropdown(),
//         const SizedBox(height: 16),
//         Row(
//           children: [
//             Expanded(
//                 child: _buildTextField(
//                     _expiryDateController, 'Tanggal Kadaluarsa')),
//             IconButton(
//               icon: const Icon(Icons.add_rounded),
//               onPressed: _addNewExpiryDateField,
//               tooltip: 'Tambah Tanggal Kadaluarsa Baru',
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),

//         // Tampilkan daftar tanggal kadaluarsa baru di sini
//         ..._newExpiryDateController.map((controller) {
//           return Column(
//             children: [
//               _buildNewExpiryDateField(controller),
//               const SizedBox(height: 16), // Menambahkan jarak setelah field
//             ],
//           );
//         }).toList(),

//         _buildTextField(_barcodeController, 'Barcode'),
//         const SizedBox(height: 16),
//       ],
//     );
//   }

//   Widget _buildTextField(TextEditingController controller, String label) {
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: Palette.textSecondaryColor),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Palette.secondaryColor),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Palette.primaryColor),
//         ),
//         // labelStyle: TextStyle(color: Palette.textSecondaryColor),
//         // border: OutlineInputBorder(),
//       ),
//       style: TextStyle(color: Palette.textPrimaryColor),
//     );
//   }

//   Widget _buildCategoryDropdown() {
//     return DropdownButtonFormField<String>(
//       value: selectedCategory,
//       decoration: InputDecoration(
//         labelText: 'Kategori',
//         labelStyle: TextStyle(color: Palette.textSecondaryColor),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Palette.secondaryColor),
//         ),
//         focusedBorder: UnderlineInputBorder(
//           borderSide: BorderSide(color: Palette.primaryColor),
//         ),
//       ),
//       items:
//           Categories.categories.map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//       onChanged: (String? newValue) {
//         setState(() {
//           selectedCategory = newValue!;
//         });
//       },
//     );
//   }

//   Widget _buildNewExpiryDateField(TextEditingController controller) {
//     return Row(
//       children: [
//         Expanded(
//           child: TextFormField(
//             controller: controller,
//             readOnly: true,
//             decoration: InputDecoration(
//               labelText: 'Kadaluarsa Baru',
//               labelStyle: TextStyle(color: Palette.textSecondaryColor),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide(color: Palette.secondaryColor),
//               ),
//               focusedBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Palette.primaryColor),
//               ),
//               suffixIcon:
//                   Icon(CupertinoIcons.calendar, color: Palette.primaryColor),
//             ),
//             onTap: () => _selectNewExpirationDate(controller),
//           ),
//         ),
//         IconButton(
//           icon: const Icon(Icons.clear_rounded),
//           onPressed: () {
//             setState(() {
//               _newExpiryDateController.remove(controller);
//               controller.dispose(); // Hapus controller yang tidak terpakai
//             });
//           },
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }

//   Widget _buildReadOnlyFields() {
//     return Container(
//       // padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       child: Card(
//         elevation: 2,
//         color: Palette.scaffoldBackgroundColor,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Left side: Product name, expiry date, and category
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Product name
//                     Text(
//                       'Nama Produk:',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     _buildReadOnlyText(_nameController.text),

//                     const SizedBox(height: 20),
//                     // Category
//                     Text(
//                       'Kategori:',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     _buildReadOnlyText(selectedCategory),

//                     const SizedBox(height: 20),
//                     // Expiry date
//                     Text(
//                       'Tanggal Kadaluarsa:',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.redAccent,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     _buildReadOnlyText(
//                         '• ${_formatDate(_expiryDateController.text)}'),
//                     if (_newExpiryDateController.isNotEmpty) ...[
//                       const SizedBox(height: 8),
//                       ..._newExpiryDateController.map((controller) {
//                         return _buildReadOnlyText(
//                             '• ${_formatDate(controller.text)}');
//                       }).toList(),
//                     ],
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),

//               const SizedBox(width: 20),
//               // Right side: Barcode logo and code
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Barcode',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Palette.textPrimaryColor,
//                     ),
//                   ),
//                   Icon(
//                     CupertinoIcons.barcode,
//                     color: Colors.blue,
//                     size: 80,
//                   ),
//                   const SizedBox(height: 8),

//                   // Barcode text
//                   InkWell(
//                     onTap: () => _openProductDetails(_barcodeController.text),
//                     child: Text(
//                       _barcodeController.text,
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 20,
//                         decoration: TextDecoration.underline,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildReadOnlyText(String text, {bool isError = false}) {
//     return Text(
//       text,
//       style: TextStyle(
//         fontSize: 20,
//         color: isError ? Palette.errorColor : Palette.textPrimaryColor,
//       ),
//     );
//   }

//   Widget _buildActionButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         ElevatedButton.icon(
//           onPressed: _isEditing ? _saveChanges : _toggleEditMode,
//           icon: Icon(_isEditing
//               ? CupertinoIcons.tray_arrow_down
//               : CupertinoIcons.pencil_outline),
//           label: Text(_isEditing ? 'Simpan Perubahan' : 'Edit Produk'),
//           style: ElevatedButton.styleFrom(
//             padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
//             backgroundColor: _isEditing
//                 ? const Color.fromARGB(206, 254, 171, 93)
//                 : Palette.primaryColor,
//           ),
//         ),
//         ElevatedButton.icon(
//           onPressed: () {
//             _isEditing ? _toggleEditMode() : _showDeleteConfirmation();
//           },
//           icon: Icon(CupertinoIcons.delete_solid),
//           label: Text(_isEditing ? 'Batal Edit' : 'Hapus Produk'),
//           style: ElevatedButton.styleFrom(
//             padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
//             backgroundColor: Palette.errorColor,
//           ),
//         ),
//       ],
//     );
//   }

//   void _showDeleteConfirmation() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           title: Text('Konfirmasi Hapus',
//               style: TextStyle(fontWeight: FontWeight.bold)),
//           content: Text('Apakah Anda yakin menghapus produk ini?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close dialog
//               },
//               child: Text('Batal',
//                   style: TextStyle(color: Palette.textPrimaryColor)),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pushNamed('/login');
//               },
//               child:
//                   Text('Keluar', style: TextStyle(color: Palette.errorColor)),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expiry_track/services/product_service.dart';
import 'package:expiry_track/utils/palette.dart';
import 'package:expiry_track/widgets/categories.dart';
import 'package:expiry_track/widgets/sneakybar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io'; // Import untuk menggunakan File
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart'; // Import untuk memilih gambar

class ProductDetail extends StatefulWidget {
  final String id; // You should pass the product ID for fetching data
  const ProductDetail({Key? key, required this.id});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final ProductService productService = ProductService();

  bool _isEditing = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _barcodeController = TextEditingController();
  String selectedCategory = '';
  File? _image; // Variabel untuk menyimpan gambar produk
  final ImagePicker _picker = ImagePicker(); // Instance dari ImagePicker

  // Controller untuk tanggal kadaluarsa baru
  List<TextEditingController> _newExpiryDateController = [];
  List<String> _newExpiryDates =
      []; // List untuk menyimpan tanggal kadaluarsa baru

  @override
  void dispose() {
    _nameController.dispose();
    _expiryDateController.dispose();
    _barcodeController.dispose();
    for (var controller in _newExpiryDateController) {
      controller.dispose();
    }
    super.dispose();
  }

  // Fungsi untuk menambahkan controller baru
  void _addNewExpiryDateField() {
    setState(() {
      _newExpiryDateController.add(TextEditingController());
    });
  }

  Future<void> _selectNewExpirationDate(
      TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        String formattedDate = DateFormat('dd/MM/yyyy').format(picked);
        controller.text = formattedDate;
        _newExpiryDates.add(formattedDate);
      });
    }
  }

  String _formatDate(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return date; // Jika format tidak valid, kembalikan tanggal asli
    }
  }

  Future<void> _openProductDetails(String barcode) async {
    final Uri url = Uri.parse('https://www.google.com/search?q=$barcode');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    // Implement saving changes functionality
    print('Menyimpan perubahan');
    sneakyBar(context, 'Produk berhasil diperbarui');
    _toggleEditMode();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Mengatur gambar yang dipilih
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk'),
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontStyle: FontStyle.italic,
          color: Palette.scaffoldBackgroundColor,
        ),
        backgroundColor: Palette.primaryColor,
        elevation: 0,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream:
            productService.getDetail(widget.id), // Get product details by id
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong!'));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No product found.'));
          }

          DocumentSnapshot item = snapshot.data!;
          Timestamp timestamp = item['expired'];
          DateTime expired = timestamp?.toDate() ?? DateTime.now();

          String productName = item['name'] ?? '';
          String category = item['category'] ?? '';
          String barcode = item['barcode'] ?? '';

          _nameController.text = productName;
          _expiryDateController.text = DateFormat('dd/MM/yyyy').format(expired);
          _barcodeController.text = barcode;

          return Container(
            color: Colors.white,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gambar produk
                    GestureDetector(
                      onTap: _isEditing
                          ? _pickImage
                          : null, // Hanya bisa dipilih saat editing
                      child: Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Palette.secondaryBackgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _image == null
                            ? Center(
                                child: Image.asset('assets/images/product.png',
                                    fit: BoxFit.cover))
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    _isEditing
                        ? _buildEditableFields()
                        : _buildReadOnlyFields(),
                    const SizedBox(height: 15),
                    const Divider(color: Palette.textSecondaryColor),
                    const SizedBox(height: 15),
                    _buildActionButtons(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEditableFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(_nameController, 'Nama Produk'),
        const SizedBox(height: 16),
        _buildCategoryDropdown(),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
                child: _buildTextField(
                    _expiryDateController, 'Tanggal Kadaluarsa')),
            IconButton(
              icon: const Icon(Icons.add_rounded),
              onPressed: _addNewExpiryDateField,
              tooltip: 'Tambah Tanggal Kadaluarsa Baru',
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Tampilkan daftar tanggal kadaluarsa baru di sini
        ..._newExpiryDateController.map((controller) {
          return Column(
            children: [
              _buildNewExpiryDateField(controller),
              const SizedBox(height: 16), // Menambahkan jarak setelah field
            ],
          );
        }).toList(),
        _buildTextField(_barcodeController, 'Barcode'),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Palette.textSecondaryColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Palette.secondaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.primaryColor),
        ),
      ),
      style: TextStyle(color: Palette.textPrimaryColor),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedCategory.isNotEmpty ? selectedCategory : null,
      decoration: InputDecoration(
        labelText: 'Kategori',
        labelStyle: TextStyle(color: Palette.textSecondaryColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Palette.secondaryColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Palette.primaryColor),
        ),
      ),
      items:
          Categories.categories.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedCategory = newValue!;
        });
      },
    );
  }

  Widget _buildNewExpiryDateField(TextEditingController controller) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Kadaluarsa Baru',
              labelStyle: TextStyle(color: Palette.textSecondaryColor),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Palette.secondaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.primaryColor),
              ),
            ),
            onTap: () {
              _selectNewExpirationDate(controller); // Seleksi tanggal
            },
          ),
        ),
      ],
    );
  }

  Widget _buildReadOnlyFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoText('Nama Produk: ${_nameController.text}'),
        const SizedBox(height: 16),
        _buildInfoText('Kategori: $selectedCategory'),
        const SizedBox(height: 16),
        _buildInfoText('Tanggal Kadaluarsa: ${_expiryDateController.text}'),
        const SizedBox(height: 16),
        _buildInfoText('Barcode: ${_barcodeController.text}'),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildInfoText(String text) {
    return Text(
      text,
      style: TextStyle(color: Palette.textPrimaryColor),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: _toggleEditMode,
          child: Text(_isEditing ? 'Batal' : 'Ubah'),
        ),
        if (_isEditing)
          ElevatedButton(
            onPressed: _saveChanges,
            child: const Text('Simpan'),
          ),
      ],
    );
  }
}
