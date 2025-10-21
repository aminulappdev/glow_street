import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glow_street/app/modules/authentication/controllers/reset_password_controller.dart';
import 'package:glow_street/app/modules/authentication/views/sign_in_screen.dart';
import 'package:glow_street/app/modules/authentication/widgets/custom_arrow_widget.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/costum_elavated_button.dart';
import 'package:glow_street/app/widgets/show_snackBar_message.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String otpToken;
  const ResetPasswordScreen({super.key, required this.otpToken});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _obscureText = true;
  bool _obscureText2 = true;

  bool _isLoading = false; // Add loading state

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ResetPasswordController resetPasswordController = ResetPasswordController();

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
                    'Reset Password',
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
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: passwordController,
                          obscureText: _obscureText,
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
                              onPressed: () =>
                                  setState(() => _obscureText = !_obscureText),
                            ),
                            hintText: 'Enter new password',
                          ),
                        ),
                        heightBox12,
                        TextFormField(
                          controller: confirmPasswordController,
                          obscureText: _obscureText2,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter your new password';
                            } else if (value != passwordController.text) {
                              return 'Password does not match';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText2
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () => setState(
                                  () => _obscureText2 = !_obscureText2),
                            ),
                            hintText: 'Enter confirm password',
                          ),
                        ),
                      ],
                    ),
                  ),
                  heightBox8,
                  CustomElevatedButton(
                    title: 'Reset Password',
                    isLoading: _isLoading, // Pass loading state to button
                    onPressed: () => resetPassword(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> resetPassword(BuildContext context) async {
    setState(() {
      _isLoading = true; // Set loading to true when API call starts
    });

    final bool isSuccess = await resetPasswordController.resetPassword(
      otpToken: widget.otpToken,
      password: passwordController.text.trim(),
    );

    setState(() {
      _isLoading = false; // Set loading to false when API call ends
    });

    if (isSuccess) {
      showSnackBarMessage(context, 'Successfully done');
      Get.to(() => SignInScreen());
    } else {
      showSnackBarMessage(
        context,
        resetPasswordController.errorMessage,
        true,
      );
    }
  }
}
