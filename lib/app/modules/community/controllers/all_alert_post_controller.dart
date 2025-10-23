import 'package:get/get.dart';
import 'package:glow_street/app/modules/authentication/views/sign_in_screen.dart';
import 'package:glow_street/app/modules/community/model/alert_post_model.dart';
import 'package:glow_street/get_storage.dart';
import 'package:glow_street/services/network_caller/network_caller.dart';
import 'package:glow_street/services/network_caller/network_response.dart';
import 'package:glow_street/urls.dart';

class AllAlertPostController extends GetxController {
  final RxBool _inProgress = false.obs;
  bool get inProgress => _inProgress.value;

  final RxString _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  final Rx<AlertPostModel?> _alertPostModel = Rx<AlertPostModel?>(null);
  List<AlertPostItemModel> get alertPostData =>
      _alertPostModel.value?.data?.data ?? [];

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> getAllAlertPost() async {
    _inProgress.value = true;
    update(); 

    try {
      final NetworkResponse response = await Get.find<NetworkCaller>()
          .getRequest(Urls.allCommunityAlertUrl,
              accessToken: StorageUtil.getData(StorageUtil.userAccessToken));

      if (response.isSuccess && response.responseData != null) {
        _errorMessage.value = '';
        _alertPostModel.value = AlertPostModel.fromJson(response.responseData);
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
      _errorMessage.value = 'Failed to fetch district data: ${e.toString()}';
      print('Error fetching district data: $e');
      _inProgress.value = false;
      update(); 
      return false;
    }
  }
}
