import 'package:get/get.dart';
import 'package:glow_street/app/modules/authentication/views/sign_in_screen.dart';
import 'package:glow_street/app/modules/profile/model/profile_details_model.dart';
import 'package:glow_street/get_storage.dart';
import 'package:glow_street/services/network_caller/network_caller.dart';
import 'package:glow_street/services/network_caller/network_response.dart';
import 'package:glow_street/urls.dart';

class ProfileDetailsController extends GetxController {
  final RxBool _inProgress = false.obs;
  bool get inProgress => _inProgress.value;

  final RxString _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  final Rx<ProfileDetailsModel?> _profileDetailsModel =
      Rx<ProfileDetailsModel?>(null);
  ProfileData? get profileData => _profileDetailsModel.value?.data;

  @override
  void onInit() {
    super.onInit();
    getMyProfile();
  }

  Future<bool> getMyProfile() async {
    _inProgress.value = true;

    try {
      final NetworkResponse response =
          await Get.find<NetworkCaller>().getRequest(
        Urls.profileUrl,
        accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
      );

      if (response.isSuccess && response.responseData != null) {
        _errorMessage.value = '';
        print(
          'My Profile Response data from controller : ${response.responseData['data']['_id']}',
        );

        // StorageUtil.saveData(
        //   StorageUtil.userAuthId,
        //   response.responseData['data']['authId'],
        // );

        StorageUtil.saveData(
          StorageUtil.userId,
          response.responseData['data']['_id'],
        );
        _profileDetailsModel.value = ProfileDetailsModel.fromJson(
          response.responseData,
        );
        _inProgress.value = false;
        return true;
      } else {
        _errorMessage.value = response.errorMessage;
        _errorMessage.value.contains('expired') ? Get.to(SignInScreen()) : null;
        _inProgress.value = false;
        return false;
      }
    } catch (e) {
      _errorMessage.value = 'Failed to fetch district data: ${e.toString()}';
      print('Error fetching district data: $e');
      _inProgress.value = false;
      return false;
    }
  }
}
