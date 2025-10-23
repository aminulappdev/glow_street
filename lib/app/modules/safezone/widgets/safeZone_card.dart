import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_street/app/modules/safezone/model/safeZone_model.dart';
import 'package:glow_street/app/modules/safezone/widgets/edit_safeZone_dialog.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/delete_alert_dialog.dart';

class SafeZoneCard extends StatelessWidget {
  final SafeZoneItemModel safeZoneItemModel;
  final String title;
  final String status;
  final Widget statusButton;
  final DateTime date;
  const SafeZoneCard({
    super.key,
    required this.title,
    required this.status,
    required this.statusButton,
    required this.date,
    required this.safeZoneItemModel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1,
      child: Container(
        // height: 130.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SafeZone: $title',
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
                          status,
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
                    'Expected return: 6:00 PM',
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
                    status == 'onGoing'
                        ? ' Missed check-in: No'
                        : ' Missed check-in: Yes',
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  statusButton,
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => EditSafeZoneAlertDialog(
                              safeZoneItemModel: safeZoneItemModel,
                            ),
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
                            builder: (context) => DeleteSafeZoneAlertDialog(
                              safeZoneItemModel: safeZoneItemModel,
                            ),
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
            ],
          ),
        ),
      ),
    );
  }
}
