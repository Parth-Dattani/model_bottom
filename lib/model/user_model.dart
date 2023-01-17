class UserModel{
  String? userName;
  String? registerToken;
  String? email;
  String? role;
  String? uid;

  UserModel({
    this.userName,
    this.registerToken,
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
    registerToken = json['registerToken'];
    email = json['email'];
    role = json['role'];
    uid = json['uid'];
  }

  Map<String, dynamic> toMap(){
    return{
      'userName': userName,
      'registerToken': registerToken,
      'email': email,
      'role': role,
      'uid': uid,
    };
  }

}

