import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glow_street/app/modules/community/model/alert_post_model.dart';
import 'package:glow_street/app/modules/community/views/alert_details_screen.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/date_formatter.dart';

class AlertPostCard extends StatelessWidget {
  final AlertPostItemModel alertPostItem;
  final Future<String> Function(double lat, double lng) getAddress;

  const AlertPostCard({
    super.key,
    required this.alertPostItem,
    required this.getAddress,
  });

  @override
  Widget build(BuildContext context) {
    double lat = alertPostItem.location?.coordinates[0] ?? 0.0;
    double lng = alertPostItem.location?.coordinates[1] ?? 0.0;
    DateFormatter dateFormatter = DateFormatter(alertPostItem.createdAt!);
    

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 0.4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(
                        alertPostItem.user?.profile ?? '',
                      ),
                    ),
                    widthBox8,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          alertPostItem.user?.name ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          alertPostItem.user?.status ?? '',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Get.to(AlertDetailsScreen(
                      
                      alertPostItemModel: alertPostItem,
                    ));
                  },
                  child: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xff0501FF),
                        width: 1.5,
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
            heightBox12,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.dangerous,
                      color: Color(0xffDC2626),
                    ),
                    widthBox4,
                    Text(
                      alertPostItem.alertType ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffDC2626),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.schedule, color: Colors.grey, size: 18),
                    widthBox4,
                    Text(
                      dateFormatter.getRelativeTimeFormat(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            heightBox4,
            FutureBuilder<String>(
              future: getAddress(lat, lng),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey),
                      widthBox4,
                      SizedBox(
                        width: 200.w,
                        child: Text(
                          'Loading location...',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.grey),
                    widthBox4,
                    Expanded(
                      child: Text(
                        snapshot.data ?? 'Unknown Location',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}