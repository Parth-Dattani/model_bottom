import 'package:get/get.dart';
import 'package:model_bottom/controller/controller.dart';

class PhoneBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<PhoneController>(PhoneController(),permanent: false);
  }
  
}