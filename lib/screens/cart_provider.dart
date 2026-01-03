import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  // قائمة المنتجات في السلة
  final List<Map<String, String>> _items = [];

  List<Map<String, String>> get items => _items;

  // إضافة منتج للسلة
  void addToCart(Map<String, String> product) {
    _items.add(product);
    notifyListeners(); // لتنبيه الواجهات بالتحديث
  }

  // حذف منتج من السلة
  void removeFromCart(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  // حساب الإجمالي
  double get totalAmount {
    double total = 0.0;
    for (var item in _items) {
      // تنظيف النص لاستخراج الرقم (مثال: "25$" يصبح 25.0)
      String priceText = item['price']!.replaceAll(RegExp(r'[^0-9.]'), '');
      total += double.tryParse(priceText) ?? 0.0;
    }
    return total;
  }
}