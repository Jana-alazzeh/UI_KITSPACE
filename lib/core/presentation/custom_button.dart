import 'package:flutter/material.dart';
import 'package:untitled/core/const/colors.dart';

class CustomButton extends StatelessWidget {
  final String buttontext;
  final Color? color;
  final VoidCallback? onTap;

  const CustomButton({
    super.key,
    required this.buttontext,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          color: color ?? COLORs.midPink,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            buttontext,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
