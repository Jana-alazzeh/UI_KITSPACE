import 'package:flutter/material.dart';
import 'package:untitled/core/const/colors.dart';
import 'package:untitled/core/utils/sqflite_helper.dart';

class SqlfliteScreen extends StatefulWidget {
  const SqlfliteScreen({super.key});

  @override
  State<SqlfliteScreen> createState() => _SqlfliteScreenState();
}

class _SqlfliteScreenState extends State<SqlfliteScreen> {
  bool isLoading = true;
  List<Map<String, dynamic>> _items = [];

  // ===== TextEditingControllers للأسماء والأسعار =====
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    load(); // تحميل البيانات عند البداية
  }

  // ===== دالة تحميل البيانات من Sqflite =====
  Future<void> load() async {
    try {
      final rows = await SqfliteHelper.sqfliteHelper.getAllItems();
      setState(() {
        _items = rows;
        isLoading = false;
      });
      print("item fetch");
      print(_items);
    } catch (e) {
      print("Error loading items: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ===== AppBar جميل مع Gradient =====
      appBar: AppBar(
        title: Text(
          "Sqflite",
          style: TextStyle(
            color: COLORs.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: COLORs.Primary,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [COLORs.midPink, COLORs.DarkPink],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
        ),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),

      // ===== TextFields فوق الليست =====
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // حقل الاسم
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: COLORs.Primary,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: COLORs.DarkPink,
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
            SizedBox(height: 8),

            // حقل السعر
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Price",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: COLORs.Primary,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: COLORs.DarkPink,
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
            SizedBox(height: 16),

            // ===== ListView للعرض مع Edit و Delete =====
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _items.isEmpty
                  ? Center(child: Text("NO Data"))
                  : ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return ListTile(
                    title: Text(item['name']),
                    subtitle: Text(item['price'].toString()),

                    // ===== أيقونات Edit و Delete =====
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: COLORs.DarkPink),
                          onPressed: () {
                            _showEditDialog(item); // فتح نافذة التعديل
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: COLORs.greyDark),
                          onPressed: () async {
                            await SqfliteHelper.sqfliteHelper.deleteItem(item['id']); // حذف العنصر
                            load(); // إعادة تحميل البيانات بعد الحذف
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // ===== FloatingActionButton لإضافة عنصر جديد =====
      floatingActionButton: FloatingActionButton( backgroundColor: COLORs.lightPink,
        child: Icon(Icons.add,color: COLORs.DarkPink,),
        onPressed: () async {
          final name = _nameController.text.trim();
          final priceText = _priceController.text.trim();
          if (name.isEmpty || priceText.isEmpty) return;

          final data = {
            'name': name,
            'price': double.tryParse(priceText) ?? 0.0,
          };

          try {
            await SqfliteHelper.sqfliteHelper.insertItem(data);
            _nameController.clear();
            _priceController.clear();
            load();
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }

  // ===== دالة فتح نافذة التعديل =====
  void _showEditDialog(Map<String, dynamic> item) {
    final TextEditingController _editName = TextEditingController(text: item['name']);
    final TextEditingController _editPrice = TextEditingController(text: item['price'].toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Item"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _editName,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: _editPrice,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Price"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // إلغاء التعديل
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                final updatedData = {
                  'name': _editName.text.trim(),
                  'price': double.tryParse(_editPrice.text.trim()) ?? 0.0,
                };
                await SqfliteHelper.sqfliteHelper.updateItem(item['id'], updatedData); // تحديث العنصر
                Navigator.pop(context);
                load(); // إعادة تحميل البيانات بعد التعديل
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
