import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_bottom/controller/base_controller.dart';
import 'package:model_bottom/model/product_response.dart';
import 'package:model_bottom/screen/screen.dart';
import '../model/model.dart';
import '../utill/utill.dart';

class HomeController extends BaseController {
  final auth = FirebaseAuth.instance;

  CollectionReference ref = FirebaseFirestore.instance.collection('user');
  User? user = FirebaseAuth.instance.currentUser;

  Rx<String> userName = "".obs;
  Rx<String> email = "".obs;
  Rx<String> role = "".obs;
  Rx<String> uid = "".obs;
  UserModel loggedInUser = UserModel();
  //var usrCount = 0;
  Rxn<String> totalUsers = Rxn<String>();
  RxList<SelectDrawer> drawerItems = RxList<SelectDrawer>();
  Rx<int> selectedIndex = 0.obs;

  final Stream<QuerySnapshot> usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  RxBool isAdmin = false.obs;
  Rxn<bool> isAdmin2 = Rxn<bool>();

  @override
  void onInit() {
    super.onInit();
    initList();

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((values) {
      loggedInUser = UserModel.fromMap(values.data()!);
      userName.value = loggedInUser.userName.toString();
      email.value = loggedInUser.email.toString();
      role.value = loggedInUser.role.toString();
    });
    countUsers();

    var userRole = loggedInUser.role.toString();

    if (userRole.toString() == "admin") {
      isAdmin.value = !isAdmin.value;
      isAdmin2.value = !isAdmin2.value!;
    }
  }

  initList() {
    drawerItems
        .add(SelectDrawer(title: "Home", icon: Icons.home, select: false));
    drawerItems
        .add(SelectDrawer(title: "Users", icon: Icons.person, select: false));
    drawerItems.add(
        SelectDrawer(title: "Edit Profile", icon: Icons.edit, select: false));
    drawerItems.add(
        SelectDrawer(title: "Cart", icon: Icons.shopping_cart, select: false));
    drawerItems
        .add(SelectDrawer(title: "Log out", icon: Icons.logout, select: false));
  }

  drawerOnTap(index) {
    print("se index 2 : ${drawerItems[index].select}" == true);
    drawerItems[index].select = !drawerItems[index].select!;
    drawerItems
        .where((element) => element.title != drawerItems[index].title)
        .map((e) => e.select = false)
        .toList();
    drawerItems.refresh();
    print("se index : ${drawerItems[index]}");

    // if(loggedInUser.role == 'admin'){
    //   drawerItems[index].title == "Users"
    // }

    //Navigation page

    drawerItems[index].title == "Users"
        ? Get.toNamed(UsersScreen.pageId)
        : drawerItems[index].title == "Edit Profile"
            ? Get.toNamed(ProfileScreen.pageId, arguments: [
                {'name': loggedInUser.userName.toString()},
                {'email': loggedInUser.email},
                {'role': loggedInUser.role},
              ]) :
    drawerItems[index].title == "Cart" ? Get.toNamed(CartScreen.pageId)
            : drawerItems[index].title == "Log out"
                ? logOut()
                : Get.context;
  }

  Future<void> logOut() async {
    const CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    sharedPreferencesHelper.clearPrefData();
    Get.offAllNamed(LoginScreen.pageId);
  }

  final CollectionReference<Map<String, dynamic>> userList =
      FirebaseFirestore.instance.collection('users');

  //get count of total user
  Future<void> countUsers() async {
    AggregateQuerySnapshot query = await userList.count().get();
    debugPrint('The number of users: ${query.count}');
    //usrCount = query.count;
    totalUsers.value = query.count.toString();
  }

  Future deleteProduct(context, productIndex) async {
    await FirebaseFirestore.instance
        .collection("products")
        .doc(productIndex.get("productID"))
        .delete();

    print("delete image url");
    print(FirebaseStorage.instance.refFromURL(productIndex.get("imageUrl")));
    FirebaseStorage.instance.refFromURL(productIndex.get("imageUrl")).delete();

    Get.back();
  }

  // Future addToCart() async {
  //   await FirebaseFirestore.instance.collection("cart").add(
  //     ProductResponse(
  //       imageUrl: ima,
  //       category: ,
  //       price: ,
  //       description: ,
  //       productName: ,
  //     ).toMap()
  //   );
  // }
}

class SelectDrawer {
  String? title;
  IconData? icon;
  bool? select;

  SelectDrawer({this.title, this.icon, this.select});
}
