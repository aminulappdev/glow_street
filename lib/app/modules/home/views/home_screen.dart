import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            heightBox30,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hi Eleanor Pena 👋',
                  style: GoogleFonts.kumbhSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CircleAvatar(radius: 14.r),
              ],
            ),
            heightBox30,
            Container(
              height: 37.h,
              width: 238.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xffF4F4F4),
                border: Border.all(color: Color(0xffE6E6E6)),
              ),
              child: Center(
                child: Text(
                  'Press volume up to activate SOS',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            heightBox12,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.call, size: 20),
                widthBox4,
                Text(
                  'Emergency Contacts Status',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            heightBox12,
            SizedBox(
              height: 120.h,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        CircleAvatar(radius: 23.r),
                        heightBox5,
                        Text(
                          'Father',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            heightBox12,
            Container(
              height: 280.h,
              width: 280.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xffEF4444), Color(0xffEC4899)],
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color.fromARGB(255, 240, 239, 239),
                  width: 12,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Shadow color
                    blurRadius: 20, // How soft the shadow is
                    spreadRadius: 2, // How wide the shadow spreads
                    offset: Offset(0, 10), // Position of the shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200.h,
                    child: Text(
                      textAlign: TextAlign.center,
                      'Hold to Send SOS Alert',
                      style: TextStyle(fontSize: 25.sp, color: Colors.white),
                    ),
                  ),

                  Text(
                    'EMERGENCY',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            heightBox30,
            Text(
              'Press and hold activate emergency alert',
              style: TextStyle(fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }
}
