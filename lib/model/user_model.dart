import 'package:firebase_auth/firebase_auth.dart';

class UserModel{
  String? userName;
  String? email;
  String? role;
  String? uid;

  UserModel({
    this.userName,
    this.email,
    this.role,
    this.uid
  });

  // factory UserModel.fromMap(json) {
  //   return UserModel(
  //     userName: json['userName'],
  //     email: json['email'],
  //     role: json['role'],
  //     uid: json['uid'],
  //   );
  // }

  UserModel.fromMap(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    role = json['role'];
    uid = json['uid'];
  }

  Map<String, dynamic> toMap(){
    return{
      'userName': userName,
      'email': email,
      'role': role,
      'uid': uid,
    };
  }

}

