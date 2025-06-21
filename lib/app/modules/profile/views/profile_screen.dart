import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_street/app/utils/assets_path.dart';
import 'package:glow_street/app/utils/responsive_size.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            heightBox30,
            Card(
              elevation: 1,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Contact info
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 18.r,
                          backgroundImage: AssetImage(AssetsPath.city),
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Md Aminul Islam',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Md Aminul',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Edit and delete icons
                    Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.edit,
                            size: 20.sp,
                            color: const Color(0xff1A5EED),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.delete,
                            size: 20.sp,
                            color: const Color(0xffDC143C),
                          ),
                        ),
                      ],
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
}
