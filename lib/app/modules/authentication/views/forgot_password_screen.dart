import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glow_street/app/modules/authentication/views/otp_verification_screen.dart';
import 'package:glow_street/app/modules/authentication/widgets/custom_arrow_widget.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/costum_elavated_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

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
                    'Forget Password',
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
                      'We’ll send a verification code to your mail ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  
                  heightBox12,
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter your email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: 'Enter your email'),
                  ),       
                  heightBox16,
                  CustomElevatedButton(title: 'Send Verification Code', onPressed: () {
                    Get.to(OtpVerificationScreen());
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
