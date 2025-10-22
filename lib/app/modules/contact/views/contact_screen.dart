import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glow_street/app/modules/contact/controllers/all_emergency_contact_controller.dart';
import 'package:glow_street/app/modules/contact/widgets/add_contact_dialog.dart'
    show AddContactAlertDialog;
import 'package:glow_street/app/modules/contact/widgets/delete_contact.dart';
import 'package:glow_street/app/modules/contact/widgets/edit_contact_dialog.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/toggle_button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

/// A screen to display emergency contacts with a list and notification toggle.
class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  bool isShowNotification = false;

  AllEmergencyContactController allEmergencyContactController =
      Get.put(AllEmergencyContactController());

  @override
  void initState() {
    allEmergencyContactController.getAllEmergencyContact();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            // Header with title and add icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Emergency Contact',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => const AddContactAlertDialog(),
                  ),
                  child: Icon(
                    Icons.add,
                    color: const Color(0xff0501FF),
                    size: 26.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            // Contact list

            Obx(
              () {
                if (allEmergencyContactController.inProgress) {
                  return SizedBox(
                    height: 500.h,
                    child: Center(
                      child: LoadingAnimationWidget.horizontalRotatingDots(
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  );
                } else if (allEmergencyContactController
                    .emergencyContactData.isEmpty) {
                  return SizedBox(
                    height: 500.h,
                    child: Center(
                      child: Text("No Emergency Contact Added"),
                    ),
                  );
                } else {
                  return Expanded(
                    child: SizedBox(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: allEmergencyContactController
                            .emergencyContactData.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 6.h),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 201, 200, 200),
                                  width: 0.5,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(12.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Contact info
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 18.r,
                                          backgroundImage: NetworkImage(
                                              allEmergencyContactController
                                                      .emergencyContactData[
                                                          index]
                                                      .profile ??
                                                  ''),
                                        ),
                                        SizedBox(width: 8.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              allEmergencyContactController
                                                      .emergencyContactData[
                                                          index]
                                                      .name ??
                                                  '',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              allEmergencyContactController
                                                      .emergencyContactData[
                                                          index]
                                                      .phoneNumber ??
                                                  '',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    // Edit and delete icons
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () => showDialog(
                                            context: context,
                                            builder: (context) =>
                                                EditContactAlertDialog(
                                              emergencyContactItemModel:
                                                  allEmergencyContactController
                                                          .emergencyContactData[
                                                      index],
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.edit,
                                            size: 20.sp, 
                                            color: const Color(0xff1A5EED),
                                          ),
                                        ),
                                        SizedBox(width: 8.w),
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  DeleteContactAlertDialog(
                                                emergencyContactItemModel:
                                                    allEmergencyContactController
                                                            .emergencyContactData[
                                                        index],
                                              ),
                                            );
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            size: 20.sp,
                                            color: const Color(0xffDC143C),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),

            SizedBox(height: 10.h),
            // Notification toggle and add contact button
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              elevation: 1,
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Toggle button for notifications
                    ToggleButton(
                      isToggled: isShowNotification,
                      onToggle: (bool value) {
                        setState(() {
                          isShowNotification = value;
                        });
                        debugPrint(
                          isShowNotification
                              ? "Notification is ON"
                              : "Notification is OFF",
                        );
                      },
                    ),
                    SizedBox(width: 8.w),
                    // Notification text and button
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Direct call to 911 or local emergency services.',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(255, 3, 3, 3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            heightBox10,
          ],
        ),
      ),
    );
  }
}

/// Sample implementation of CustomElevatedButton to ensure no layout issues.
