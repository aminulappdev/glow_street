import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glow_street/app/modules/authentication/views/sign_in_screen.dart';
import 'package:glow_street/app/modules/profile/controllers/change_password_controller.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/costom_app_bar.dart';
import 'package:glow_street/app/widgets/costum_elavated_button.dart';
import 'package:glow_street/app/widgets/show_snackBar_message.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _obscureText = true;
  bool _obscureText2 = true;
  bool _obscureText3 = true;
  bool _isLoading = false;
  ChangePasswordController changePasswordController =
      Get.put(ChangePasswordController());
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
                    'Old Password',
                    style: TextStyle(fontSize: 14),
                  ),
                  heightBox5,
                  TextFormField(
                    controller: oldPasswordController,
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
                    controller: passwordController,
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
                  Text(
                    'Confirm Password',
                    style: TextStyle(fontSize: 14),
                  ),
                  heightBox5,
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: _obscureText3,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter your confirm password';
                      } else if (value != passwordController.text) {
                        return 'Password does not match';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText3
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () =>
                            setState(() => _obscureText3 = !_obscureText3),
                      ),
                      hintText: 'Enter confirm password',
                    ),
                  ),
                  heightBox12,
                  CustomElevatedButton(
                    isLoading: _isLoading,
                    title: 'Change Password',
                    onPressed: () =>
                        changePassword(context, changePasswordController),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> changePassword(
      BuildContext context, dynamic resetPasswordController) async {
    setState(() {
      _isLoading = true;
    });

    final bool isSuccess = await changePasswordController.changePassword(
      oldPassword: oldPasswordController.text.trim(),
      password: passwordController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (isSuccess) {
      showSnackBarMessage(context, 'Successfully done');
      Navigator.pop(context);
    } else {
      showSnackBarMessage(
        context,
        resetPasswordController.errorMessage,
        true,
      );
    }
  }
}
