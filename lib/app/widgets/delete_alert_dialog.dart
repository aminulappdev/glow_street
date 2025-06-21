import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/costum_elavated_button.dart';
import 'package:glow_street/app/widgets/custom_disable_button.dart';

class DeleteAlertDialog extends StatefulWidget {
  const DeleteAlertDialog({super.key});

  @override
  State<DeleteAlertDialog> createState() => _DeleteAlertDialogState();
}

class _DeleteAlertDialogState extends State<DeleteAlertDialog> {
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
                child: Icon(Icons.delete, color: Colors.white, size: 36.r),
              ),
              heightBox8,
              Text(
                'Delete SafeZone?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              heightBox16,
              Text(
                'Are you sure you want to delete this item? This action cannot be undone.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 133, 132, 132),
                ),
              ),

              heightBox20,
              CustomElevatedButton(
                title: 'Delete',
                onPressed: () {},
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
