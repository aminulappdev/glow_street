// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:glow_street/app/modules/community/model/alert_post_model.dart';
import 'package:glow_street/app/modules/community/widgets/location_services.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/costom_app_bar.dart';
import 'package:glow_street/app/widgets/date_formatter.dart';
import 'package:glow_street/app/widgets/image_container.dart';
import 'package:latlong2/latlong.dart';

// Alert Details Screen
class AlertDetailsScreen extends StatefulWidget {
  final AlertPostItemModel alertPostItemModel;

  const AlertDetailsScreen({
    super.key,
    required this.alertPostItemModel,
  });

  @override
  State<AlertDetailsScreen> createState() => _AlertDetailsScreenState();
}

class _AlertDetailsScreenState extends State<AlertDetailsScreen> {
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
    final LatLng? alertLocation =
        widget.alertPostItemModel.location?.coordinates != null &&
                widget.alertPostItemModel.location!.coordinates.length >= 2
            ? LatLng(
                widget.alertPostItemModel.location!.coordinates[1], // latitude
                widget.alertPostItemModel.location!.coordinates[0], // longitude
              )
            : null;

    DateFormatter dateFormatter =
        DateFormatter(widget.alertPostItemModel.createdAt!);

    var lat = widget.alertPostItemModel.location?.coordinates[0] ?? 0.0;
    var lng = widget.alertPostItemModel.location?.coordinates[1] ?? 0.0;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 30.h),
              CustomAppBar(name: 'Alert Details'),
              SizedBox(height: 20.h),
              Card(
                color: Colors.white,
                elevation: 1,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 25.h,
                              width: 125.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: Color(0xffEF4444).withOpacity(0.1),
                              ),
                              child: Center(
                                child: Text(
                                  widget.alertPostItemModel.alertType ?? '',
                                  style: TextStyle(
                                    color: Color(0xffDC2626),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              dateFormatter.getRelativeTimeFormat(),
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            CircleAvatar(radius: 14.r),
                            SizedBox(width: 12.w),
                            Text(
                              widget.alertPostItemModel.user?.name ?? '',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        // Location Display Section
                        FutureBuilder<String>(
                          future: getAddress(lat, lng),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
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
                        SizedBox(height: 8.h),
                        // Map Preview Section

                        SizedBox(height: 12.h),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: Color(0xffF3F4F6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.alertPostItemModel.description ?? '',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        // Clickable Map Showing Alert Location
                        GestureDetector(
                          onTap: alertLocation != null
                              ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          LocationPickerScreen(
                                        showConfirmButoon: false,
                                        initialPosition: alertLocation,
                                      ),
                                    ),
                                  );
                                }
                              : null,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: Color(0xffECECFF),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Row(
                                children: [
                                  SizedBox(width: 8.w),
                                  Icon(
                                    Icons.location_on,
                                    color: Color(0xff0501FF),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'Map showing alert location',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff0501FF),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) => ImageContainer(
                            height: 250,
                            width: double.infinity,
                            borderRadius: 20,
                            image: widget.alertPostItemModel.images[index],
                          ),
                          itemCount: widget.alertPostItemModel.images.length,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }
}
