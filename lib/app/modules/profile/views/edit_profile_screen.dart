import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_street/app/utils/assets_path.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/costom_app_bar.dart';
import 'package:glow_street/app/widgets/costum_elavated_button.dart';
import 'package:glow_street/app/widgets/custom_disable_button.dart';
import 'package:glow_street/app/widgets/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _alertTypeController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();
  File? image;

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
                          CircleAvatar(
                            radius: 38.r,
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
                      controller: _alertTypeController,
                      decoration: const InputDecoration(hintText: 'Enter Name'),
                    ),
                    heightBox8,
                    Text(
                      'Relation',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 133, 132, 132),
                      ),
                    ),
                    heightBox4,
                    TextFormField(
                      controller: _locationController,
                      decoration:
                          const InputDecoration(hintText: 'Enter relation'),
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
                      controller: _descriptionController,
                      decoration: const InputDecoration(hintText: 'Number'),
                    ),
                    heightBox20,
                    CustomElevatedButton(title: 'Save Changes' , onPressed: () {}),
                  
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
