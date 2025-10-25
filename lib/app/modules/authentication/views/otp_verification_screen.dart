import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glow_street/app/modules/authentication/controllers/otp_verify_controller.dart';
import 'package:glow_street/app/modules/authentication/controllers/forgot_password_controller.dart'; // Import ForgotPasswordController
import 'package:glow_street/app/modules/authentication/views/reset_password_screen.dart';
import 'package:glow_street/app/modules/authentication/views/sign_in_screen.dart';
import 'package:glow_street/app/modules/authentication/widgets/custom_arrow_widget.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/costum_elavated_button.dart';
import 'package:glow_street/app/widgets/show_snackBar_message.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'dart:async';

class OtpVerificationScreen extends StatefulWidget {
  final bool fromForgotPassword;
  final String email;
  final String otpToken;
  const OtpVerificationScreen({
    super.key,
    required this.email,
    required this.otpToken,
    required this.fromForgotPassword,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  TextEditingController otpController = TextEditingController();
  final OtpVerifyController otpVerifyController = OtpVerifyController();
  final ForgotPasswordController forgotPasswordController =
      Get.put(ForgotPasswordController());
  bool _isLoading = false;

  // Timer-related variables
  Timer? _timer;
  int _secondsRemaining = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    debugPrint('OTP Token: ${widget.otpToken}');
    _startTimer(); // Start the countdown timer when the screen loads
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer to prevent memory leaks
    otpController.dispose();
    super.dispose();
  }

  // Start the 60-second countdown timer
  void _startTimer() {
    _canResend = false;
    _secondsRemaining = 60;
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining <= 0) {
        timer.cancel();
        setState(() {
          _canResend = true; // Enable resend button when timer expires
        });
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

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
                      'Your code was sent to ${widget.email}',
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
                    controller: otpController,
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
                  CustomElevatedButton(
                    title: 'Verify',
                    onPressed: _canResend
                        ? null
                        : () => otpVerify(
                            context), // Disable button when timer expires
                    isDanger: false,
                    isLoading: _isLoading,
                  ),
                  heightBox20,
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Did not receive the code?',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey,
                          ),
                        ),
                        _canResend
                            ? TextButton(
                                onPressed: () async => await resendOtp(),
                                child: Text(
                                  'Resend OTP',
                                  style: TextStyle(
                                    color: Color(0xff0501FF),
                                    fontSize: 14.sp,
                                  ),
                                ),
                              )
                            : Text(
                                'Time left: 00:${_secondsRemaining.toString().padLeft(2, '0')}',
                                style: TextStyle(
                                  color: Color(0xff0501FF),
                                  fontSize: 14.sp,
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> otpVerify(BuildContext context) async {
    setState(() {
      _isLoading = true; // Set loading to true when API call starts
    });

    final bool isSuccess = await otpVerifyController.otpVerify(
      otpToken: widget.otpToken,
      otp: otpController.text.trim(),
    );

    setState(() {
      _isLoading = false; // Set loading to false when API call ends
    });

    if (isSuccess) {
      showSnackBarMessage(context, 'Successfully done');
      Get.to(() => widget.fromForgotPassword
          ? ResetPasswordScreen(
              otpToken: otpVerifyController.otpToken,
            )
          : SignInScreen());
    } else {
      showSnackBarMessage(
        context,
        otpVerifyController.errorMessage,
        true,
      );
    }
  }

  Future<void> resendOtp() async {
    try {
      final bool isSuccess = await forgotPasswordController.forgotPassword(
        email: widget.email,
      );

      if (isSuccess) {
        // showSnackBarMessage(context, 'OTP resent successfully');
        otpController.clear(); // Clear the OTP field on resend
        _startTimer(); // Restart the timer after successful resend
      } else {
        showSnackBarMessage(
          context,
          forgotPasswordController.errorMessage,
          true,
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showSnackBarMessage(context, 'An error occurred: $e', true);
    }
  }
}
