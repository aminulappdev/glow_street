// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_street/app/modules/community/widgets/post_alert_dialog_widget.dart';
import 'package:glow_street/app/utils/assets_path.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/costom_app_bar.dart';
import 'package:glow_street/app/widgets/costum_elavated_button.dart';


class AlertDetailsScreen extends StatefulWidget {
  const AlertDetailsScreen({super.key});

  @override
  State<AlertDetailsScreen> createState() => _AlertDetailsScreenState();
}

class _AlertDetailsScreenState extends State<AlertDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              heightBox30,
              CustomAppBar(name: 'Alert Details'),
              heightBox20,
              Card(
                color: Colors.white,
                elevation: 1,
                child: Container(
                  height: 350.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 25,
                              width: 125,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: Color(0xffEF4444).withOpacity(0.1),
                              ),

                              child: Center(
                                child: Text(
                                  'Suspicious Activity',
                                  style: TextStyle(
                                    color: Color(0xffDC2626),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              ' 5 min ago',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        heightBox8,
                        Row(
                          children: [
                            CircleAvatar(radius: 14.r),
                            widthBox12,
                            Text(
                              'John Doe',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        heightBox8,
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Color(0xffDC2626)),
                            widthBox8,
                            Text(
                              'New York, USA',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        heightBox8,
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: Color(0xffF3F4F6),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '"I saw a person loitering near the park entrance, looking into parked cars."',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        heightBox12,
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 112.h,

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  image: DecorationImage(
                                    image: AssetImage(AssetsPath.city),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            widthBox8,
                            Expanded(
                              child: Container(
                                height: 112.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  image: DecorationImage(
                                    image: AssetImage(AssetsPath.city2),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        heightBox12,
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: Color(0xffECECFF),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              children: [
                                widthBox8,
                                Icon(
                                  Icons.location_on,
                                  color: Color(0xff0501FF),
                                ),
                                widthBox8,
                                Text(
                                  'Map showing alert location',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff0501FF),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              heightBox12,
              CustomElevatedButton(
                title: '+ Post Community Alert',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const CommunityAlertDialog(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

