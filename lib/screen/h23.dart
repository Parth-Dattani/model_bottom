// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
//
// import '../constant/constant.dart';
//
// class CommonAppBar extends StatelessWidget with PreferredSizeWidget {
//   final String? leadingIcon;
//   final String? title;
//
//   final String? titleIcon;
//   final VoidCallback? backOnTap;
//   final bool? isSearch;
//   final VoidCallback? searchOnTap;
//   final TextEditingController? controller;
//   final String Function(String)? onChange;
//   final VoidCallback? cancelOnTap;
//   final bool? isSearchVisible;
//   final bool? isCropVisible;
//   final VoidCallback? cropOnTap;
//
//   const CommonAppBar(
//       {Key? key,
//         this.leadingIcon,
//         this.title,
//         this.titleIcon,
//         this.backOnTap,
//         this.searchOnTap,
//         this.isSearch = false,
//         this.controller,
//         this.onChange,
//         this.cancelOnTap,
//         this.isSearchVisible = true,
//         this.isCropVisible = false,
//         this.cropOnTap})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       elevation: 0.0,
//       backgroundColor: Colors.transparent,
//       toolbarOpacity: 0.0,
//       systemOverlayStyle: const SystemUiOverlayStyle(
//           systemNavigationBarIconBrightness: Brightness.dark),
//       brightness: Brightness.dark,
//       bottomOpacity: 0.0,
//       centerTitle: true,
//       leading: GestureDetector(
//         onDoubleTap: null,
//         onTapDown: null,
//         onLongPress: null,
//         onTap: backOnTap ??
//                 () {
//               Get.back();
//             },
//         child: leadingIcon != ''
//             ? Image.asset(
//           ImagePath.backArrow,
//           scale: 25.0,
//         )
//             : Center(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 8.0),
//               child: Text(
//                 "Done",
//                 style: CustomTextStyle.orangeProfileTextStyle,
//               ),
//             )),
//       ),
//       title: isSearch == false
//           ? titleIcon != null
//           ? Row(
//         children: [
//           Image.asset(
//             titleIcon.toString(),
//             scale: 20.0,
//           ),
//           const SizedBox(
//             width: 15.0,
//           ),
//           Flexible(
//             child: Text(
//               title.toString(),
//               overflow: TextOverflow.ellipsis,
//               style: CustomTextStyle.orangeAppBarTextStyle,
//             ),
//           ),
//         ],
//       )
//           : Text(
//         title.toString(),
//         style: CustomTextStyle.orangeAppBarTextStyle,
//       )
//           : TextFormField(
//         style: CustomTextStyle.orangeNormalTextStyle,
//         autofocus: true,
//         cursorColor: ColorsConfig.colorOrange,
//         controller: controller,
//         textInputAction: TextInputAction.search,
//         // onChanged: onChange,
//         onFieldSubmitted: onChange,
//         decoration: InputDecoration(
//           isDense: true,
//           hintText: "search".tr,
//           hintStyle: CustomTextStyle.orangeNormalTextStyle,
//           enabledBorder: const UnderlineInputBorder(
//             borderSide:
//             BorderSide(color: ColorsConfig.colorOrange, width: 1.0),
//           ),
//           focusedBorder: const UnderlineInputBorder(
//             borderSide:
//             BorderSide(color: ColorsConfig.colorOrange, width: 1.0),
//           ),
//           // suffixIcon: GestureDetector(
//           //   onTap: cancelOnTap,
//           //     child: Image.asset(ImagePath.cancelImage, scale: 20,color: ColorsConfig.colorOrange,))
//         ),
//       ),
//       actions: [
//         isSearch == false
//             ? Visibility(
//           visible: isSearchVisible!,
//           child: IconButton(
//             icon: Image.asset(
//               ImagePath.searchImage,
//               scale: 20.0,
//               color: ColorsConfig.colorOrange,
//             ),
//             onPressed: searchOnTap,
//           ),
//         )
//             : IconButton(
//             onPressed: cancelOnTap,
//             icon: Image.asset(
//               ImagePath.cancelImage,
//               scale: 20,
//               color: ColorsConfig.colorOrange,
//             )),
//         Visibility(
//           visible: isCropVisible!,
//           child: IconButton(
//             icon: Image.asset(
//               ImagePath.editIcon,
//               scale: 20.0,
//               color: ColorsConfig.colorOrange,
//             ),
//             onPressed: cropOnTap,
//           ),
//         )
//       ],
//     );
//   }
//
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
//
//








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
