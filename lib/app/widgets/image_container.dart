
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glow_street/app/widgets/photo_viewer.dart';

class ImageContainer extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final double borderRadius;
  const ImageContainer({
    super.key,
    required this.image,
    required this.height,
    required this.width,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
         Get.to(() => FullScreenImageViewer(imageUrl: image));
      },
      child: Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(borderRadius.r),
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
