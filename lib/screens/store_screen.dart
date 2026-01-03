import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'cart_screen.dart'; // تأكد من استيراد صفحة السلة
import 'product_details_screen.dart';

// تعريف الألوان المشتركة
const Color kPrimaryDarkBlue = Color(0xFF032BA7);
const Color kScaffoldBackground = Color(0xFF5D73C0);

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  // القائمة كاملة (8 منتجات)
  final List<Map<String, String>> products = const [
    {'name': 'Keffiyeh T-Shirt (Black)', 'price': '25\$', 'imagePath': 'assets/Images/5.png'},
    {'name': 'Keffiyeh T-Shirt (White)', 'price': '25\$', 'imagePath': 'assets/Images/1.png'},
    {'name': 'Tatreez T-Shirt (Black)', 'price': '25\$', 'imagePath': 'assets/Images/7.png'},
    {'name': 'Tatreez T-Shirt (White)', 'price': '25\$', 'imagePath': 'assets/Images/3.png'},
    {'name': 'Freedom Cap (Black)', 'price': '18\$', 'imagePath': 'assets/Images/9.png'},
    {'name': 'Freedom Cap (White)', 'price': '18\$', 'imagePath': 'assets/Images/10.png'},
    {'name': 'Keffiyeh Water Bottle', 'price': '20\$', 'imagePath': 'assets/Images/13.png'},
    {'name': 'Tatreez Water Bottle', 'price': '20\$', 'imagePath': 'assets/Images/12.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackground,
      // إضافة AppBar يحتوي على شكل السلة مع عداد
      appBar: AppBar(
        title: const Text('KIT Store', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: kPrimaryDarkBlue,
        elevation: 0,
        actions: [
          _buildCartIcon(context), // شكل السلة
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          // يمكنك إضافة التدرج أو النقش هنا كما كان في كودك السابق
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Our Products',
                style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Tech x Palestinian touch',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 20),

              // شبكة المنتجات
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.68,
                ),
                itemBuilder: (context, index) => _buildProductCard(context, products[index]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ويدجت أيقونة السلة مع العداد
  Widget _buildCartIcon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0, top: 5),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.shopping_cart_outlined, size: 28, color: Colors.white),
            // العداد يظهر فقط إذا كان هناك منتجات
            Provider.of<CartProvider>(context).items.isNotEmpty
                ? Positioned(
              right: 0,
              top: 5,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: Text(
                  '${Provider.of<CartProvider>(context).items.length}',
                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  // بطاقة المنتج
  Widget _buildProductCard(BuildContext context, Map<String, String> product) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: product)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(
                  product['imagePath']!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[200], child: const Icon(Icons.image_not_supported)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product['price']!,
                        style: const TextStyle(color: kPrimaryDarkBlue, fontWeight: FontWeight.w900, fontSize: 15),
                      ),
                      // زر الإضافة السريع
                      GestureDetector(
                        onTap: () {
                          Provider.of<CartProvider>(context, listen: false).addToCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Added ${product['name']} to cart'),
                              duration: const Duration(seconds: 1),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(color: kPrimaryDarkBlue, shape: BoxShape.circle),
                          child: const Icon(Icons.add, color: Colors.white, size: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}