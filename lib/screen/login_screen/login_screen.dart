import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:model_bottom/controller/controller.dart';
import 'package:model_bottom/screen/register_screen/register_screen.dart';

class LoginScreen extends GetView<LoginController>{
  static const pageId = '/loginScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: controller.loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login", style: TextStyle(fontWeight: FontWeight.w700,fontSize: 26,
              decorationStyle: TextDecorationStyle.dashed,
                decorationColor: Colors.red
              ),),
              SizedBox(height: 10,),
              TextFormField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  labelText: "enter email",
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "please enter email address";
                  }
                  else  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return "Please enter a valid email address";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: controller.passwordController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "enter password",
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "please enter password";
                  }
                  else if(value.length < 6){
                    return "password must be more than 6 letter";
                  }
                  return null;
                }
              ),
              const SizedBox(height: 15,),
              ElevatedButton(onPressed: () {
                controller.loginWithValidation();
              },
                  child: Text("Login")),
              const SizedBox(height: 5,),
              TextButton(onPressed: (){
                Get.toNamed(RegisterScreen.pageId);
              }, child: Text("Don't have a account? Register"))

            ],
        ),
        ),
      ),
    );
  }



}
