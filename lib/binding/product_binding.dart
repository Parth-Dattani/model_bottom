import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:model_bottom/controller/product_controller.dart';

class ProductBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<ProductController>(ProductController(), permanent: false);
  }

}