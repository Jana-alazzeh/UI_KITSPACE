import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/screens/edit_profile_screen.dart';
import 'dart:io';

// تعريف الألوان المشتركة
const Color kPrimaryDarkBlue = Color(0xFF032BA7);
const Color kScaffoldBackground = Color(0xFFF7F7F7);
const Color kInputFillColor = Color(0xFFEFEFEF);

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // 1. متحكمات الصورة
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  // 2. دالة التقاط الصورة
  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source, imageQuality: 70);
    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
      // TODO: يمكنك إضافة منطق تحميل الصورة إلى السيرفر هنا
      // _uploadImageToServer(_pickedImage!);
    }
    // إغلاق أي modal مفتوح بعد الاختيار
    if(Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  // 3. عرض خيارات التقاط الصورة
  void _showPickOptionsDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library, color: kPrimaryDarkBlue),
              title: const Text('Choose from Gallery'),
              onTap: () => _pickImage(ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: kPrimaryDarkBlue),
              title: const Text('Take a Photo'),
              onTap: () => _pickImage(ImageSource.camera),
            ),
          ],
        ),
      ),
    );
  }

  // **********************************
  // 4. كود البناء الرئيسي
  // **********************************
  @override
  Widget build(BuildContext context) {
    // نفترض أن هذا الـ Widget سيُعرض داخل Homescreen (The Shell)
    return Scaffold(
      backgroundColor: kScaffoldBackground,
      // 🛑 لا يوجد BottomNavigationBar أو Custom AppBar هنا، سيتم توفيرهما من Homescreen
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 20, // مسافة علوية مناسبة
          left: 20,
          right: 20,
          bottom: 80, // مسافة سفلية
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // شريط علوي بسيط (العنوان وأيقونة القائمة)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 24),
                  onPressed: () {
                    // الرجوع إلى الشاشة السابقة في مكدس الشاشات
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 30),
                const Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.black, // لون داكن
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // أيقونة القائمة (Hamburger Menu)
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.black, size: 30),
                  onPressed: () {
                    // TODO: فتح الـ Drawer أو القائمة الجانبية
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),

            // 5. قسم الصورة الشخصية مع زر التعديل
            _buildProfilePictureSection(),
            const SizedBox(height: 10),

            // اسم المستخدم
            const Text(
              'Jana Alazzeh', // يجب أن تكون قيمة ديناميكية
              style: TextStyle(
                color: kPrimaryDarkBlue,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),



// 6. قائمة الخيارات (List Tiles)
            _buildProfileOption(
              icon: Icons.person_outline,
              title: 'Edit Profile',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfileScreen(),
                  ),
                );
              },
            ),

            _buildProfileOption(
              icon: Icons.notifications_none,
              title: 'Notification',
              onTap: () { /* TODO: الانتقال لصفحة الإشعارات */ },
            ),
            _buildProfileOption(
              icon: Icons.location_on_outlined,
              title: 'Shipping Address',
              onTap: () { /* TODO: الانتقال لصفحة العناوين */ },
            ),
            _buildProfileOption(
              icon: Icons.lock_outline,
              title: 'Change Password',
              onTap: () { /* TODO: الانتقال لصفحة تغيير كلمة المرور */ },
            ),
            const SizedBox(height: 40),

            // 7. زر تسجيل الخروج
            _buildSignOutButton(),
          ],
        ),
      ),
    );
  }

  // دالة بناء قسم الصورة مع زر التعديل
  Widget _buildProfilePictureSection() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey.shade300,
            // عرض الصورة المختارة أو صورة افتراضية
            backgroundImage: _pickedImage != null
                ? FileImage(_pickedImage!)
                : null,
            child: _pickedImage == null
                ? const Icon(Icons.person, size: 60, color: Colors.white)
                : null,
          ),
          // زر التعديل (القلم) - يمكن وضعه هنا أو إخفاءه والاعتماد على onTap للـ CircleAvatar
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: _showPickOptionsDialog, // عند الضغط، تظهر خيارات التقاط الصورة
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kPrimaryDarkBlue,
                ),
                padding: const EdgeInsets.all(4),
                child: const Icon(Icons.camera_alt, size: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // دالة بناء خيارات القائمة
  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          children: [
            Icon(icon, color: kPrimaryDarkBlue, size: 28),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
          ],
        ),
      ),
    );
  }

  // دالة بناء زر تسجيل الخروج
  Widget _buildSignOutButton() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          // TODO: إضافة منطق تسجيل الخروج وحذف التوكن
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logging out...')),
          );
        },
        icon: const Icon(Icons.logout, color: Colors.white),
        label: const Text(
          'Sign Out',
          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryDarkBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}