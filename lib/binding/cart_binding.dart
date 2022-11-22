import 'package:get/get.dart';
import 'package:model_bottom/controller/cart_controller.dart';

class CartBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<CartController>(CartController(),permanent: false);
  }

}