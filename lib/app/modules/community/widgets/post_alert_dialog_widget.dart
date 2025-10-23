// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glow_street/app/modules/community/controllers/add_alert_post_controller.dart';
import 'package:glow_street/app/modules/community/controllers/all_alert_post_controller.dart';
import 'package:glow_street/app/modules/community/widgets/location_services.dart';
import 'package:glow_street/app/widgets/costum_elavated_button.dart';
import 'package:glow_street/app/widgets/show_snackBar_message.dart';
import 'package:latlong2/latlong.dart';
import 'package:image_picker/image_picker.dart';

class CommunityAlertDialog extends StatefulWidget {
  const CommunityAlertDialog({super.key});

  @override
  State<CommunityAlertDialog> createState() => _CommunityAlertDialogState();
}

class _CommunityAlertDialogState extends State<CommunityAlertDialog> {
  final CreateAlertPostController createAlertPostController =
      CreateAlertPostController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _alertTypeController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  LatLng? selectedLocation;
  double? latitude;
  double? longitude;
  final LocationService _locationService = LocationService();
  List<File> selectedImages = []; // List to store selected images

  @override
  void dispose() {
    _alertTypeController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Method to show location picker
  Future<void> _pickLocation() async {
    LatLng? initialPosition =
        await _locationService.getCurrentLocation(context);
    if (initialPosition == null) return;

    final LatLng? pickedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPickerScreen(
          initialPosition: initialPosition,
        ),
      ),
    );

    if (pickedLocation != null && mounted) {
      String locationName =
          await _locationService.getPlaceName(context, pickedLocation);
      setState(() {
        selectedLocation = pickedLocation;
        latitude = pickedLocation.latitude;
        longitude = pickedLocation.longitude;
        _locationController.text = locationName;
        print('Picked Location: Lat: $latitude, Lng: $longitude');
      });
    }
  }

  // Method to pick multiple images
  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> pickedImages = await picker.pickMultiImage();
    if (pickedImages.isNotEmpty) {
      setState(() {
        selectedImages.addAll(pickedImages.map((xfile) => File(xfile.path)));
      });
    }
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
              // Alert Type Input
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an alert type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.h),
              // Location Input
              Text(
                'Start Location',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 133, 132, 132),
                ),
              ),
              GestureDetector(
                onTap: _pickLocation,
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      hintText: 'Tap to select location',
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value == 'Unknown Location' ||
                          latitude == null ||
                          longitude == null) {
                        return 'Please select a valid location';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              // Description Input
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              // Attach Media Section
              Text(
                'Attach Media',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              SizedBox(height: 4.h),
              // Display selected images
              selectedImages.isNotEmpty
                  ? SizedBox(
                      height: 100.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedImages.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                width: 100.w,
                                margin: EdgeInsets.only(right: 8.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  image: DecorationImage(
                                    image: FileImage(selectedImages[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 4.h,
                                right: 12.w,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedImages.removeAt(index);
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 16.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  : Container(
                      height: 50.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.grey.withOpacity(0.1),
                        border: Border.all(
                            color: const Color.fromARGB(255, 219, 219, 219)),
                      ),
                      child: Center(
                        child: Text(
                          'No images selected',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 8.h),
              // Upload Photos Button
              GestureDetector(
                onTap: _pickImages,
                child: Container(
                  height: 42.h,
                  width: 150.w,
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
              ),
              SizedBox(height: 20.h),
              // Upload and Cancel Buttons
              CustomElevatedButton(
                isLoading: _isLoading,
                title: 'Upload',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    createAlertPost();
                  }
                },
              ),
              SizedBox(height: 8.h),
              CustomElevatedButton(
                title: 'Cancel',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createAlertPost() async {
    setState(() {
      _isLoading = true; // লোডিং শুরু
    });

    final bool isSuccess = await createAlertPostController.creatAlertPost(
      alertType: _alertTypeController.text.trim(),
      description: _descriptionController.text.trim(),
      latitude: latitude,
      longitude: longitude,
      images: selectedImages,
    );

    setState(() {
      _isLoading = false; // লোডিং শেষ
    });

    if (isSuccess) {
      if (mounted) {
        final AllAlertPostController allController =
            Get.find<AllAlertPostController>();
        await allController.getAllAlertPost();
        // showSnackBarMessage(context, 'Successfully done'); // অপশনাল: সাকসেস মেসেজ
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, createAlertPostController.errorMessage, true);
      }
    }
  }
}
