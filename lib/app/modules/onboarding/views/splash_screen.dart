import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glow_street/app/utils/assets_path.dart';
import 'package:glow_street/app/utils/responsive_size.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // _movetoNewScreen();
    super.initState();
  }

  // Future<void> _movetoNewScreen() async {
  //   await Future.delayed(const Duration(seconds: 3));
  //   print('done');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SvgPicture.asset('assets/images/appLogo.svg'),
      ),
    );
  }
}
