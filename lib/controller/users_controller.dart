import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:model_bottom/controller/base_controller.dart';
import 'package:model_bottom/model/user_model.dart';

class UsersController extends BaseController{


  // static Future<List> getUserTweets(String userId) async {
  //   var userDat;
  //
  //   QuerySnapshot snapshot = await userDat
  //       .doc(userId)
  //       .collection('user')
  //       .get();
  //   //List<UserModel>? userSnap = snapshot.docs.map((doc) => UserModel().fr(doc)).cast<UserModel>().toList();
  //   List<UserModel>? userSnap = snapshot.docs.map((e) => UserModel().toMap())
  //
  //   return userSnap;
  // }

}