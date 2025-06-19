import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_street/app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  final String name;
  final bool isBack;
  const CustomAppBar({
    super.key, required this.name,  this.isBack = true,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            isBack == true ? Navigator.pop(context) : null;
          },
          child: CircleAvatar(
            backgroundColor: AppColors.iconButtonThemeColor,
            radius: 24.r,
            child: Icon(
              Icons.arrow_back,color: Colors.white,
            ),
          ),
        ),
        
        Text(
          name,
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w500,
          ),
        
        ),
        Container(width: 36.w,)
      ],
    );
  }
}