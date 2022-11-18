// Container(
//
// child: FormField<String>(
// builder: (FormFieldState<String> state) {
// return InputDecorator(
// decoration: InputDecoration(
// contentPadding:
// EdgeInsets.fromLTRB(12, 10, 20, 20),
// errorText: "_error",
// errorStyle: TextStyle(
// color: Colors.redAccent, fontSize: 16.0),
// border: OutlineInputBorder(
// borderRadius:
// BorderRadius.circular(10.0)),),
//
//
// child: DropdownButtonHideUnderline(
// child: DropdownButton(
// style: const TextStyle(
// fontSize: 16,
// color: Colors.grey,
// ),
// hint: Text(
// controller.selectedItem.value.isNotEmpty
// ? controller.selectedItem.value.toString()
//     : "Select category",
// style: TextStyle(
// color: Colors.grey,
// fontSize: 16,
// fontFamily: "verdana_regular",
// ),
// ),
// isExpanded: true,
// isDense: true,
// onChanged: (value) {
// controller.selectedItem.value = value!;
// print("select" +
// controller.selectedItem.value.toString());
// },
// items: controller.categoryList.map((item) {
// return DropdownMenuItem(
// value: item.toString(),
// child: Row(
// children: [
// Text(
// item,
// style: TextStyle(
// fontSize: 15,
// color: Colors.black),
// ),
// ],
// ));
// }).toList(),
// ),
// ),
// );
// })),

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class AuthService {
//   static final _auth = FirebaseAuth.instance;
//   static final _fireStore = FirebaseFirestore.instance;
//
//   static Future<bool> signUp(String name, String email, String password) async {
//     try {
//       UserCredential authResult = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//
//       User signedInUser = authResult.user;
//
//       if (signedInUser != null) {
//         _fireStore.collection('users').doc(signedInUser.uid).set({
//           'name': name,
//           'email': email,
//           'profilePicture': '',
//           'coverImage': '',
//           'bio': ''
//         });
//         return true;
//       }
//
//       return false;
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }
//
//   static Future<bool> login(String email, String password) async {
//     try {
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//       return true;
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }
//
//   static void logout() {
//     try {
//       _auth.signOut();
//     } catch (e) {
//       print(e);
//     }
//   }
// }
