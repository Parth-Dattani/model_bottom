import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_bottom/constant/image_path.dart';
import '../../controller/controller.dart';


class SplashScreen extends GetView<SplashController> {
  static const pageId = "/Splash";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SafeArea(
        child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Image.asset(ImagePath.profileLogo, height: 30,),
                Text("welcome"),
              ],
            ),
      ),)
    );
  }
}
