import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/screens/cart_provider.dart'; // تأكد من صحة المسار

// تعريف الألوان المشتركة
const Color kPrimaryDarkBlue = Color(0xFF032BA7);
const Color kScaffoldBackground = Color(0xFFCCCCE5);

class ProductDetailsScreen extends StatefulWidget {
  final Map<String, String> product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String _selectedSize = 'M';
  int _quantity = 1;
  final List<String> availableSizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];

  @override
  Widget build(BuildContext context) {
    final String productName = widget.product['name'] ?? "Product Details";
    final String productPrice = widget.product['price'] ?? "N/A";
    final String productImage = widget.product['imagePath'] ?? ""; // استلام مسار الصورة

    return Scaffold(
      backgroundColor: kScaffoldBackground,
      appBar: AppBar(
        title: Text(productName),
        backgroundColor: kPrimaryDarkBlue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. قسم الصورة مع الخلفية المزخرفة
            Container(
              height: 320,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/kuffiyeh_pattern.png',
                      fit: BoxFit.cover,
                      color: Colors.black.withOpacity(0.1),
                      colorBlendMode: BlendMode.modulate,
                      errorBuilder: (context, error, stackTrace) => Container(color: kScaffoldBackground),
                    ),
                  ),
                  // عرض الصورة الحقيقية للمنتج هنا
                  Center(
                    child: Hero(
                      tag: productName, // تأثير انتقال سلس للصورة
                      child: _buildActualProductImage(productImage),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),

                  const Text(
                    'Unique design inspired by Palestinian heritage. Made of 100% soft cotton for everyday comfort. High-quality print and durable fabric.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    'Price: $productPrice',
                    style: const TextStyle(
                      color: kPrimaryDarkBlue,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 25),

                  const Text('Select Size:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 10),
                  _buildSizeSelection(),
                  const SizedBox(height: 25),

                  const Text('Quantity:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 10),
                  _buildQuantityControl(),
                  const SizedBox(height: 30),

                  _buildAddToCartButton(productName),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة عرض الصورة الحقيقية بدلاً من الـ Placeholder
  Widget _buildActualProductImage(String path) {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          path,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 100, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildSizeSelection() {
    return Row(
      children: availableSizes.map((size) {
        final bool isSelected = size == _selectedSize;
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: GestureDetector(
            onTap: () => setState(() => _selectedSize = size),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: isSelected ? kPrimaryDarkBlue : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected ? kPrimaryDarkBlue : Colors.grey.shade300,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                size,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildQuantityControl() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      width: 130,
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildQuantityButton(Icons.remove, () {
            if (_quantity > 1) setState(() => _quantity--);
          }),
          Text('$_quantity', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          _buildQuantityButton(Icons.add, () => setState(() => _quantity++)),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onTap) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, size: 20, color: kPrimaryDarkBlue),
    );
  }

  Widget _buildAddToCartButton(String productName) {
    return SizedBox(
      height: 55,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          // إضافة المنتج للسلة فعلياً عبر الـ Provider
          Provider.of<CartProvider>(context, listen: false).addToCart(widget.product);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Added $productName (Size: $_selectedSize) to your cart!'),
              backgroundColor: kPrimaryDarkBlue,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        icon: const Icon(Icons.shopping_cart, color: Colors.white),
        label: const Text(
          'Add to Cart',
          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryDarkBlue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}