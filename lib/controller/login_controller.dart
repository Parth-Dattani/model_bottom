import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_bottom/controller/base_controller.dart';
import 'package:model_bottom/screen/home_screen/home_screen.dart';
import 'package:model_bottom/screen/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/model.dart';
import '../utill/shared_preferences_helper.dart';
import '../utill/utill.dart';

class LoginController extends BaseController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final loginFormKey = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;

  CollectionReference ref = FirebaseFirestore.instance.collection('users');

  //ref.doc();

  // retriveData(){
  //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   User? user = auth.currentUser;
  //   // firebaseFirestore
  //   //     .collection("users")
  //   //     .doc(user?.email).get(user!.uid);
  //   //
  //
  //   var u = FirebaseFirestore.instance.collection('user');
  //   var data = u.doc(u.id);
  //   data.snapshots();
  //
  //   print("data: $data");
  // }
  UserModel loggedInUser = UserModel();



  @override
  void onInit() {
    super.onInit();
    validateUserAuth();
  }

  void loginWithValidation() {
    if (loginFormKey.currentState!.validate()) {
      loader.value = true;
      const CircularProgressIndicator();
      signIn(emailController.value.text, passwordController.value.text);
      //retriveData();
    } else {
      loader.value = false;
    }
  }

  //register time s.p. store data
  void validateUserAuth() async {
    print("login into sp");
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('email');
    var obtainedPassword = sharedPreferences.getString('password');
    if (obtainedEmail != null || obtainedPassword != null) {
      //setState(() {
      loggedInUser.email = obtainedEmail!;
      //loggedinUserPassword = obtainedPassword!;
      // });
      if (loggedInUser.email != null /*|| loggedinUserPassword != null*/) {
        final loggedinuser = await auth.signInWithEmailAndPassword(
            email: loggedInUser.email.toString(), password: obtainedPassword!);
        if (loggedinuser != null) {
          Get.toNamed(HomeScreen.pageId);
        }
      }
    } else {
      Get.toNamed(LoginScreen.pageId);
    }
  }

  void signIn(String email, String password) async {
    try {
      UserCredential user =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("user : $user");

      if (user != null) {
        print("user has lg");
        sharedPreferencesHelper.storePrefData(email, emailController.text);
        sharedPreferencesHelper.storePrefData(password, passwordController.text);
        sharedPreferencesHelper.storeBoolPrefData(Common.strIsLogin, true);
        Get.offAndToNamed(HomeScreen.pageId);
      }
      //Get.offAndToNamed(HomeScreen.pageId);
    } on FirebaseAuthException catch (e) {
      print("Something Wrong $e");
    }
  }
}
