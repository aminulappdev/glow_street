import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glow_street/app/modules/onboarding/views/splash_screen.dart';
import 'package:glow_street/app_binding.dart';

const platform = MethodChannel('glow_street/volume'); // ✅ Channel name (must match Kotlin side)

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔔 Native থেকে আসা কল হ্যান্ডেল করা
  platform.setMethodCallHandler((call) async {
    if (call.method == 'volumeBtnPressed') {
      if (call.arguments == 'volume_up') {
        print('Hello, I am working');
      } else if (call.arguments == 'volume_down') {
        print('Volume down pressed');
      }
    }
  });

  runApp(const GlowStreet());
}

class GlowStreet extends StatelessWidget {
  const GlowStreet({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: ControllerBinder(),
          title: 'glow-street',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            inputDecorationTheme: inputDecoration(),
            useMaterial3: true,
            fontFamily: 'Poppins',
            textTheme: const TextTheme(),
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}

InputDecorationTheme inputDecoration() {
  return InputDecorationTheme(
    hintStyle: const TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
    fillColor: Colors.transparent,
    filled: true,
    border: inputBorder(),
    enabledBorder: inputBorder(),
    focusedBorder: inputBorder(),
    errorBorder: inputBorder(),
    contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 12),
  );
}

OutlineInputBorder inputBorder() {
  return OutlineInputBorder(
    borderSide: const BorderSide(color: Color(0xffCACACA), width: 1),
    borderRadius: BorderRadius.circular(10),
  );
}
