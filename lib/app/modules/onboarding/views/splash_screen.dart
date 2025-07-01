import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glow_street/app/modules/authentication/views/auth_screen.dart';
import 'package:glow_street/app/utils/assets_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _movetoNewScreen();
    super.initState();
  }

  Future<void> _movetoNewScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.to(AuthScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Container(
              height: 150,
              width: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        AssetsPath.appLogoPng,
                      ),
                      fit: BoxFit.fill)),
            ),
          )),
    );
  }
}
