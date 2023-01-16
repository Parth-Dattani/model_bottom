import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_media_signin/flutter_social_media_signin.dart';
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
  TextEditingController phoneController = TextEditingController();

  final loginFormKey = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;

  CollectionReference ref = FirebaseFirestore.instance.collection('users');
  UserModel loggedInUser = UserModel();

  RxBool isForgot = false.obs;
  RxBool isPhone = false.obs;

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

  Future<void> signInwithPhone()async{
    await auth
        .signInWithPhoneNumber(phoneController.text);

  }

  Future<void> signInwithGoogle()async {
    var googleAuth = await FlutterSocialMediaSignin().signInWithGoogle();
    await auth
    .signInWithCredential(googleAuth)
    .whenComplete(() =>
        sendDataFirestore(auth.currentUser!.displayName.toString(), auth.currentUser!.email.toString(), "user")
    );
    print("success");
    print("authf ${auth}");
    await Get.toNamed(HomeScreen.pageId);
  }

  Future<void> signInwithFB()async{
    var fbAuth = await FlutterSocialMediaSignin().signInWithFacebook();
    await auth
    .signInWithCredential(fbAuth)
    .whenComplete(() =>
        sendDataFirestore(auth.currentUser!.displayName.toString(), auth.currentUser!.email.toString(), "user")
    );
    print("success");
    print("authf ${auth}");
    await Get.toNamed(HomeScreen.pageId);
  }



  sendDataFirestore(String userName, String email, String rool) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;
    UserModel userModel = UserModel();
    userModel.userName = userName;
    userModel.email = email;
    userModel.uid = user!.uid;
    userModel.role = rool;
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
  }
}
