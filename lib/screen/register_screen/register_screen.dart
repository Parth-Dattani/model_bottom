import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_bottom/constant/color_config.dart';
import 'package:model_bottom/controller/controller.dart';
import 'package:model_bottom/widgets/common_button.dart';
import 'package:model_bottom/widgets/common_text_field.dart';


class RegisterScreen extends GetView<RegisterController> {
  static const pageId = '/RegisterScreen';

  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: const Text(
          "Registration",
          style: TextStyle(fontWeight: FontWeight.w500),
        )),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: controller.registerFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Register",
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
                    labelText: "enter username",
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter username";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    labelText: "enter email",
                    filled: true,
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
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
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: controller.passwordController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "enter password",
                      filled: true,
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      suffixIcon: IconButton(
                          icon: Icon(controller.isObscure.value
                              ? Icons.visibility_off
                              : Icons.visibility, color: controller.isObscure.value?Colors.black26:Colors.blue),
                          onPressed: () {
                            controller.isObscure.value =
                                !controller.isObscure.value;
                          }),
                    ),
                    obscureText: controller.isObscure.value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "please enter password";
                      } else if (value.length < 6) {
                        return "password must be more than 6 letter";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: controller.confirmPasswordController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "enter confirm password",
                      filled: true,
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black26),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      suffixIcon: IconButton(
                          icon: Icon(controller.isObscure2.value
                              ? Icons.visibility_off
                              : Icons.visibility, color: controller.isObscure.value?Colors.black26:Colors.blue),
                          onPressed: () {
                            controller.isObscure2.value =
                                !controller.isObscure2.value;
                          }),
                    ),
                    obscureText: controller.isObscure2.value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "please enter password";
                      } else if (value.length < 6) {
                        return "password must be more than 6 letter";
                      } else if (controller.passwordController.text !=
                          controller.confirmPasswordController.text) {
                        return "Password did not match";
                      }
                      return null;
                    }),

                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Role : ",
                      style: TextStyle(fontSize: 15),
                    ),
                    DropdownButton<String>(
                      items: controller.roleList.map((String items) {
                        return DropdownMenuItem<String>(
                          value: items.toString(),
                          child: Text(
                            items,
                            style: const TextStyle(fontSize: 15),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.currentItemSelected.value = value!;
                        controller.rool.value = value;
                        print(controller.currentItemSelected);
                      },
                      isDense: true,
                      isExpanded: false,
                      iconEnabledColor: Colors.grey,
                      dropdownColor: Colors.grey,
                      value: controller.currentItemSelected.toString(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () async{
                      await controller.registerWithValidation();
                    },
                    child: const Text("Register")),
                const SizedBox(
                  height: 5,
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const[
                      Text("already have an account? ", style: TextStyle(color: ColorConfig.colorBlack,fontSize: 15),),
                      Text("Login", style: TextStyle(fontSize: 18, color: ColorConfig.colorLightBlue),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
