import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomArrowWidget extends StatelessWidget {
  const CustomArrowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: GestureDetector(onTap: () {
            Navigator.pop(context);
          }, child: Icon(Icons.arrow_back)),
        ),

        Container(height: 0.5.h, color: Colors.grey),
      ],
    );
  }
}
