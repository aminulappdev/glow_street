// payment_service.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glow_street/app/modules/subscription/controller/payment_controller.dart';
import 'package:glow_street/app/modules/subscription/views/payment_webview_screen.dart';
import 'package:glow_street/app/widgets/show_snackBar_message.dart';

class PaymentService {
  final PaymentController paymentController = PaymentController();

  Future<void> payment(BuildContext context, String referenceId) async {
    final bool isSuccess = await paymentController.getPayment(referenceId);

    Map<String, dynamic> paymentData = {
      'link': paymentController.paymentData?.data,
      'reference': referenceId
    };

    if (isSuccess) {
      // Directly use context without mounted check
      showSnackBarMessage(context, 'Payment request done');
      Get.to(PaymentView(paymentData: paymentData));
    } else {
      // Error handling
      showSnackBarMessage(context,
          paymentController.errorMessage ?? 'There was a problem', true);
    }
  }
}
