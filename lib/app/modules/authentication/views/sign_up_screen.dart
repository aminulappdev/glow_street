// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glow_street/app/modules/authentication/controllers/sign_up_controller.dart';
import 'package:glow_street/app/modules/authentication/views/otp_verification_screen.dart';
import 'package:glow_street/app/modules/authentication/views/sign_in_screen.dart';
import 'package:glow_street/app/modules/authentication/widgets/custom_arrow_widget.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/costum_elavated_button.dart';
import 'package:glow_street/app/widgets/show_snackBar_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscureText = true;
  bool _obscureText2 = true;
  bool _isLoading = false; // Add loading state

  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SignUpController signUpController = SignUpController();

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
                    'Create Your Account',
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
                      'It is quick and easy to create you account',
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter your first name';
                            }
                            return null;
                          },
                          controller: firstNameController,
                          decoration: InputDecoration(
                            hintText: 'Enter your first name',
                          ),
                        ),
                        heightBox12,
                        TextFormField(
                          controller: lastNameController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter your last name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter your last name',
                          ),
                        ),
                        heightBox12,
                        TextFormField(
                          controller:
                              numberController, // Fixed: Use numberController
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter your number';
                            }
                            return null;
                          },
                          decoration: InputDecoration(hintText: 'Number'),
                        ),
                        heightBox12,
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter your email';
                            }
                            return null;
                          },
                          decoration:
                              InputDecoration(hintText: 'Enter your email'),
                        ),
                        heightBox12,
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
                            hintText: 'Enter password',
                          ),
                        ),
                        heightBox12,
                        TextFormField(
                          controller: confirmPasswordController,
                          obscureText: _obscureText2,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter your confirm password';
                            }
                            if (value != passwordController.text) {
                              return 'Passwords do not match';
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
                  heightBox16,
                  CustomElevatedButton(
                    title: "Submit",
                    isLoading: _isLoading, // Pass the loading state
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        signUpFunction(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signUpFunction(BuildContext context) async {
    setState(() {
      _isLoading = true; // Set loading to true when API call starts
    });

    final bool isSuccess = await signUpController.signUp(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: emailController.text.trim(),
      number: numberController.text.trim(),
      password: passwordController.text.trim(),
    );

    setState(() {
      _isLoading = false; // Set loading to false when API call ends
    });

    if (isSuccess) {
      showSnackBarMessage(context, 'Successfully done');
      Get.to(() => OtpVerificationScreen(
            fromForgotPassword: false,
            otpToken: signUpController.otpToken,
            email: emailController.text,
          ));
    } else {
      showSnackBarMessage(
        context,
        signUpController.errorMessage,
        true,
      );
    }
  }
}
