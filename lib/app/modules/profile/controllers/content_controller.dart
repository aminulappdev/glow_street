import 'package:get/get.dart';
import 'package:glow_street/app/modules/authentication/views/sign_in_screen.dart';
import 'package:glow_street/app/modules/profile/model/content_model.dart';

import 'package:glow_street/get_storage.dart';
import 'package:glow_street/services/network_caller/network_caller.dart';
import 'package:glow_street/services/network_caller/network_response.dart';
import 'package:glow_street/urls.dart';

class ContentController extends GetxController {
  final RxBool _inProgress = false.obs;
  bool get inProgress => _inProgress.value;

  final RxString _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  final Rx<ContentModel?> _contentModel = Rx<ContentModel?>(null);
  ContentData? get contentData => _contentModel.value?.data;

  Future<bool> getMyContent(String? content) async {
    _inProgress.value = true;

    try {
      final NetworkResponse response =
          await Get.find<NetworkCaller>().getRequest(
        Urls.contentUrl,
        accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
        queryParams: {'key': content},
      );

      if (response.isSuccess && response.responseData != null) {
        _errorMessage.value = '';

       

        _contentModel.value = ContentModel.fromJson(response.responseData);
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
