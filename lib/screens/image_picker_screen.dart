import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();


  Future<void> getImage(ImageSource source) async {

      final XFile? image = await _picker.pickImage(source: source);


        setState(() {
          _image = File(image!.path);
        });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image Picker")),
      body: Center(
        child: Column(
          children: [
            _image != null
                ? Image.file(_image!, width: 200, height: 200, fit: BoxFit.cover)
                : const Icon(Icons.image, size: 100, color: Colors.grey),Text("NO IMAGE SELECTED"),

            const SizedBox(height: 20),

            // زر اختيار الصورة من المعرض
            ElevatedButton.icon(
              onPressed: () => getImage(ImageSource.gallery),
              icon: const Icon(Icons.photo_library),
              label: const Text("Pick from Gallery"),
            ),

            const SizedBox(height: 10),

            // زر التقاط صورة بالكاميرا
            ElevatedButton.icon(
              onPressed: () => getImage(ImageSource.camera),
              icon: const Icon(Icons.camera_alt),
              label: const Text("Take a Photo"),
            ),
          ],
        ),
      ),
    );
  }
}
