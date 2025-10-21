import 'package:get/get.dart';
import 'package:glow_street/app/modules/profile/controllers/profile_controller.dart';
import 'package:glow_street/services/network_caller/network_caller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
   Get.put(NetworkCaller());
   Get.put(ProfileDetailsController());
    
    
  }
}
