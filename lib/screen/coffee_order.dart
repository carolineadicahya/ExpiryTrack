import 'package:flutter/material.dart';

class CoffeeOrderPage extends StatefulWidget {
  @override
  _CoffeeOrderPageState createState() => _CoffeeOrderPageState();
}

class _CoffeeOrderPageState extends State<CoffeeOrderPage> {
  String _orderType = 'delivery'; // Default to delivery
  String _paymentMethod = 'cash'; // Default to cash
  int _coffeeCount = 1;
  double _discount = 10.0;
  double _coffeePrice = 45000.0; // Set price to IDR
  double _deliveryFee = 10000.0; // Delivery fee
  TextEditingController _addressController = TextEditingController();
  TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double subtotal = _coffeePrice * _coffeeCount;
    double total = subtotal -
        (_discount / 100 * subtotal) +
        (_orderType == 'delivery' ? _deliveryFee : 0);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Coffee',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: PaletteColor.darkMocha,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Delivery or Pickup Selection
            _buildOrderTypeSelection(),
            SizedBox(height: 16),

            // Address Input (only for delivery)
            if (_orderType == 'delivery') _buildAddressField(),

            SizedBox(height: 16),

            // Coffee Image and Details
            _buildCoffeeDetails(),

            SizedBox(height: 16),

            // Discount Card
            _buildDiscountCard(),

            SizedBox(height: 16),

            // Payment Summary
            _buildPaymentSummary(subtotal, total),

            SizedBox(height: 16),

            // Payment Method Selection
            _buildPaymentMethodSelection(),

            // Submit Button
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle order submission logic
                _showOrderConfirmationDialog(subtotal, total);
              },
              style: ElevatedButton.styleFrom(
                primary: PaletteColor.coffeeBrown,
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(24), // Added border radius
                ),
              ),
              child: Text('Order'),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOrderTypeSelection() {
    return Container(
      padding:
          const EdgeInsets.all(16.0), // Tambahkan padding di sekitar container
      child: Center(
        child: Container(
          width: double.infinity, // Stretch the container to full width
          decoration: BoxDecoration(
            color: Colors.white, // Background color of the container
            borderRadius: BorderRadius.circular(24), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2), // Shadow color
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3), // Position of shadow
              ),
            ],
          ),
          child: ToggleButtons(
            isSelected: [_orderType == 'delivery', _orderType == 'pickup'],
            onPressed: (int index) {
              setState(() {
                _orderType = index == 0 ? 'delivery' : 'pickup';
              });
            },
            selectedColor: Colors.white, // Text color when selected
            fillColor:
                PaletteColor.coffeeBrown, // Background color when selected
            color: PaletteColor.darkMocha, // Text color when not selected
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0), // Set vertical padding for height

                  child: Text('Delivery')), // Center text within padding
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0), // Set vertical padding for height
                child:
                    Center(child: Text('Pickup')), // Center text within padding
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Delivery Address',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(
                height: 4,
              ),
              Text('Jl. Kpg Sutoyo',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(height: 4),
              Text('Kpg. Sutoyo no. 620, Blitzen, Tanjung Balai',
                  style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        Row(
          children: [
            // Edit Address Button
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: PaletteColor.darkEspresso), // Border color
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, size: 16),
                    onPressed: () {
                      _addressController.text;
                    },
                  ),
                  Text(
                    'Edit Address',
                    style: TextStyle(fontSize: 9), // Text size
                  ),
                ],
              ),
            ),
            SizedBox(width: 9),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: PaletteColor.darkEspresso), // Border color
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, size: 16),
                    onPressed: () {
                      _noteController.text;
                    },
                  ),
                  Text(
                    'Add Notes',
                    style: TextStyle(fontSize: 9), // Text size
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCoffeeDetails() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'images/kopi.png', // Update this path if needed
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover, // Adjust the image to fit
                ),
                SizedBox(width: 16), // Space between image and text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cappuccino',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Deep Foam',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (_coffeeCount > 1) _coffeeCount--;
                    });
                  },
                ),
                Text(
                  '$_coffeeCount',
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _coffeeCount++;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiscountCard() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24), // Added border radius
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('1 Discount applies >',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildPaymentSummary(double subtotal, double total) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Payment Summary',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          _buildSummaryRow('Price', subtotal, isBold: true, fontSize: 14),
          _buildSummaryRow('Delivery Fee', _deliveryFee,
              isBold: true, fontSize: 14),
        ],
      ),
    );
  }

// Modify _buildSummaryRow to accept fontSize
  Widget _buildSummaryRow(String title, double amount,
      {bool isBold = false, double fontSize = 16}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontSize: fontSize)),
        Text('Rp. ${amount.toStringAsFixed(0)}',
            style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontSize: fontSize)),
      ],
    );
  }

  Widget _buildPaymentMethodSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.wallet, color: PaletteColor.darkMocha),
            SizedBox(width: 8),
            Text('Cash/E-Wallet', style: TextStyle(fontSize: 16)),
          ],
        ),
        Text(
            'Rp. ${(_coffeePrice * _coffeeCount + (_orderType == 'delivery' ? _deliveryFee : 0)).toStringAsFixed(0)}',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  void _showOrderConfirmationDialog(double subtotal, double total) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24), // Added border radius
          ),
          title: Text('Confirm Your Order'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Subtotal: Rp. ${subtotal.toStringAsFixed(0)}'),
              if (_orderType == 'delivery')
                Text('Delivery Fee: Rp. ${_deliveryFee.toStringAsFixed(0)}'),
              Text('Total: Rp. ${total.toStringAsFixed(0)}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle order submission logic here
                Navigator.of(context).pop(); // Close the dialog
                // Perform further actions
              },
              child: Text('Confirm Order'),
            ),
          ],
        );
      },
    );
  }
}

// Palet warna yang digunakan
class PaletteColor {
  static const Color coffeeBrown = Color(0xFF6F4E37); // Warna utama
  static const Color creamyBeige = Color(0xFFD7CCC8); // Warna sekunder
  static const Color darkEspresso = Color(0xFF3E2723); // Aksen
  static const Color coffeeFoam = Color(0xFFF5F5DC); // Latar belakang
  static const Color darkMocha = Color(0xFF4E342E); // Warna teks
  static const Color caramel =
      Color.fromARGB(255, 144, 96, 5); // Sorotan (misal tombol Order)
}
