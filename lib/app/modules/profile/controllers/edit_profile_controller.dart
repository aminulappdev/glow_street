import 'dart:io';

import 'package:get/get.dart';
import 'package:glow_street/app/modules/authentication/views/sign_in_screen.dart';
import 'package:glow_street/get_storage.dart';
import 'package:glow_street/services/network_caller/network_caller.dart';
import 'package:glow_street/services/network_caller/network_response.dart';
import 'package:glow_street/urls.dart';

class EditProfileController extends GetxController {
  final RxBool _inProgress = false.obs;
  bool get inProgress => _inProgress.value;

  final RxString _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  /// 🔁 Sign Up Function
  Future<bool> editProfile({
    String? name,
    String? number,
    File? image,
  }) async {
    if (_inProgress.value) {
      _errorMessage.value = 'Operation in progress';
      return false;
    }

    _inProgress.value = true;
    update();

    print('Image: $image');
    if (image != null) {
      print('Image path: ${image.path}');
      print('Image exists: ${await image.exists()}');
    } else {
      print('Image is null');
    }

    try {
      // Prepare the body
      Map<String, dynamic> jsonFields = {"name": name, "phoneNumber": number};

      final NetworkResponse response =
          await Get.find<NetworkCaller>().patchRequest(
        Urls.updateProfileUrl,
        body: jsonFields,
        accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
        image: image,
        keyNameImage: 'profile',
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
