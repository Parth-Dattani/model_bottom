import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_bottom/controller/base_controller.dart';
import 'package:model_bottom/screen/home_screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class RegisterController extends BaseController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final registerFormKey = GlobalKey<FormState>();

  RxBool isObscure = true.obs;
  RxBool isObscure2 = true.obs;

  var currentItemSelected = "user".obs;
  var rool = "user".obs;

  var roleList = ["admin", "user"].obs;

  //a
  final auth = FirebaseAuth.instance;

  //CollectionReference ref = FirebaseFirestore.instance.collection('users');
  get user => auth.currentUser;

  Future<void> registerWithValidation() async {
    if (registerFormKey.currentState!.validate()) {
      loader.value = true;
      //signUp(email: emailController.value.text, password: passwordController.value.text, userName: nameController.value.text,rool: currentItemSelected.value );
      signUp(nameController.value.text, emailController.value.text,
          passwordController.value.text, currentItemSelected.value);
      loader.value = false;
    }
  }

  //only user entry
  // Future signUp({required String userName, required String email, required String password, required String rool}) async {
  //   try {
  //     await auth.createUserWithEmailAndPassword(
  //       //name : nameController.value.text,
  //       email: emailController.value.text,
  //       password: passwordController.value.text,
  //     );
  //     return null;
  //   } on FirebaseAuthException catch (e) {
  //     return e.message;
  //   }
  // }
  //user entry
  void signUp(
      String userName, String email, String password, String rool) async {
    print("success");
    loader.value = true;
    CircularProgressIndicator();
    await auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      String? registerToken = await FirebaseMessaging.instance.getToken();

      print("GEt TOKEN $registerToken");
      sendDataFirestore(userName, email, rool, registerToken);
    }).catchError((e) {});
    //if (res != null) {
    // if(auth != null){
    //   sharedPreferencesHelper.getSharedPreferencesInstance();
    //   sharedPreferencesHelper.storePrefData(email, emailController.text);
    //   sharedPreferencesHelper.storePrefData(password, passwordController.text);
    // }

    if (user != null) {
      print("user ss");
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString(
        'email',
        email,
      );
      sharedPreferences.setString('password', password);
      Get.offAndToNamed(HomeScreen.pageId);
    }

    loader.value = false;
    //}
  }

  //user store in firestore
  sendDataFirestore(
      String userName, String email, String rool, registerToken) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;
    UserModel userModel = UserModel();
    userModel.userName = userName;
    userModel.email = email;
    userModel.uid = user!.uid;
    userModel.role = rool;
    userModel.registerToken = registerToken;
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
  }
}
