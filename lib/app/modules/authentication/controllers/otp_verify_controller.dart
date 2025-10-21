import 'package:get/get.dart';
import 'package:glow_street/app/modules/authentication/views/sign_in_screen.dart';
import 'package:glow_street/services/network_caller/network_caller.dart';
import 'package:glow_street/services/network_caller/network_response.dart';
import 'package:glow_street/urls.dart';

class OtpVerifyController extends GetxController {
  final RxBool _inProgress = false.obs;
  bool get inProgress => _inProgress.value;

  final RxString _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  final RxString _otpToken = ''.obs;
  String get otpToken => _otpToken.value;

  /// 🔁 Sign Up Function
  Future<bool> otpVerify({
    String? otpToken,
    String? otp,
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
        "otp": otp,
      };

      final NetworkResponse response = await Get.find<NetworkCaller>()
          .postRequest(Urls.otpVerifyUrl, body: jsonFields, token: otpToken);

      if (response.isSuccess && response.responseData != null) {
        _otpToken.value = response.responseData['data']['token'];
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
