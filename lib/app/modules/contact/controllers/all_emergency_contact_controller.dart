
import 'package:get/get.dart';
import 'package:glow_street/app/modules/authentication/views/sign_in_screen.dart';
import 'package:glow_street/app/modules/contact/model/emergency_contact_model.dart';
import 'package:glow_street/get_storage.dart';
import 'package:glow_street/services/network_caller/network_caller.dart';
import 'package:glow_street/services/network_caller/network_response.dart';
import 'package:glow_street/urls.dart';

class AllEmergencyContactController extends GetxController {
  final RxBool _inProgress = false.obs;
  bool get inProgress => _inProgress.value;

  final RxString _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  final Rx<EmergencyContactModel?> _emergencyContactModel =
      Rx<EmergencyContactModel?>(null);
  List<EmergencyContactItemModel> get emergencyContactData =>
      _emergencyContactModel.value?.data?.data ?? [];

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> getAllEmergencyContact() async {
    _inProgress.value = true;
    update(); // নতুন: UI কে লোডিং স্টেটে আপডেট নোটিফাই করো

    try {
      final NetworkResponse response = await Get.find<NetworkCaller>()
          .getRequest(Urls.allEmergencyContactUrl,
              accessToken: StorageUtil.getData(StorageUtil.userAccessToken));

      if (response.isSuccess && response.responseData != null) {
        _errorMessage.value = '';
        _emergencyContactModel.value =
            EmergencyContactModel.fromJson(response.responseData);
        _inProgress.value = false;
        update(); // নতুন: ডেটা আপডেটের পর UI নোটিফাই করো
        return true;
      } else {
        _errorMessage.value = response.errorMessage;
        _errorMessage.value.contains('expired') ? Get.to(SignInScreen()) : null;
        _inProgress.value = false;
        update(); // নতুন: এরর হলেও UI নোটিফাই করো
        return false;
      }
    } catch (e) {
      _errorMessage.value = 'Failed to fetch district data: ${e.toString()}';
      print('Error fetching district data: $e');
      _inProgress.value = false;
      update(); // নতুন: এরর হলেও UI নোটিফাই করো
      return false;
    }
  }
}
