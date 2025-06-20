import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDisableElevatedButton extends StatelessWidget {
  final String title;

  const CustomDisableElevatedButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 46.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey,

          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: const Color.fromARGB(255, 71, 71, 71),
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
