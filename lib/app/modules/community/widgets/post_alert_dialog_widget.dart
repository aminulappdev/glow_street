import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/costum_elavated_button.dart';
import 'package:glow_street/app/widgets/custom_disable_button.dart';

class CommunityAlertDialog extends StatefulWidget {
  const CommunityAlertDialog({super.key});

  @override
  State<CommunityAlertDialog> createState() => _CommunityAlertDialogState();
}

 class _CommunityAlertDialogState extends State<CommunityAlertDialog> {
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

      title: const Text(
        'Post Community Alert',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Alert Type',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 133, 132, 132),
                ),
              ),
              TextFormField(
                controller: _alertTypeController,
                decoration: const InputDecoration(
                  hintText: 'Suspicious Activity',
                ),
              ),
              heightBox8,
              Text(
                'Start Location',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 133, 132, 132),
                ),
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(hintText: 'Current Location'),
              ),
              heightBox8,
              Text(
                'Description',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 133, 132, 132),
                ),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(hintText: 'Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              Text(
                'Attach Media',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              heightBox4,
              Container(
                height: 42.h,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Color(0xff60A5FA).withOpacity(0.3),
                ),
                child: Center(
                  child: Text(
                    '+ Upload photos',
                    style: TextStyle(
                      color: Color(0xff1D4ED8),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              heightBox20,
              CustomElevatedButton(title: 'Upload', onPressed: () {}),
              heightBox8,
              CustomDisableElevatedButton(title: 'Cancel'),
            ],
          ),
        ),
      ),
    );
  }
}
