import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_street/app/modules/authentication/widgets/custom_arrow_widget.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/costum_elavated_button.dart';
import 'package:glow_street/app/widgets/custom_disable_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscureText = true;
  bool _obscureText2 = true;
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
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter your fisrt name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your fisrt name',
                    ),
                  ),
                  heightBox12,
                  TextFormField(
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter your fisrt name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: 'Number'),
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
                  heightBox12,

                  TextFormField(
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
                        onPressed:
                            () => setState(() => _obscureText = !_obscureText),
                      ),
                      hintText: 'Enter password',
                    ),
                  ),
                  heightBox12,
                  TextFormField(
                    obscureText: _obscureText2,
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
                          _obscureText2
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed:
                            () =>
                                setState(() => _obscureText2 = !_obscureText2),
                      ),
                      hintText: 'Enter confirm password',
                    ),
                  ),
                  heightBox8,

                  heightBox16,
                  CustomElevatedButton(title: 'Create Account', onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
