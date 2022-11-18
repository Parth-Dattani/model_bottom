import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:model_bottom/controller/controller.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<ProfileController>(ProfileController(),permanent: false);
  }

}