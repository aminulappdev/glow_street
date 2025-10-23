// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glow_street/app/modules/profile/controllers/edit_profile_controller.dart';
import 'package:glow_street/app/modules/profile/controllers/profile_controller.dart';
import 'package:glow_street/app/modules/profile/model/profile_details_model.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/costom_app_bar.dart';
import 'package:glow_street/app/widgets/costum_elavated_button.dart';
import 'package:glow_street/app/widgets/image_picker.dart';
import 'package:glow_street/app/widgets/image_picker_container.dart';
import 'package:glow_street/app/widgets/show_snackBar_message.dart';

class EditProfileScreen extends StatefulWidget {
  final ProfileData profileData;
  const EditProfileScreen({super.key, required this.profileData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();
  File? image; // Stores the selected image file
  EditProfileController editProfileController = EditProfileController();
  ProfileDetailsController profileDetailsController =
      ProfileDetailsController();
  bool _isLoading = false;
  String imagePath = ''; // Stores the network image URL

  @override
  void initState() {
    _nameController.text = widget.profileData.name ?? '';
    _numberController.text = widget.profileData.phoneNumber ?? '';
    imagePath = widget.profileData.profile ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            heightBox30,
            CustomAppBar(name: 'Edit Profile'),
            heightBox10,
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    heightBox30,
                    Center(
                      child: Stack(
                        children: [
                          // In your EditProfileScreen's build method, replace the _buildProfileImage() call:
                          CircleAvatar(
                            radius: 38.r,
                            child: ClipOval(
                              child: ProfileImageWidget(
                                radius: 36.r,
                                image: image,
                                imagePath: imagePath,
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
                                    image =
                                        pickedImage; // Store the selected image
                                  });
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor:
                                    const Color.fromARGB(255, 0, 0, 0),
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
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 133, 132, 132),
                      ),
                    ),
                    heightBox4,
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(hintText: 'Enter Name'),
                    ),
                    heightBox8,
                    Text(
                      'Phone Number',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 133, 132, 132),
                      ),
                    ),
                    heightBox4,
                    TextFormField(
                      controller: _numberController,
                      decoration: const InputDecoration(hintText: 'Number'),
                    ),
                    heightBox20,
                    CustomElevatedButton(
                      title: 'Save Changes',
                      isLoading: _isLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          editProfile(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to determine which image to display

  Future<void> editProfile(BuildContext context) async {
    setState(() {
      _isLoading = true; // Set loading to true when API call starts
    });

    final bool isSuccess = await editProfileController.editProfile(
      name: _nameController.text.trim(),
      number: _numberController.text.trim(),
      image: image, // Pass the selected image file
    );

    setState(() {
      _isLoading = false; // Set loading to false when API call ends
    });

    if (isSuccess) {
      final ProfileDetailsController profileDetailsController =
          Get.find<ProfileDetailsController>();
      await profileDetailsController.getMyProfile();
      showSnackBarMessage(context, 'Successfully done');
      Navigator.pop(context);
    } else {
      showSnackBarMessage(
        context,
        editProfileController.errorMessage,
        true,
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }
}
