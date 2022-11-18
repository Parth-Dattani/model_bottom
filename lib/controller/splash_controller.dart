import 'dart:async';
import 'package:get/get.dart';
import 'package:model_bottom/utill/utill.dart';
import '../screen/home_screen/home_screen.dart';
import '../screen/screen.dart';
import 'base_controller.dart';

class SplashController extends BaseController {

  @override
  void onInit() {
    Timer(const Duration(seconds: 5), checkLogin);
    super.onInit();
  }

  void checkLogin() async {
    print("hello ${await sharedPreferencesHelper.retrievePrefBoolData(Common.strIsLogin)}");
    switch (
    await sharedPreferencesHelper.retrievePrefBoolData(Common.strIsLogin)) {
      case true:
        return Get.offAndToNamed(HomeScreen.pageId);
      case false:
        return Get.offAndToNamed(LoginScreen.pageId);
    }
  }



}
