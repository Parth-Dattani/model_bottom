import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_social_media_signin/flutter_social_media_signin.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:model_bottom/constant/color_config.dart';
import 'package:model_bottom/constant/constant.dart';
import 'package:model_bottom/controller/controller.dart';
import 'package:model_bottom/screen/forgot_password_screen/forgot_password_screen.dart';
import 'package:model_bottom/screen/home_screen/home_screen.dart';
import 'package:model_bottom/screen/phone_screen/phone_screen.dart';
import 'package:model_bottom/screen/register_screen/register_screen.dart';
import 'package:model_bottom/utill/validator.dart';

import '../../widgets/widgets.dart';
import 'phone.dart';

class LoginScreen extends GetView<LoginController> {
  static const pageId = '/loginScreen';

  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Login"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: controller.loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 26,
                    decorationStyle: TextDecorationStyle.dashed,
                    decorationColor: Colors.red),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    labelText: "enter email",
                  ),
                  validator: Validator.isEmail

                  /*validator: (value){
                  if(value!.isEmpty){
                    return "please enter email address";
                  }
                  else  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return "Please enter a valid email address";
                  }
                  return null;
                },*/
                  ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller: controller.passwordController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "enter password",
                  ),
                  validator: Validator.isPassword),
              const SizedBox(height: 1),
              TextButton(
                onPressed: () {
                  Get.toNamed(ForgotPasswordScreen.pageId, arguments: {
                    "isForgot": controller.isForgot.value = true,
                    "isPhone": controller.isPhone.value = false,
                  });
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "Forgot Password",
                    style: CustomTextStyle.linkText,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.loginWithValidation();
                  },
                  child: const Text("Login")),
              const SizedBox(
                height: 5,
              ),
              TextButton(
                  onPressed: () {
                    Get.toNamed(RegisterScreen.pageId);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Don't have a account? ",
                        style: TextStyle(
                            color: ColorConfig.colorBlack, fontSize: 15),
                      ),
                      Text(
                        "Register",
                        style: TextStyle(
                            color: ColorConfig.colorLightBlue, fontSize: 18),
                      ),
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: Get.width * 0.35, height: 1, color: Colors.red),
                  const Spacer(),
                  const Text(
                    "Sign in With",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Container(
                    width: Get.width * 0.35,
                    height: 1,
                    color: Colors.red,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonButton(
                    color: Colors.black,
                    height: 55,
                    width: 10,
                    onPressed: () {
                      Get.toNamed(PhoneScreen.pageId
                          //     arguments: {
                          //   "isForgot" : controller.isForgot.value = false,
                          //   "isPhone" : controller.isPhone.value = true,
                          // }
                          );

                      //controller.signInwithPhone();
                    },
                    child: const Icon(
                      Icons.phone_iphone,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  CommonButton(
                    color: Colors.black,
                    height: 55,
                    width: 10,
                    onPressed: () async {
                      await controller.signInwithGoogle();
                    },
                    child: const FaIcon(
                      FontAwesomeIcons.google,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  CommonButton(
                    color: Colors.black,
                    height: 55,
                    width: 10,
                    onPressed: () async {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('This Feature is Under Devlopment'
                          ),
                        ),
                      );
                      //await controller.signInwithFB();
                    },
                    child: const FaIcon(
                      FontAwesomeIcons.facebook,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
