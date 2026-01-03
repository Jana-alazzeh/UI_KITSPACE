import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'package:untitled/screens/checkout_screen.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // استخدام Provider.of بدلاً من context.watch
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        backgroundColor: const Color(0xFF032BA7),
        foregroundColor: Colors.white,
      ),
      body: cart.items.isEmpty
          ? const Center(child: Text('Your cart is empty!'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final item = cart.items[index];
                return _buildCartItem(context, item, index);
              },
            ),
          ),
          _buildSummaryCard(context, cart.totalAmount),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CheckoutScreen(),
                  ),
                );

              },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF032BA7),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Checkout', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, Map<String, String> item, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        leading: Image.asset(item['imagePath']!, width: 50, fit: BoxFit.cover),
        title: Text(item['name']!),
        subtitle: Text(item['price']!),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            // استخدام Provider.of بدلاً من context.read
            Provider.of<CartProvider>(context, listen: false).removeFromCart(index);
          },
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, double total) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total Amount:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(
              '${total.toStringAsFixed(2)}\$',
              style: const TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}