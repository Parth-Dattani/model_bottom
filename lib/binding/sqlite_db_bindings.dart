import 'package:get/get.dart';
import 'package:model_bottom/controller/controller.dart';

class SqliteDbBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<SqliteDbController>(SqliteDbController(), permanent: false);
  }

}