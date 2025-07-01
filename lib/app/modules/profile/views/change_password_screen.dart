import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glow_street/app/modules/authentication/views/sign_in_screen.dart';
import 'package:glow_street/app/modules/authentication/widgets/custom_arrow_widget.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/costom_app_bar.dart';
import 'package:glow_street/app/widgets/costum_elavated_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _obscureText = true;
  bool _obscureText2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox30,
              CustomAppBar(name: 'Change Password'),
              heightBox16,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heightBox50,
                  Center(
                    child: CircleAvatar(
                      radius: 54.r,
                      backgroundColor: Color(0xff6C69FF),
                      child: Icon(
                        Icons.lock,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                  heightBox50,
                  Text(
                    'Password',
                    style: TextStyle(fontSize: 14),
                  ),
                  heightBox5,
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
                        onPressed: () =>
                            setState(() => _obscureText = !_obscureText),
                      ),
                      hintText: 'Enter old password',
                    ),
                  ),
                  heightBox12,
                  Text(
                    'New Password',
                    style: TextStyle(fontSize: 14),
                  ),
                  heightBox5,
                  TextFormField(
                    obscureText: _obscureText2,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter your old password';
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
                        onPressed: () =>
                            setState(() => _obscureText2 = !_obscureText2),
                      ),
                      hintText: 'Enter new password',
                    ),
                  ),
                  heightBox12,
                  CustomElevatedButton(
                    title: 'Save Change',
                    onPressed: () {
                      Get.to(SignInScreen());
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
