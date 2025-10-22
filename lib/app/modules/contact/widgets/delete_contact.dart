import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glow_street/app/modules/contact/controllers/all_emergency_contact_controller.dart';
import 'package:glow_street/app/modules/contact/controllers/delete_contact_controller.dart';
import 'package:glow_street/app/modules/contact/model/emergency_contact_model.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/costum_elavated_button.dart';
import 'package:glow_street/app/widgets/custom_disable_button.dart';
import 'package:glow_street/app/widgets/show_snackBar_message.dart';

class DeleteContactAlertDialog extends StatefulWidget {
  final EmergencyContactItemModel emergencyContactItemModel;
  const DeleteContactAlertDialog(
      {super.key, required this.emergencyContactItemModel});

  @override
  State<DeleteContactAlertDialog> createState() =>
      _DeleteContactAlertDialogState();
}

class _DeleteContactAlertDialogState extends State<DeleteContactAlertDialog> {
  DeleteContactController deleteContactController = DeleteContactController();
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
              'Delete Contact?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            heightBox16,
            Text(
              'Are you sure you want to delete contact? This action cannot be undone.',
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
                deleteContact(context);
              },
            ),
            heightBox8,
            CustomDisableElevatedButton(title: 'Cancel'),
          ],
        ),
      ),
    );
  }

  Future<void> deleteContact(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    final bool isSuccess = await deleteContactController.deleteContact(
      id: widget.emergencyContactItemModel.id,
    );

    setState(() {
      _isLoading = false;
    });

    if (isSuccess) {
      final AllEmergencyContactController allController =
          Get.find<AllEmergencyContactController>();
      await allController.getAllEmergencyContact();
      showSnackBarMessage(context, 'Successfully done');
      Navigator.pop(context);
    } else {
      showSnackBarMessage(
        context,
        deleteContactController.errorMessage,
        true,
      );
    }
  }
}
