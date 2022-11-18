import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  RxBool loader = false.obs;
  RxBool isEdit = false.obs;
}
