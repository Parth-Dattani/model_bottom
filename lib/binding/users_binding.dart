import 'package:get/get.dart';
import 'package:model_bottom/controller/controller.dart';

class UsersBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<UsersController>(UsersController(), permanent: false);
  }

}