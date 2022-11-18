import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:model_bottom/controller/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  static const pageId = '/ProfileScreen';

  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=> Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_ios_new)),
            title: const Text("My Profile")),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: controller.profileFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Profile",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 26,
                        decorationStyle: TextDecorationStyle.dashed,
                        decorationColor: Colors.red),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controller.nameController,
                    decoration: InputDecoration(
                      filled: true,
                      // fillColor: Colors.white54,
                      labelText: "username",
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "please enter username";
                      }
                      return null;
                    },
                    onChanged: (nameValue) {
                      controller.name = nameValue;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      labelText: "email",
                      filled: true,
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "please enter email address";
                      } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                    onChanged: (emailValue) {
                      controller.email = emailValue;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        //controller.loader.value = true;
                        await controller.updateUser();
                        print("name :  ${controller.nameController.text}");
                      },
                      child: const Text("Save")),
                  const SizedBox(
                    height: 5,
                  ),

                  controller.loader.value == false
                      ? const SizedBox.shrink(
                          child: Text("data"),
                        )
                      : const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.red),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
