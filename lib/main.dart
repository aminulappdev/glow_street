import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glow_street/app/modules/authentication/views/auth_screen.dart';
import 'package:glow_street/app/modules/common/views/main_navigation_bar.dart';
import 'package:glow_street/app/modules/onboarding/views/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await GetStorage.init();
  // await Firebase.initializeApp();
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
          // initialBinding: ControllerBinder(),
          debugShowCheckedModeBanner: false,
          title: 'glow-street',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            // ignore: deprecated_member_use
            inputDecorationTheme: inputDecoration(),
            useMaterial3: true,
            fontFamily: 'Poppins',
            textTheme: TextTheme(),
          ),
          home: SplashScreen(),
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
    borderSide: BorderSide(color: const Color(0xffCACACA), width: 1),
    borderRadius: BorderRadius.circular(10),
  );
}
