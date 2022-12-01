// // ignore_for_file: avoid_print, unused_element, prefer_const_constructors
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import '../home_screen/home_screen.dart';
//
// class PhoneScreen extends StatefulWidget {
//   static const pageId = '/PhoneScreen';
//   const PhoneScreen({Key? key}) : super(key: key);
//
//   @override
//   State<PhoneScreen> createState() => _PhoneScreenState();
// }
//
// class _PhoneScreenState extends State<PhoneScreen> {
//
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController otpController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//
//   FirebaseAuth auth = FirebaseAuth.instance;
//   bool otpVisibility = false;
//   User? user;
//   String verificationID = "";
//
//   String text = '';
//
//   void _onKeyboardTap(String value) {
//     setState(() {
//       text = text + value;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Phone Auth",
//           style: TextStyle(
//             fontSize: 30,
//           ),
//         ),
//         backgroundColor: Colors.red,
//       ),
//       body: Container(
//         margin: EdgeInsets.all(10),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(
//                 hintText: 'User Name',
//                 prefix: Padding(
//                   padding: EdgeInsets.all(4),
//                   child: Padding(
//                     padding: EdgeInsets.only(top: 8.0),
//                     child: Icon(Icons.person),
//                   ),
//                 ),
//               ),
//               maxLength: 10,
//               keyboardType: TextInputType.text,
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             TextField(
//               controller: phoneController,
//               decoration: const InputDecoration(
//                 hintText: 'Phone Number',
//                 prefix: Padding(
//                   padding: EdgeInsets.all(4),
//                   child: Text('+91'),
//                 ),
//               ),
//               maxLength: 10,
//               keyboardType: TextInputType.phone,
//             ),
//             Visibility(
//               visible: otpVisibility,
//               child:  TextField(
//                 controller: otpController,
//                 decoration: const InputDecoration(
//                   hintText: 'OTP',
//                   prefix: Padding(
//                     padding: EdgeInsets.all(4),
//                     child: Text(''),
//                   ),
//                 ),
//                 maxLength: 6,
//                 keyboardType: TextInputType.number,
//               ),
//             ),
//
//             const SizedBox(
//               height: 10,
//             ),
//
//
//             MaterialButton(
//               color: Colors.red[900],
//               onPressed: () {
//                 if (otpVisibility) {
//                   verifyOTP();
//                 } else {
//                   loginWithPhone();
//                 }
//               },
//               child: Text(
//                 otpVisibility ? "Verify" : "Login",
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void loginWithPhone() async {
//     auth.verifyPhoneNumber(
//       phoneNumber: "+91${phoneController.text}",
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         await auth.signInWithCredential(credential).then((value) {
//           print("You are logged in successfully");
//           print(value);
//         });
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         print(e.message);
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         otpVisibility = true;
//         verificationID = verificationId;
//         setState(() {});
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {},
//     );
//   }
//
//   void verifyOTP() async {
//     PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationID, smsCode: otpController.text);
//
//     await auth.signInWithCredential(credential).then(
//           (value) {
//         setState(() {
//           user = FirebaseAuth.instance.currentUser;
//         });
//       },
//     ).whenComplete(
//           () {
//         if (user != null) {
//           Fluttertoast.showToast(
//             msg: "You are logged in successfully",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.red,
//             textColor: Colors.white,
//             fontSize: 16.0,
//           );
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) =>   HomeScreen(),
//             ),
//           );
//         } else {
//           Fluttertoast.showToast(
//             msg: "your login is failed",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.red,
//             textColor: Colors.white,
//             fontSize: 16.0,
//           );
//         }
//       },
//     );
//   }
//
//   Widget otpNumberWidget(int position) {
//     try {
//       return Container(
//         height: 40,
//         width: 40,
//         decoration: BoxDecoration(
//             border: Border.all(color: Colors.black, width: 0),
//             borderRadius: const BorderRadius.all(Radius.circular(8))
//         ),
//         child: Center(child: Text(text[position], style: const TextStyle(color: Colors.black),)),
//       );
//     } catch (e) {
//       return Container(
//         height: 40,
//         width: 40,
//         decoration: BoxDecoration(
//             border: Border.all(color: Colors.black, width: 0),
//             borderRadius: const BorderRadius.all(Radius.circular(8))
//         ),
//       );
//     }
//   }
//
//
// }
