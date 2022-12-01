import 'package:get/get.dart';
import 'package:model_bottom/controller/controller.dart';

class ForgotPasswordBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<ForgotPasswordController>(ForgotPasswordController(), permanent: false);
  }

}