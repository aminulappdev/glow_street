import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
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

  Future<String> getAddress(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lng, lat);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address = '${place.street ?? ''}, '
            '${place.administrativeArea ?? ''}, '
            '${place.country ?? ''}';
        return address.trim().isEmpty ? 'Unknown Location' : address.trim();
      }
    } catch (e) {
      print('Error getting address: $e');
    }
    return 'Unknown Location';
  }

  @override
  Widget build(BuildContext context) {
    var lat = safeZoneItemModel.endLocation?.coordinates[0] ?? 0.0;
    var lng = safeZoneItemModel.endLocation?.coordinates[1] ?? 0.0;

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
                  FutureBuilder<String>(
                    future: getAddress(lat, lng),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          width: 200.w,
                          child: Text(
                            'Loading location...',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          'SafeZone: ${snapshot.data ?? 'Unknown Location'}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
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
