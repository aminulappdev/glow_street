
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glow_street/app/modules/contact/controllers/add_contact_controller.dart';
import 'package:glow_street/app/utils/assets_path.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/costum_elavated_button.dart';
import 'package:glow_street/app/widgets/custom_disable_button.dart';
import 'package:glow_street/app/widgets/image_picker.dart';
import 'package:glow_street/app/widgets/show_snackBar_message.dart';
import 'package:glow_street/app/modules/contact/controllers/all_emergency_contact_controller.dart';

class AddContactAlertDialog extends StatefulWidget {
  const AddContactAlertDialog({super.key});

  @override
  State<AddContactAlertDialog> createState() => _AddContactAlertDialogState();
}

class _AddContactAlertDialogState extends State<AddContactAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _relationController = TextEditingController();
  final _numberController = TextEditingController();
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();
  File? image;
  AddContactController addContactController = Get.put(AddContactController());
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _relationController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text(
        'Add Emergency Contact',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 36.r,
                      child: image != null
                          ? ClipOval(
                              child: Image.file(
                                image!,
                                width: 72.h,
                                height: 72.h,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              height: 72,
                              width: 72,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(AssetsPath.city),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          _imagePickerHelper.showAlertDialog(context, (
                            File pickedImage,
                          ) {
                            setState(() {
                              image = pickedImage;
                            });
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                          radius: 14.r,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 16.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Name',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 133, 132, 132),
                ),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Enter your name';
                  }
                  return null;
                },
                controller: _nameController,
                decoration: const InputDecoration(hintText: 'Enter Name'),
              ),
              heightBox8,
              Text(
                'Relation',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 133, 132, 132),
                ),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Enter your relation';
                  }
                  return null;
                },
                controller: _relationController,
                decoration: const InputDecoration(hintText: 'Enter relation'),
              ),
              heightBox8,
              Text(
                'Phone Number',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 133, 132, 132),
                ),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Enter your number';
                  }
                  return null;
                },
                controller: _numberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Number'),
              ),
              heightBox20,
              CustomElevatedButton(
                isLoading: _isLoading,
                title: 'Add',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addEmergencyContact(context);
                  }
                },
              ),
              heightBox8,
              CustomDisableElevatedButton(title: 'Cancel'),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addEmergencyContact(BuildContext context) async {
    setState(() {
      _isLoading = true; // লোডিং শুরু
    });

    final bool isSuccess = await addContactController.addContact(
      name: _nameController.text.trim(),
      relationship: _relationController.text.trim(),
      number: _numberController.text.trim(),
      image: image,
    );

    setState(() {
      _isLoading = false; // লোডিং শেষ
    });

    if (isSuccess) {
      // নতুন চেঞ্জ: AllEmergencyContactController থেকে লেটেস্ট ডেটা ফেচ করো
      final AllEmergencyContactController allController = Get.find<AllEmergencyContactController>();
      await allController.getAllEmergencyContact(); // API কল করে লিস্ট রিফ্রেশ
      // showSnackBarMessage(context, 'Successfully done'); // অপশনাল: সাকসেস মেসেজ
      Navigator.pop(context); // ডায়ালগ ক্লোজ
    } else {
      showSnackBarMessage(
        context,
        addContactController.errorMessage,
        true,
      );
    }
  }
}
