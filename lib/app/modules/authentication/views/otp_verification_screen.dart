import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glow_street/app/modules/authentication/views/reset_password_screen.dart';
import 'package:glow_street/app/modules/authentication/widgets/custom_arrow_widget.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/costum_elavated_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
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
                    'OTP Verification',
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
                      'Enter 6-digit Code',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  heightBox8,
                  SizedBox(
                    width: 300.w,
                    child: Text(
                      'Your code was sent to +1111499350',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),

                  heightBox12,
                  PinCodeTextField(
                    length: 6,
                    obscureText: false,

                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    animationDuration: Duration(milliseconds: 300),
                    onChanged: (value) {},
                    pinTheme: PinTheme(
                      selectedColor: Colors.black,
                      activeColor: Colors.blue,
                      borderWidth: 0.5,

                      borderRadius: BorderRadius.circular(100.r),
                      inactiveColor: Colors.grey,
                      fieldHeight: 50.h,
                      fieldWidth: 50.h,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.transparent,
                      selectedFillColor: Colors.white,
                    ),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    appContext: context,
                  ),
                  heightBox16,
                  CustomElevatedButton(title: 'Verify', onPressed: () {
                    Get.to(ResetPasswordScreen());
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
