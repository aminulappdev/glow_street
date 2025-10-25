// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:glow_street/get_storage.dart';
import 'package:glow_street/services/network_caller/network_caller.dart';
import 'package:glow_street/services/network_caller/network_response.dart';
import 'package:glow_street/urls.dart';

class SubscriptionController extends GetxController {
  final NetworkCaller networkCaller = Get.put(NetworkCaller());

  RxBool _inProgress = false.obs; // Changed to RxBool
  bool get inProgress => _inProgress.value; // Updated getter to use .value

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _subscriptionId;
  String? get subcriptionId => _subscriptionId;

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> getSubscription(String id) async {
    if (_inProgress.value) {
      // Updated to use .value
      return false;
    }

    bool isSuccess = false;

    _inProgress.value = true; // Updated to use .value
    update();

    Map<String, dynamic> requestBody = {"packageId": id};

    final NetworkResponse response = await networkCaller.postRequest(
      Urls.subscriptionUrl,
      body: requestBody,
      accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
    );

    if (response.isSuccess) {
      _subscriptionId = response.responseData['data']['id'];
      print('Subscription ID in controller : $_subscriptionId');
      _errorMessage = null;
      isSuccess = true;
      _errorMessage = null; // Note: Redundant assignment, can be simplified
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress.value = false; // Updated to use .value
    update();
    return isSuccess;
  }
}
