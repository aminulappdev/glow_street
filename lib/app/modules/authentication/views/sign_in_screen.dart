import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glow_street/app/modules/authentication/views/forgot_password_screen.dart';
import 'package:glow_street/app/modules/authentication/views/sign_up_screen.dart';
import 'package:glow_street/app/modules/authentication/widgets/custom_arrow_widget.dart';
import 'package:glow_street/app/modules/common/views/main_navigation_bar.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/costum_elavated_button.dart';
import 'package:glow_street/app/widgets/custom_disable_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightBox30,
            CustomArrowWidget(),
            heightBox16,
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login to Your Account',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  heightBox8,
                  SizedBox(
                    width: 300.w,
                    child: Text(
                      'It is quick and easy to log in. Enter your email and password below.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  heightBox12,
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter your email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: 'Email Address'),
                  ),
                  heightBox12,
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter your password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed:
                            () => setState(() => _obscureText = !_obscureText),
                      ),
                      hintText: '********',
                    ),
                  ),
                  heightBox8,
                  GestureDetector(
                    onTap: () {
                      Get.to(ForgotPasswordScreen());
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Color(0xff1F93FF), fontSize: 12),
                    ),
                  ),
                  heightBox12,
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(SignUpScreen());
                      },
                      child: Text(
                        'I don’t have an account',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ),
                  heightBox16,
                  CustomElevatedButton(title: 'Login', onPressed: () {
                    Get.to(MainButtonNavbarScreen());
                  },),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
