import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 1. استيراد البروفايدر
import 'cart_provider.dart'; // 2. استيراد ملف السلة الخاص بكِ

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  static const Color mainColor = Color(0xFF032BA7);
  String selectedPaymentMethod = 'Cash on Delivery';

  @override
  Widget build(BuildContext context) {
    // 3. سحب بيانات السلة الحقيقية هنا
    final cart = Provider.of<CartProvider>(context);
    double subtotal = cart.totalAmount; // مجموع المنتجات
    double shipping = 5.0; // قيمة الشحن (ثابتة أو متغيرة)
    double total = subtotal + shipping; // الإجمالي النهائي

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text('Checkout', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _sectionTitle('1. Shipping Information'),
            const SizedBox(height: 16),
            _buildTextField(label: 'Full Name'),
            const SizedBox(height: 12),
            _buildTextField(label: 'Full Address'),
            const SizedBox(height: 12),
            _buildTextField(label: 'Phone Number', keyboardType: TextInputType.phone),

            const SizedBox(height: 40),

            _sectionTitle('2. Payment Method'),
            const SizedBox(height: 16),
            _buildPaymentOption('Cash on Delivery', Icons.money),
            _buildPaymentOption('Credit Card', Icons.credit_card),

            const SizedBox(height: 40),

            _sectionTitle('3. Order Summary'),
            const SizedBox(height: 16),

            // 4. عرض الأرقام الحقيقية القادمة من السلة
            _buildSummaryRow('Products Total', '${subtotal.toStringAsFixed(2)}\$'),
            _buildSummaryRow('Shipping', '${shipping.toStringAsFixed(2)}\$'),
            const Divider(),
            _buildSummaryRow('Total Amount', '${total.toStringAsFixed(2)}\$', isTotal: true),

            const SizedBox(height: 24),

            _buildConfirmButton(context),
          ],
        ),
      ),
    );
  }

  // --- دوال صغيرة لتقليل "زحمة" الأقواس في الـ build الرئيسي ---

  Widget _sectionTitle(String title) {
    return Text(title, style: const TextStyle(color: mainColor, fontSize: 18, fontWeight: FontWeight.bold));
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isTotal ? FontWeight.bold : FontWeight.normal, fontSize: 16)),
          Text(value, style: TextStyle(fontWeight: isTotal ? FontWeight.bold : FontWeight.normal, color: isTotal ? mainColor : Colors.black, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildTextField({required String label, TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildPaymentOption(String title, IconData icon) {
    return Card(
      child: RadioListTile<String>(
        title: Text(title),
        value: title,
        groupValue: selectedPaymentMethod,
        onChanged: (value) => setState(() => selectedPaymentMethod = value!),
        secondary: Icon(icon, color: mainColor),
        activeColor: mainColor,
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: mainColor, padding: const EdgeInsets.symmetric(vertical: 15)),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Order Confirmed!')));
      },
      child: const Text('Confirm Order & Pay', style: TextStyle(color: Colors.white, fontSize: 16)),
    );
  }
}