import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glow_street/app/modules/profile/controllers/content_controller.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/costom_app_bar.dart';

class InfoScreen extends StatefulWidget {
  final String contentKey;
  final String title;
  final String content;
  const InfoScreen(
      {super.key,
      required this.title,
      required this.content,
      required this.contentKey});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  ContentController contentController = Get.put(ContentController());

  @override
  void initState() {
    contentController.getMyContent(widget.contentKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            heightBox30,
            CustomAppBar(name: widget.title),
            heightBox12,
            Obx(
              () {
                if (contentController.inProgress) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Html(
                      data: widget.contentKey == 'termsAndCondition'
                          ? contentController.contentData?.termsAndCondition
                          : contentController.contentData?.privacyPolicy);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
