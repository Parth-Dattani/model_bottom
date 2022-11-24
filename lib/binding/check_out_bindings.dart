import 'package:get/get.dart';
import 'package:model_bottom/controller/check_out_controller.dart';

class CheckOutBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<CheckOutController>(CheckOutController(),permanent: false);
  }

}