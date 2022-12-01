import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_bottom/constant/color_config.dart';
import 'package:model_bottom/controller/controller.dart';
import 'package:model_bottom/screen/otp_screen/otp_screen.dart';
import 'package:model_bottom/widgets/common_button.dart';
import 'package:model_bottom/widgets/common_text_field.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController>{
  static const pageId = '/ForgotPasswordScreen';
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text(
            controller.isForgot.value == true ?
            "What's my Password?" : "Phone Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Column(

          children: [
             Text(
               controller.isForgot.value == true ?
               "If you have forgotten your password you can reset it here" :
               "phone verification"
               ,textAlign: TextAlign.center,
              style: TextStyle(color: Colors.teal, fontSize: 22,fontWeight: FontWeight.w500,
              ),),
            const SizedBox(height: 20,),
            CommonTextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: controller.emailController,
              labelText: controller.isForgot.value == true ? "email" : "phone ",
              //hintText: "dfg",
              validator: (value){
                if(value!.isEmpty){
                  return "please enter email";
                }
                return null;
              },
              onChanged: (value){
                controller.email.value = value;
              },
            ),

            const SizedBox(
              height: 20,
            ),

            Visibility(
              visible: controller.otpVisibility.value,
              child:  TextField(
                controller: controller.otpController,
                decoration: const InputDecoration(
                  hintText: 'OTP',
                  prefix: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(''),
                  ),
                ),
                maxLength: 6,
                keyboardType: TextInputType.number,
              ),
            ),

            controller.isForgot.value == true ?
            CommonButton(
              color: ColorConfig.colorRed,
              onPressed: () async {
                await FirebaseAuth.instance
                    .sendPasswordResetEmail(email: controller.email.value)
                    .whenComplete(
                      () => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "An email has been send ${controller.email} to please verify",
                      ),
                    ),
                  ),
                );
                Get.back();
                //Navigator.pop(context);
              },
              child: Text("Send Request"),
            ) :
            CommonButton(
              color: ColorConfig.colorRed,
              onPressed: () async {
                //Get.toNamed(OtpScreen.pageId);
               //controller.loginWithPhone();

                Get.back();
              },
              child: const Text("Send OTP"),
            ),
            MaterialButton(
              color: Colors.indigo[900],
              onPressed: () {
                if (controller.otpVisibility.value) {
                  controller.verifyOTP();
                } else {
                  controller.loginWithPhone();
                }
              },
              child: Text(
                controller.otpVisibility.value ? "Verify" : "Login",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

}