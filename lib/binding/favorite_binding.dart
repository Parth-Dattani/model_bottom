import 'package:get/get.dart';
import 'package:model_bottom/binding/binding.dart';
import 'package:model_bottom/controller/favorite_controller.dart';

class FavoriteBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<FavoriteController>(FavoriteController(), permanent: false);
  }

}