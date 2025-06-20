import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBorderElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  const CustomBorderElevatedButton({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 46.h,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black,width: 0.5),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
