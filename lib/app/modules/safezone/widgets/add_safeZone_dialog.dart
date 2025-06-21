import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/costum_elavated_button.dart';
import 'package:glow_street/app/widgets/custom_disable_button.dart';
import 'package:glow_street/app/widgets/toggle_button.dart';

class AddSafeZoneAlertDialog extends StatefulWidget {
  const AddSafeZoneAlertDialog({super.key});

  @override
  State<AddSafeZoneAlertDialog> createState() => _AddSafeZoneAlertDialogState();
}

class _AddSafeZoneAlertDialogState extends State<AddSafeZoneAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  final _alertTypeController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool isShowNotification = true;

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
        'Plan Your Run',
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
                'Run Description',
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
              Row(
                children: [
                  Icon(Icons.location_on, color: Color(0xff1BC4BD), size: 16),
                  Text(
                    'Start Location',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 133, 132, 132),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(hintText: 'Current Location'),
              ),
              heightBox8,
              Row(
                children: [
                  Icon(Icons.location_on, color: Color(0xff1BC4BD), size: 16),
                  Text(
                    'End Location',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 133, 132, 132),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(hintText: 'Description'),
              ),
              heightBox8,
              Row(
                children: [
                  Icon(Icons.location_on, color: Color(0xff1BC4BD), size: 16),
                  Text(
                    'Expected Return',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 133, 132, 132),
                    ),
                  ),
                ],
              ),
              heightBox5,
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(hintText: 'Description'),
              ),
              heightBox8,
              Row(
                children: [
                  ToggleButton(
                    isToggled: isShowNotification,
                    onToggle: (bool value) {
                      setState(() {
                        isShowNotification = value;
                      });
                      if (isShowNotification) {
                        print("Notification is ON");
                      } else {
                        print("Notification is OFF");
                      }
                    },
                  ),
                  widthBox8,
                  Text(
                    'Notify my contacts if late',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 3, 3, 3),
                    ),
                  ),
                ],
                
              ),

              heightBox20,
              CustomElevatedButton(title: 'Save Change', onPressed: () {}),
              heightBox8,
              CustomDisableElevatedButton(title: 'Cancel'),
            ],
          ),
        ),
      ),
    );
  }
}
