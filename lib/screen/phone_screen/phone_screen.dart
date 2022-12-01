import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:model_bottom/controller/controller.dart';

class PhoneScreen extends GetView<PhoneController>{
  static const pageId = '/PhoneScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Phone Auth",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller.nameController,
              decoration: const InputDecoration(
                hintText: 'User Name',
                prefix: Padding(
                  padding: EdgeInsets.all(4),
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Icon(Icons.person),
                  ),
                ),
              ),
              maxLength: 10,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: controller.phoneController,
              decoration: const InputDecoration(
                hintText: 'Phone Number',
                prefix: Padding(
                  padding: EdgeInsets.all(4),
                  child: Text('+91'),
                ),
              ),
              maxLength: 10,
              keyboardType: TextInputType.phone,
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

            const SizedBox(
              height: 10,
            ),


            MaterialButton(
              color: Colors.red[900],
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

  Widget otpNumberWidget(int position) {
    try {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
        child: Center(child: Text(controller.text.value[position], style: const TextStyle(color: Colors.black),)),
      );
    } catch (e) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
      );
    }
  }

}