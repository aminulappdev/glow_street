// image_picker_helper.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  // Function to pick an image from the camera
  Future<void> pickImageFromCamera(BuildContext context, Function(File) onImagePicked) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        onImagePicked(File(pickedImage.path));
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    } finally {
      if (Navigator.canPop(context)) Navigator.pop(context);
    }
  }

  // Function to pick an image from the gallery
  Future<void> pickImageFromGallery(BuildContext context, Function(File) onImagePicked) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        onImagePicked(File(pickedImage.path));
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    } finally {
      if (Navigator.canPop(context)) Navigator.pop(context); // Close the dialog
    }
  }

  // Function to show the image picker dialog
  Future<void> showAlertDialog(BuildContext context, Function(File) onImagePicked) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    pickImageFromCamera(context, onImagePicked);
                  },
                  icon:  Icon(Icons.camera_alt, size: 40.h, color: Color.fromARGB(255, 3, 3, 3)),
                ),
                IconButton(
                  onPressed: () {
                    pickImageFromGallery(context, onImagePicked);
                  },
                  icon:  Icon(Icons.photo_library, size: 40.h, color: Color.fromARGB(255, 2, 2, 2)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}



