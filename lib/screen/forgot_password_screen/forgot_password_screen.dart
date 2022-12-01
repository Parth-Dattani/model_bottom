import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_bottom/constant/color_config.dart';
import 'package:model_bottom/controller/controller.dart';
import 'package:model_bottom/widgets/common_button.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController>{
  static const pageId = '/ForgotPasswordScreen';
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: const Text("Forgot Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: "Email"),
              onChanged: (value) {
                //setState(() {
                  controller.email.value = value.trim();
                //});
              },
            ),
            SizedBox(
              height: 20,
            ),
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
                Navigator.pop(context);
              },
              child: Text("Send Request"),
            )
          ],
        ),
      ),
    );
  }

}