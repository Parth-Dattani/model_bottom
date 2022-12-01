import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:model_bottom/controller/controller.dart';

import '../../constant/constant.dart';
import '../../widgets/widgets.dart';

class OtpScreen extends GetView<OtpController>{
  static const pageId = '/OtpScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text(
           "Otp"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Column(

          children: [
            const Text(
              "OTP verification"
              ,textAlign: TextAlign.center,
              style: TextStyle(color: Colors.teal, fontSize: 22,fontWeight: FontWeight.w500,
              ),),
            const SizedBox(height: 20,),
            CommonTextFormField(
              keyboardType: TextInputType.number,
              controller: controller.otpController,
              labelText:  "Otp ",
              //hintText: "dfg",
              validator: (value){
                if(value!.isEmpty){
                  return "please enter otp";
                }
                return null;
              },
              // onChanged: (value){
              //   controller.otpController.value.text = value;
              // },
            ),
            const SizedBox(
              height: 20,
            ),

            CommonButton(
              color: ColorConfig.colorRed,
              onPressed: () async {

                Get.back();
                //Navigator.pop(context);
              },
              child: Text("Send Request"),
            )


          ],
        ),
      ),
    );
  }
}