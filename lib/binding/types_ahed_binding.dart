import 'package:get/get.dart';
import 'package:model_bottom/controller/controller.dart';

class TypesAhedBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<TypesAhedController>(TypesAhedController(), permanent: false);
  }
  
}