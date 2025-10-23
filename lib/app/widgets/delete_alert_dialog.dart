import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:glow_street/app/modules/safezone/controllers/all_safezone_controller.dart';
import 'package:glow_street/app/modules/safezone/controllers/delete_safeZone_controller.dart';
import 'package:glow_street/app/modules/safezone/model/safeZone_model.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/costum_elavated_button.dart';
import 'package:glow_street/app/widgets/custom_disable_button.dart';
import 'package:glow_street/app/widgets/show_snackBar_message.dart';

class DeleteSafeZoneAlertDialog extends StatefulWidget {
  final SafeZoneItemModel safeZoneItemModel;
  const DeleteSafeZoneAlertDialog({super.key, required this.safeZoneItemModel});

  @override
  State<DeleteSafeZoneAlertDialog> createState() =>
      _DeleteSafeZoneAlertDialogState();
}

class _DeleteSafeZoneAlertDialogState extends State<DeleteSafeZoneAlertDialog> {
  DeleteSafeZoneController deleteSafeZoneController =
      DeleteSafeZoneController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 32.r,
              backgroundColor: Color(0xffFF3356),
              child: Icon(Icons.delete, color: Colors.white, size: 36.r),
            ),
            heightBox8,
            Text(
              'Delete SafeZone?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            heightBox16,
            Text(
              'Are you sure you want to delete this item? This action cannot be undone.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 133, 132, 132),
              ),
            ),
            heightBox20,
            CustomElevatedButton(
              title: 'Delete',
              isLoading: _isLoading,
              onPressed: () {
                deleteSafeZone(context);
              },
            ),
            heightBox8,
            CustomDisableElevatedButton(title: 'Cancel'),
          ],
        ),
      ),
    );
  }

  Future<void> deleteSafeZone(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    final bool isSuccess = await deleteSafeZoneController.deleteSafeZone(
      id: widget.safeZoneItemModel.id,
    );

    setState(() {
      _isLoading = false;
    });

    if (isSuccess) {
      final AllSafeZoneController allSafeZoneController =
          Get.find<AllSafeZoneController>();
      await allSafeZoneController.getSafeZoneContact();

      Navigator.pop(context);
    } else {
      showSnackBarMessage(
        context,
        deleteSafeZoneController.errorMessage,
        true,
      );
    }
  }
}
