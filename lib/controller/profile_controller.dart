import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:model_bottom/controller/base_controller.dart';
import '../model/model.dart';

class ProfileController extends BaseController {
  final profileFormKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var role;
  String name = "";
  String email = " ";
  String password = "";
  dynamic argumentData = Get.arguments;

  User? user = FirebaseAuth.instance.currentUser;
  FirebaseAuth auth = FirebaseAuth.instance;
  final currenUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void onInit() {
    super.onInit();
    print("argument Data : ${argumentData[0]['name'].toString()} \n"
        " ${argumentData[1]['email'].toString()} \n"
        " ${argumentData[2]['role'].toString()}");

    // name = argumentData[0]['user'].toString();
    //nameController.text = argumentData[0]['user'].toString();

    // print("object" + nameController.text);
    // print(user);
    // print("object" + user!.displayName.toString());
    // nameController.text = user!.displayName.toString();
    // emailController.text = user!.email.toString();
    nameController.text = argumentData[0]['name'].toString();
    emailController.text = argumentData[1]['email'].toString();
    role = argumentData[2]['role'].toString();
  }

  updateUser() async {
    loader.value = true;
    profileFormKey.currentState!.save();
    if (profileFormKey.currentState!.validate()) {
      UserModel user = UserModel(
        uid: currenUserId,
        userName: nameController.text,
        email: emailController.text,
        role: role
      );

      //updateUserData(user);
      FirebaseFirestore.instance
          .collection("users")
          .doc(currenUserId)
          .update(user.toMap());
      Future.delayed(const Duration(seconds: 5), () {
        Get.back();
        loader.value = false;
      });
      //Get.back();

    }
  }

// static Future<QuerySnapshot> searchUsers(String name) async {
//   Future<QuerySnapshot> users = userRef
//       .where('name', isGreaterThanOrEqualTo: name)
//       .where('name', isLessThan: name + 'z')
//       .get();
//
//   return users;
// }

// void AuthService(updateProfile) {
//   FirebaseAuth auth = FirebaseAuth.instance;
//
//   updateProfile({String? name, String? email, String? password}) async {
//     await FirebaseAuth.instance
//         .createUserWithEmailAndPassword(
//             email: emailController.text, password: passwordController.text)
//         .then(
//       (value) async {
//         update(
//
//         );
//         var userUpdateInfo = UserModel();
//         userUpdateInfo.userName = nameController.text;
//         userUpdateInfo.email = emailController.text;
//         await value.user!.updateDisplayName(nameController.text);
//         await value.user!.reload();
//
//         print('displayname= ${userUpdateInfo.userName}');
//       },
//     );
//   }
// }
}
