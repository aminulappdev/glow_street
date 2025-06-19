import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_street/app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class BorderRectangleButton extends StatelessWidget {
  final String name;
  final VoidCallback ontap;
  const BorderRectangleButton({
    super.key,
    required this.name,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
            side: BorderSide(color: AppColors.iconButtonThemeColor,width: 1.5),
          ),
        ),
        child: Text(
          name,
          style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xffA57EA5)),
        ),
      ),
    );
  }
}
