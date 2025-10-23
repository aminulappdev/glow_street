// ignore_for_file: avoid_print

import 'dart:io';
import 'package:get/get.dart';
import 'package:glow_street/app/modules/authentication/views/sign_in_screen.dart';
import 'package:glow_street/get_storage.dart';
import 'package:glow_street/services/network_caller/network_caller.dart';
import 'package:glow_street/services/network_caller/network_response.dart';
import 'package:glow_street/urls.dart';

class UpdateSafeZoneController extends GetxController {
  final RxBool _inProgress = false.obs;
  bool get inProgress => _inProgress.value;

  final RxString _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  /// 🔁 Sign Up Function
  Future<bool> updateSafeZone(
      {String? description,
      String? safeZoneId,
      bool? isContact,
      double? startLat,
      double? startLng,
      double? endLat,
      double? endLng,
      String? time}) async {
    if (_inProgress.value) {
      _errorMessage.value = 'Operation in progress';
      return false;
    }

    _inProgress.value = true;
    update();

    print(description);
    print(isContact);
    print(startLat);
    print(startLng);
    print(endLat);
    print(endLng);
    print(time);

    try {
      // Prepare the body
      Map<String, dynamic> jsonFields = {
        "description": description,
        "notification": isContact,
       
      };

      final NetworkResponse response =
          await Get.find<NetworkCaller>().patchRequest(
        accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
        Urls.updateStatusById(safeZoneId!),
        body: jsonFields,
      );

      if (response.isSuccess && response.responseData != null) {
        _errorMessage.value = '';
        _inProgress.value = false;
        update();
        return true;
      } else {
        _errorMessage.value = response.errorMessage;
        _errorMessage.value.contains('expired') ? Get.to(SignInScreen()) : null;
        _inProgress.value = false;
        update();
        return false;
      }
    } catch (e) {
      _errorMessage.value = 'Error signing up: $e';
      _inProgress.value = false;
      update();
      return false;
    }
  }
}
