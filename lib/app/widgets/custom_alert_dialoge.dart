
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final VoidCallback yesOntap;
  final VoidCallback noOntap;
  const CustomAlertDialog({
    super.key, required this.title, required this.yesOntap, required this.noOntap,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Center(
        child: Text(
          textAlign: TextAlign.center,
          'Do you want to log out this profile?',
          style: GoogleFonts.poppins(fontSize: 20),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: yesOntap,
          child: Container(
            height: 32.h,
            width: 120.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xff305FA1).withOpacity(0.1),
              border: Border.all(color: Color(0xff305FA1)),
            ),
            child: Center(
              child: Text(
                'YES',
                style: TextStyle(color: Color(0xff305FA1), fontSize: 14),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: noOntap,
          child: Container(
            height: 32.h,
            width: 120.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffA13430).withOpacity(0.1),
              border: Border.all(color: Color(0xffA13430)),
            ),
            child: Center(
              child: Text(
                'NO',
                style: TextStyle(color: Color(0xffA13430), fontSize: 14.sp),
              ),
            ),
          ),
        ),
      ],
    );
  }
}