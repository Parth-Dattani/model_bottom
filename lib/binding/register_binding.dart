import 'package:get/get.dart';
import 'package:model_bottom/controller/controller.dart';

class RegisterBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<RegisterController>(RegisterController(), permanent: false);
  }

}