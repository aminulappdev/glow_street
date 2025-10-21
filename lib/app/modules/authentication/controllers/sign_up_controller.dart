import 'dart:io';
import 'package:get/get.dart';
import 'package:glow_street/app/modules/authentication/views/sign_in_screen.dart';
import 'package:glow_street/services/network_caller/network_caller.dart';
import 'package:glow_street/services/network_caller/network_response.dart';
import 'package:glow_street/urls.dart';

class SignUpController extends GetxController {
  final RxBool _inProgress = false.obs;
  bool get inProgress => _inProgress.value;

  final RxString _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  final RxString _otpToken = ''.obs;
  String get otpToken => _otpToken.value;

  /// 🔁 Sign Up Function
  Future<bool> signUp({
    String? firstName,
    String? lastName,
    String? email,
    String? number,
    String? password,
    File? image,
  }) async {
    if (_inProgress.value) {
      _errorMessage.value = 'Operation in progress';
      return false;
    }

    _inProgress.value = true;
    update();

    try {
      // Prepare the body
      Map<String, dynamic> jsonFields = {
        "name": "$firstName $lastName",
        "email": email,
        "password": password,
        "phoneNumber": number,
      };

      final NetworkResponse response =
          await Get.find<NetworkCaller>().postRequest(
        Urls.signUpUrl,
        body: jsonFields,
      );

      if (response.isSuccess && response.responseData != null) {
        _errorMessage.value = '';

        print(
            'OTP Token: ${response.responseData['data']['otpToken']['token']}');

        _otpToken.value = response.responseData['data']['otpToken']['token'];

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
