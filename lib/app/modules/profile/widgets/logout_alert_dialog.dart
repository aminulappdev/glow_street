import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glow_street/app/modules/authentication/views/sign_in_screen.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/costum_elavated_button.dart';
import 'package:glow_street/app/widgets/custom_disable_button.dart';
import 'package:glow_street/get_storage.dart';

class LogOutAlertDialog extends StatefulWidget {
  const LogOutAlertDialog({super.key});

  @override
  State<LogOutAlertDialog> createState() => _LogOutAlertDialogState();
}

class _LogOutAlertDialogState extends State<LogOutAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  final _alertTypeController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _alertTypeController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 32.r,
                backgroundColor: Color(0xffFF3356),
                child: Icon(Icons.logout, color: Colors.white, size: 36.r),
              ),
              heightBox16,
              Text(
                'Are you sure you want to log out of your account?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 133, 132, 132),
                ),
              ),
              heightBox20,
              CustomElevatedButton(
                title: 'Confirm Log Out',
                onPressed: () {
                  StorageUtil.deleteData(StorageUtil.userAccessToken);
                  StorageUtil.deleteData(StorageUtil.userRefreshToken);
                  Get.to(() => const SignInScreen());
                },
                isDanger: true,
              ),
              heightBox8,
              CustomDisableElevatedButton(title: 'Cancel'),
            ],
          ),
        ),
      ),
    );
  }
}
