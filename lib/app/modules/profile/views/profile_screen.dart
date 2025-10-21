import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glow_street/app/modules/profile/controllers/profile_controller.dart';
import 'package:glow_street/app/modules/profile/views/change_password_screen.dart';
import 'package:glow_street/app/modules/profile/views/edit_profile_screen.dart';
import 'package:glow_street/app/modules/profile/views/info_screen.dart';
import 'package:glow_street/app/modules/profile/views/subscription_screen.dart';
import 'package:glow_street/app/modules/profile/widgets/logout_alert_dialog.dart';
import 'package:glow_street/app/utils/app_text.dart';
import 'package:glow_street/app/utils/assets_path.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileDetailsController profileDetailsController =
      Get.find<ProfileDetailsController>();

  @override
  void initState() {
    profileDetailsController.getMyProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              heightBox30,
              Center(
                  child: Text(
                'Profile',
                style: GoogleFonts.kumbhSans(
                    fontSize: 18, fontWeight: FontWeight.w700),
              )),
              Obx(
                () {
                  if (profileDetailsController.inProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Card(
                      elevation: 1,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Contact info
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20.r,
                                  backgroundImage: AssetImage(AssetsPath.city),
                                ),
                                SizedBox(width: 8.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      profileDetailsController
                                              .profileData?.name ??
                                          '',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      profileDetailsController
                                              .profileData?.email ??
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
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
              heightBox12,
              Card(
                elevation: 1,
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  child: Column(
                    children: [
                      profileFeatureRow(
                        iconData: Icons.person,
                        title: 'Edit Profile',
                        subTitle: 'Change profile picture,number,email',
                        ontap: () {
                          Get.to(EditProfileScreen());
                        },
                      ),
                      profileFeatureRow(
                        iconData: Icons.key_outlined,
                        title: 'Change password',
                        subTitle: 'Update and strengthen account security',
                        ontap: () {
                          Get.to(ChangePasswordScreen());
                        },
                      ),
                      profileFeatureRow(
                        iconData: Icons.subscriptions,
                        title: 'Subscription',
                        subTitle: 'Manage your plan, renew or upgrade',
                        ontap: () {
                          Get.to(SubscriptionScreen());
                        },
                      ),
                      profileFeatureRow(
                        iconData: Icons.folder_rounded,
                        title: 'Terms and conditions',
                        subTitle: 'Understand the rules and responsibilities',
                        ontap: () {
                          Get.to(InfoScreen(
                            title: 'Terms and conditions',
                            content: DemoText.policies,
                          ));
                        },
                      ),
                      profileFeatureRow(
                        iconData: Icons.policy,
                        title: 'Privacy and Policy',
                        subTitle: 'Learn how your data is collected',
                        ontap: () {
                          Get.to(InfoScreen(
                            title: 'Privacy and Policy',
                            content: DemoText.policies,
                          ));
                        },
                      ),
                      profileFeatureRow(
                        iconColor: Color(0xffFF1177),
                        iconData: Icons.logout,
                        title: 'Log Out',
                        subTitle: 'Securely log out Account',
                        ontap: () {
                          showDialog(
                            context: context,
                            builder: (context) => LogOutAlertDialog(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileFeatureRow(
      {required IconData iconData,
      required String title,
      required String subTitle,
      required VoidCallback ontap,
      Color iconColor = const Color(0xff0501FF)}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: InkWell(
        onTap: ontap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Contact info
            Row(
              children: [
                Icon(
                  iconData,
                  color: iconColor,
                  size: 30,
                ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subTitle,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Edit and delete icons
            InkWell(
              onTap: ontap,
              child: Icon(
                Icons.arrow_forward_ios,
                size: 18.sp,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
