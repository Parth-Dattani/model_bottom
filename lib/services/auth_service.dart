// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// import '../model/model.dart';
//
// class AuthService{
//   static final auth = FirebaseAuth.instance;
//   static final firebaseFirestore = FirebaseFirestore.instance;
//
//
//  static Future signUp(
//       String userName, String email, String password, String rool) async {
//     print("success");
//     // loader.value = true;
//     // CircularProgressIndicator();
//     await auth
//         .createUserWithEmailAndPassword(email: email, password: password)
//         .then((value) => {sendDataFirestore(userName, email, rool)})
//         .catchError((e) {});
//   }
//
//   //user store in firestore
//   static sendDataFirestore(String userName, String email, String rool) async {
//     User? user = auth.currentUser;
//     UserModel userModel = UserModel();
//     userModel.userName = userName;
//     userModel.email = email;
//     userModel.uid = user!.uid;
//     userModel.role = rool;
//     await firebaseFirestore
//         .collection("users")
//         .doc(user.uid)
//         .set(userModel.toMap());
//   }
//
//   static Future<void> logOut() async {
//     await FirebaseAuth.instance.signOut();
//   }
//
// }