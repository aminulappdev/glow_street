import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glow_street/app/modules/safezone/controllers/all_safezone_controller.dart';
import 'package:glow_street/app/modules/safezone/controllers/update_status_controller.dart';
import 'package:glow_street/app/modules/safezone/widgets/add_safeZone_dialog.dart';
import 'package:glow_street/app/modules/safezone/widgets/safeZone_card.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/show_snackBar_message.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SafezoneScreen extends StatefulWidget {
  const SafezoneScreen({super.key});

  @override
  State<SafezoneScreen> createState() => _SafezoneScreenState();
}

class _SafezoneScreenState extends State<SafezoneScreen> {
  AllSafeZoneController allSafeZoneController =
      Get.put(AllSafeZoneController());
  final UpdateSafeZoneStatusController updateSafeZoneStatusController =
      UpdateSafeZoneStatusController();

  // Map to track loading state for each SafeZone item
  final Map<String, bool> _isLoadingMap = {};

  @override
  void initState() {
    allSafeZoneController.getSafeZoneContact();
    super.initState();
  }

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
            heightBox4,
            Obx(
              () {
                if (allSafeZoneController.inProgress) {
                  return SizedBox(
                    height: 400.h,
                    child: Center(
                      child: LoadingAnimationWidget.horizontalRotatingDots(
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  );
                } else if (allSafeZoneController.safeZoneData.isEmpty) {
                  return SizedBox(
                      height: 400.h,
                      child: Center(child: Text('No Safezone Found')));
                } else {
                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: allSafeZoneController.safeZoneData.length,
                      itemBuilder: (context, index) {
                        final safeZone =
                            allSafeZoneController.safeZoneData[index];
                        final isLoading = _isLoadingMap[safeZone.id] ?? false;

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: SafeZoneCard(
                            safeZoneItemModel:
                                allSafeZoneController.safeZoneData[index],
                            title: '',
                            status: safeZone.status ?? '',
                            statusButton: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: allSafeZoneController
                                            .safeZoneData[index].status ==
                                        'onGoing'
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4),
                                  child: allSafeZoneController
                                              .safeZoneData[index].status ==
                                          'onGoing'
                                      ? GestureDetector(
                                          onTap: isLoading
                                              ? null // Disable tap when loading
                                              : () {
                                                  updateMarkStatus(
                                                      safeZone.id!);
                                                },
                                          child: Row(
                                            children: [
                                              isLoading
                                                  ? SizedBox(
                                                      width: 16,
                                                      height: 16,
                                                      child: LoadingAnimationWidget
                                                          .horizontalRotatingDots(
                                                        color: Colors.white,
                                                        size: 16,
                                                      ),
                                                    )
                                                  : Icon(
                                                      Icons.check_box,
                                                      color: Color.fromARGB(
                                                          255, 253, 253, 253),
                                                      size: 16,
                                                    ),
                                              widthBox4,
                                              Text(
                                                isLoading
                                                    ? 'Updating...'
                                                    : 'Mark Safe',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Row(
                                          children: [
                                            Icon(
                                              Icons.check_box,
                                              color: Color.fromARGB(
                                                  255, 253, 253, 253),
                                              size: 16,
                                            ),
                                            widthBox4,
                                            Text(
                                              'Marked',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                            ),
                            date: allSafeZoneController
                                .safeZoneData[index].createdAt!,
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

  Future<void> updateMarkStatus(String id) async {
    setState(() {
      _isLoadingMap[id] = true; // Set loading state for the specific SafeZone
    });

    final bool isSuccess =
        await updateSafeZoneStatusController.updateSafeZoneStatus(
      id: id,
      status: 'completed',
    );

    setState(() {
      _isLoadingMap[id] = false; // Clear loading state
    });

    if (isSuccess) {
      if (mounted) {
        final AllSafeZoneController allController =
            Get.find<AllSafeZoneController>();
        await allController.getSafeZoneContact();
        // showSnackBarMessage(context, 'Successfully done'); // Optional: Success message
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, updateSafeZoneStatusController.errorMessage, true);
      }
    }
  }
}
