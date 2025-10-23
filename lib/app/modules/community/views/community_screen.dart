import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:glow_street/app/modules/community/controllers/all_alert_post_controller.dart';
import 'package:glow_street/app/modules/community/widgets/alert_post_card.dart';
import 'package:glow_street/app/modules/community/widgets/post_alert_dialog_widget.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// NEW: Reusable AlertPostCard Widget


// Modified CommunityScreen to use AlertPostCard
class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  AllAlertPostController allAlertPostController =
      Get.put(AllAlertPostController());

  @override
  void initState() {
    allAlertPostController.getAllAlertPost();
    super.initState();
  }

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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            heightBox30,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Community Alerts Nearby',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const CommunityAlertDialog(),
                      );
                    },
                    child: Icon(Icons.add, color: Color(0xff0501FF), size: 26)),
              ],
            ),
            heightBox16,
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
              ),
            ),
            heightBox12,
            Obx(
              () {
                if (allAlertPostController.inProgress) {
                  return SizedBox(
                    height: 400.h,
                    child: Center(
                      child: LoadingAnimationWidget.horizontalRotatingDots(
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  );
                } else if (allAlertPostController.alertPostData.isEmpty) {
                  return SizedBox(
                      height: 400.h,
                      child: Center(child: Text('No Data Found')));
                } else {
                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: allAlertPostController.alertPostData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: AlertPostCard(
                            alertPostItem:
                                allAlertPostController.alertPostData[index],
                            getAddress: getAddress,
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}