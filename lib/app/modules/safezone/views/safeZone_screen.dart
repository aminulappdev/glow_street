import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_street/app/modules/safezone/widgets/add_safeZone_dialog.dart';
import 'package:glow_street/app/modules/safezone/widgets/edit_safeZone_dialog.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/delete_alert_dialog.dart';

class SafezoneScreen extends StatefulWidget {
  const SafezoneScreen({super.key});

  @override
  State<SafezoneScreen> createState() => _SafezoneScreenState();
}

class _SafezoneScreenState extends State<SafezoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightBox30,
            Text(
              'SafeZone History',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            heightBox30,
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AddSafeZoneAlertDialog(),
                );
              },
              child: Container(
                height: 42.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xff1BC4BD).withOpacity(0.05),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Color(0xff1BC4BD)),
                    Text(
                      ' Add New Safezone',
                      style: TextStyle(fontSize: 16, color: Color(0xff1BC4BD)),
                    ),
                  ],
                ),
              ),
            ),
            heightBox12,
            Text(
              'SafeZones List',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            heightBox12,
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Card(
                      color: Colors.white,
                      elevation: 1,
                      child: Container(
                        height: 120.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              heightBox12,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'SafeZone:Home',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Color(0xffDEFFF0),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Completed',
                                          style: TextStyle(
                                            color: Color(0xff12B76A),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                  Text(
                                    ' Last check-in: 6:00 PM',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              heightBox4,
                              Row(
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                  Text(
                                    ' Missed check-in: 6:00 PM',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder:
                                            (context) =>
                                                EditSafeZoneAlertDialog(),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          color: Color(0xff1A5EED),
                                          size: 16,
                                        ),
                                        Text(
                                          ' Edit',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff1A5EED),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  widthBox5,
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder:
                                            (context) => DeleteAlertDialog(),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          color: Color(0xffDC143C),
                                          size: 16,
                                        ),
                                        Text(
                                          ' Remove',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffDC143C),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
