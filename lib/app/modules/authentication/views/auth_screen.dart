import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glow_street/app/modules/authentication/views/sign_in_screen.dart';
import 'package:glow_street/app/modules/common/views/main_navigation_bar.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/costum_border_elevated_button.dart';
import 'package:glow_street/app/widgets/costum_elavated_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 400.h),
              Text(
                'Welcome to GlowStreet – Safety & Support for Women',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              heightBox12,
              Text(
                'Feel empowered with real-time safety features, trusted location sharing, and emergency support – all in one place. Begin your journey to feeling safer and more connected, wherever you are.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                ),
              ),
              heightBox14,
              CustomElevatedButton(
                title: 'Open Account',
                onPressed: () {
                  Get.to(SignInScreen());
                },
              ),
              heightBox12,
              CustomBorderElevatedButton(title: 'Login', onPressed: () {
                Get.to(MainButtonNavbarScreen());
              }),
            ],
          ),
        ),
      ),
    );
  }
}
