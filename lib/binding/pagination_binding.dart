import 'package:get/get.dart';
import 'package:model_bottom/controller/pagination_controller.dart';

class PaginationBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<PaginationController>(PaginationController(),permanent: false);
  }

}