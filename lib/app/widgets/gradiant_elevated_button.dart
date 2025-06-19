import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_street/app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
      color: AppColors.iconButtonThemeColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: elevatedButton(height, width),
    );
  }

  ElevatedButton elevatedButton(double height, double width) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromWidth(double.maxFinite),
        backgroundColor: Colors.transparent, 
        shadowColor: Colors.transparent, 
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(fontSize: 14.sp,fontWeight: FontWeight.w400,color: Colors.white),
      ),
    );
  }
}
