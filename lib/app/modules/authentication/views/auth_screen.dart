import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glow_street/app/modules/authentication/views/sign_in_screen.dart';
import 'package:glow_street/app/modules/authentication/views/sign_up_screen.dart';
import 'package:glow_street/app/utils/assets_path.dart';
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AssetsPath.bg))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightBox50,
                Container(
                  height: 60,
                  width: 120,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            AssetsPath.appLogoPng,
                          ),
                          fit: BoxFit.fill)),
                ),
                SizedBox(height: 350.h),
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
                    Get.to(SignUpScreen());
                  },
                ),
                heightBox12,
                CustomBorderElevatedButton(
                    title: 'Login',
                    onPressed: () {
                      Get.to(SignInScreen());
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
