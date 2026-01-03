import 'package:flutter/material.dart';
import 'package:untitled/app_theme.dart';

class TodoItem {
  final String title;
  final String description;
  final String time;
  bool isCompleted;
  final String category;

  TodoItem({
    required this.title,
    required this.description,
    required this.time,
    this.isCompleted = false,
    required this.category,
  });
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  // وحدات التحكم لإدخال النصوص
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  List<TodoItem> todoItems = [
    TodoItem(
      title: 'Submit Project Proposal',
      description: 'Complete and submit the final project proposal for the...',
      time: '7:00PM-8:30PM',
      category: 'Inbox',
    ),
  ];

  // دالة لإظهار نافذة إضافة مهمة جديدة
  void _showAddTaskSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // للسماح للوحة المفاتيح بالظهور دون تغطية الحقول
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // يرفع المحتوى فوق الكيبورد
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('New Task', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Task Title', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_titleController.text.isNotEmpty) {
                    setState(() {
                      todoItems.add(TodoItem(
                        title: _titleController.text,
                        description: _descController.text,
                        time: 'Just now', // يمكنك تطويرها لاختيار وقت محدد
                        category: 'Inbox',
                      ));
                    });
                    _titleController.clear();
                    _descController.clear();
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor),
                child: const Text('Add Task', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // SafeArea: تحل مشكلة التداخل مع البطارية والساعة في الأعلى
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Today',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Nov 1 . Saturday',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 24),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: todoItems.length,
                    itemBuilder: (context, index) {
                      return _buildTodoItem(todoItems[index], index);
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20, // عدلنا مكان الزر ليكون فوق الـ Bottom Nav
              right: 20,
              child: FloatingActionButton(
                onPressed: _showAddTaskSheet, // استدعاء دالة الإضافة
                backgroundColor: AppTheme.primaryColor,
                child: const Icon(Icons.add, color: Colors.white, size: 28),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildTodoItem(TodoItem item, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // دائرة الاختيار
          Padding(
            padding: const EdgeInsets.only(top: 4, right: 16),
            child: GestureDetector(
              onTap: () {
                // التعديل هنا: نغير الحالة مباشرة باستخدام index العنصر في القائمة
                setState(() {
                  todoItems[index].isCompleted = !todoItems[index].isCompleted;
                });
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.primaryColor,
                    width: 2,
                  ),
                  color: todoItems[index].isCompleted ? AppTheme.primaryColor : Colors.transparent,
                ),
                child: todoItems[index].isCompleted
                    ? const Icon(Icons.check, color: Colors.white, size: 16)
                    : null,
              ),
            ),
          ),
          // محتوى المهمة
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // العنوان مع خاصية الشطب
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    // هنا يتم التحقق من الحالة لرسم الخط أو إزالته
                    decoration: todoItems[index].isCompleted ? TextDecoration.lineThrough : null,
                    decorationThickness: 2, // لجعل الخط أوضح
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    // شطب الوصف أيضاً إذا أردت
                    decoration: todoItems[index].isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.time,
                  style: const TextStyle(fontSize: 12, color: Color(0xFF4CAF50)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }}