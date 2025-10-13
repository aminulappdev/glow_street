import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glow_street/app/modules/profile/views/profile_screen.dart'; // Adjust path as needed
import 'package:glow_street/app/utils/responsive_size.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAnimated = false;
  bool isSentAlert = false;
  Timer? _holdTimer;

  void _startHoldTimer() {
    setState(() {
      isAnimated = true; // Trigger animation
    });
    _holdTimer?.cancel(); // Cancel any existing timer
    _holdTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          isSentAlert = true;
          isAnimated = false; // Revert animation after completion
        });
      }
      print('Done');
    });
  }

  void _cancelHoldTimer() {
    _holdTimer?.cancel();
    if (mounted) {
      setState(() {
        isAnimated = false; // Revert animation if released early
      });
    }
  }

  @override
  void dispose() {
    _holdTimer?.cancel(); // Directly cancel timer without calling setState
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
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
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const ProfileScreen());
                      },
                      child: CircleAvatar(radius: 14.r),
                    ),
                  ],
                ),
                heightBox30,
                isSentAlert == false
                    ? Container(
                        height: 37.h,
                        width: 238.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xffF4F4F4),
                          border: Border.all(color: const Color(0xffE6E6E6)),
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
                      )
                    : Container(
                        height: 76.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          border: Border.all(
                              color: const Color(0xffE6E6E6), width: 0.5),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'status',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  heightBox4,
                                  Container(
                                    height: 27.h,
                                    width: 69.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: const Color(0xffFFECF0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.notifications,
                                          color: Color(0xffDC143C),
                                        ),
                                        Text(
                                          'Alert',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: const Color(0xffDC143C),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'SOS Active',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: const Color(0xffDC143C),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                heightBox12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.call, size: 20),
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
                        padding: EdgeInsets.all(6.w),
                        child: Column(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  height: 48.h,
                                  width: 48.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey,
                                    border: isSentAlert
                                        ? Border.all(
                                            color: const Color(0xff32CD32),
                                            width: 2,
                                          )
                                        : Border.all(
                                            width: 0,
                                            color: Colors.transparent,
                                          ),
                                  ),
                                ),
                                if (isSentAlert)
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: CircleAvatar(
                                      radius: 10.r,
                                      backgroundColor: const Color(0xff32CD32),
                                      child: const Icon(
                                        Icons.check,
                                        size: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
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
                GestureDetector(
                  onLongPressStart: (_) => _startHoldTimer(),
                  onLongPressEnd: (_) => _cancelHoldTimer(),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    transform: isAnimated
                        ? Matrix4.diagonal3Values(1.05, 1.05, 1)
                        : Matrix4.identity(),
                    height: 280.h,
                    width: 280.w,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xffEF4444), Color(0xffEC4899)],
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color.fromARGB(255, 240, 239, 239),
                        width: 12,
                      ),
                      boxShadow: [
                        isSentAlert
                            ? BoxShadow(
                                color: const Color(0xffEF4444).withOpacity(0.5),
                                blurRadius: 30,
                                spreadRadius: 5,
                                offset: const Offset(0, 10),
                              )
                            : BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                spreadRadius: 2,
                                offset: const Offset(0, 10),
                              ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 190.w,
                          child: Text(
                            textAlign: TextAlign.center,
                            'Hold to Send SOS Alert',
                            style:
                                TextStyle(fontSize: 25.sp, color: Colors.white),
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
                ),
                heightBox30,
                isSentAlert == false
                    ? Text(
                        'Press and hold activate emergency alert',
                        style: TextStyle(fontSize: 16.sp),
                      )
                    : Container(
                        height: 42.h,
                        width: 300.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xff32CD32).withOpacity(0.12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.shield, color: Color(0xff32CD32)),
                            Text(
                              'I am Safe - Confirm',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: const Color(0xff32CD32),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
