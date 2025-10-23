import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_street/app/utils/assets_path.dart';

class ProfileImageWidget extends StatelessWidget {
  final double radius;
  final File? image;
  final String imagePath;

  const ProfileImageWidget({
    super.key,
    this.image,
    required this.imagePath,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    if (image != null) {
      // Display the locally selected image
      return Image.file(
        image!,
        width: radius.h,
        height: radius.h,
        fit: BoxFit.cover,
      );
    } else if (imagePath.isNotEmpty) {
      // Display the network image if available
      return Image.network(
        imagePath,
        width: radius.h,
        height: radius.h,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          // Fallback to default image if network image fails
          return Image.asset(
            AssetsPath.city,
            width: radius.h,
            height: radius.h,
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      // Display default image if no image is selected or available
      return Image.asset(
        AssetsPath.city,
        width: radius.h,
        height: radius.h,
        fit: BoxFit.cover,
      );
    }
  }
}
