import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Future<void> Function()? onPressedAsync;
  final bool isDanger;
  final bool isLoading;

  const CustomElevatedButton({
    super.key,
    required this.title,
    this.onPressed,
    this.onPressedAsync,
    this.isDanger = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading || (onPressed == null && onPressedAsync == null)
          ? null
          : () {
              if (onPressed != null) {
                onPressed!();
              } else if (onPressedAsync != null) {
                onPressedAsync!();
              }
            }, // Disable tap when loading
      child: Container(
        height: 46.h,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: isDanger
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xffFF3356), Color(0xffFF3356)],
                )
              : const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff4E4CBC), Color(0xff0501FF)],
                ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }
}