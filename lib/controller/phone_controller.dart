import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:model_bottom/controller/base_controller.dart';

import '../model/user_model.dart';
import '../screen/home_screen/home_screen.dart';

class PhoneController extends BaseController{
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  RxBool otpVisibility = false.obs;
  User? user;
  RxString verificationID = "".obs;

  RxString text = ''.obs;

  void onKeyboardTap(String value) {
//    setState(() {
      text.value = text.value + value;
    //});
  }

  void loginWithPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: "+91${phoneController.text}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
          print(value);
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print("verificationFailed : ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility.value = true;
        verificationID.value = verificationId;
        update();
        //setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID.value, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then(
          (value) {
        //setState(() {
          user = FirebaseAuth.instance.currentUser;
          update();
        //});
      },
    ).whenComplete(
          () {
        if (user != null) {
          Fluttertoast.showToast(
            msg: "You are logged in successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );

          sendDataFirestore(nameController.value.text, auth.currentUser!.email.toString(), "user");

          Get.toNamed(HomeScreen.pageId);

        } else {
          Fluttertoast.showToast(
            msg: "your login is failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
    );
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