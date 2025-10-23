// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glow_street/app/modules/contact/controllers/all_emergency_contact_controller.dart';
import 'package:glow_street/app/modules/contact/controllers/edit_contact_controller.dart';
import 'package:glow_street/app/modules/contact/model/emergency_contact_model.dart';
import 'package:glow_street/app/utils/assets_path.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/costum_elavated_button.dart';
import 'package:glow_street/app/widgets/custom_disable_button.dart';
import 'package:glow_street/app/widgets/image_picker.dart';
import 'package:glow_street/app/widgets/show_snackBar_message.dart'; 

class EditContactAlertDialog extends StatefulWidget {
  final EmergencyContactItemModel emergencyContactItemModel;
  const EditContactAlertDialog(
      {super.key, required this.emergencyContactItemModel});

  @override
  State<EditContactAlertDialog> createState() => _EditContactAlertDialogState();
}

class _EditContactAlertDialogState extends State<EditContactAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _relationController = TextEditingController();
  final _numberController = TextEditingController();
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();
  File? image;
  String imagePath = '';
  bool _isLoading = false;
  EditContactController editContactController = EditContactController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.emergencyContactItemModel.name ?? '';
    _relationController.text = widget.emergencyContactItemModel.relation ?? '';
    _numberController.text = widget.emergencyContactItemModel.phoneNumber ?? '';
    imagePath = widget.emergencyContactItemModel.profile ?? '';
  }

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
                        child: ClipOval(child: _buildProfileImage())),
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
                controller: _numberController,
                decoration: const InputDecoration(hintText: 'Number'),
              ),
              heightBox20,
              CustomElevatedButton(
                title: 'Update',
                isLoading: _isLoading,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    editContact(context);
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

  Widget _buildProfileImage() {
    if (image != null) {
      // Display the locally selected image
      return Image.file(
        image!,
        width: 72.h,
        height: 72.h,
        fit: BoxFit.cover,
      );
    } else if (imagePath.isNotEmpty) {
      // Display the network image if available
      return Image.network(
        imagePath,
        width: 72.h,
        height: 72.h,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          // Fallback to default image if network image fails
          return Image.asset(
            AssetsPath.city,
            width: 72.h,
            height: 72.h,
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      // Display default image if no image is selected or available
      return Image.asset(
        AssetsPath.city,
        width: 72.h,
        height: 72.h,
        fit: BoxFit.cover,
      );
    }
  }

  Future<void> editContact(BuildContext context) async {
    setState(() {
      _isLoading = true; // Set loading to true when API call starts
    });

    final bool isSuccess = await editContactController.editContact(
      id: widget.emergencyContactItemModel.id,
      name: _nameController.text.trim(),
      number: _numberController.text.trim(),
      relationship: _relationController.text.trim(),
      image: image, // Pass the selected image file
    );

    setState(() {
      _isLoading = false; // Set loading to false when API call ends
    });

    if (isSuccess) {
      final AllEmergencyContactController allController =
          Get.find<AllEmergencyContactController>();
      await allController.getAllEmergencyContact();
      showSnackBarMessage(context, 'Successfully done');
      Navigator.pop(context);
    } else {
      showSnackBarMessage(
        context,
        editContactController.errorMessage,
        true,
      );
    }
  }
}
