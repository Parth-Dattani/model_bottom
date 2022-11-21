import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:model_bottom/constant/image_path.dart';
import 'package:model_bottom/controller/controller.dart';
import 'package:model_bottom/screen/product_screen/product_screen.dart';

class HomeScreen extends GetView<HomeController> {
  static const pageId = '/HomeScreen';

  HomeScreen({super.key});

  final Stream<QuerySnapshot> usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  var getProduct;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: controller.userName.value.isEmpty
            ? null
            : AppBar(
                title: controller.role.value == "admin"
                    ? const Text("Admin")
                    : const Text("HomeScreen"),
                actions: [
                  IconButton(
                      onPressed: () {
                        controller.logOut();
                      },
                      icon: const Icon(Icons.logout))
                ],
              ),
        body: SafeArea(
          child: StreamBuilder(
              stream: usersStream,
              // FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return CircularProgressIndicator();
                // }
                if (snapshot.hasData) {
                  // final user = snapshot.data();
                  return Obx(
                    () => SingleChildScrollView(
                      child: Column(
                        children: [
                          controller.userName.value.isEmpty &&
                                  controller.email.value.isEmpty
                              ? const Center(child: CircularProgressIndicator())
                              : controller.role.value == "admin"
                                  ? adminHomeScreen()
                                  : userHomeScreen(),
                        ],
                      ),
                    ),
                  );
                }
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text("no data"),
                      CircularProgressIndicator()
                    ],
                  ),
                );
              }),
        ),
        drawer: drawer(),
        floatingActionButton: controller.role.value == "admin"
            ? FloatingActionButton.small(
                onPressed: () {
                  Get.toNamed(ProductScreen.pageId, arguments: {
                    'editProduct': controller.isEdit.value = false,
                    'deleteProduct': controller.isDelete.value = false,
                    'proImage': '',
                    'proName': '',
                    'proPrice': '',
                    'proCategory': '',
                    'proDescription': '',
                  });
                },
                child: const Icon(Icons.add))
            : null,
      ),
    );
  }

  Widget adminHomeScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Welcome Admin",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        Row(
          children: [
            Text(
              controller.user!.email.toString(),
              style: const TextStyle(color: Colors.blueAccent),
            ),
            const Spacer(),
            const Text(
              "Users :",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              /*" ${controller.usrCount}+ ,*/
              " ${controller.totalUsers.value} ",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        productList(),
      ],
    );
  }

  Widget userHomeScreen() {
    return SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                  child: Row(
                children: [
                  const Text(
                    "Welcome ",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    controller.userName.value.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.red),
                  ),
//MahmoudHesham099/
                ],
              )),
              Text(controller.user!.email.toString()),
            ],
          ),
          productList(),
        ],
      ),
    );
  }

  Widget drawer() {
    return Obx(
      () => Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ), //BoxDecoration

              child: UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 20,
                      spreadRadius: 0.1,
                      offset: Offset(1, 2), // changes position of shadow
                    ),
                  ],
                  color: Colors.lightBlue,
                ),
                accountName: Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Text(
                    controller.userName.value.toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                accountEmail: Text(controller.user!.email.toString()),
                currentAccountPictureSize: const Size.fromRadius(33),
                currentAccountPicture:
                    Image.asset(ImagePath.profileLogo), //circleAvatar
              ), //UserAccountDrawerHeader
            ),
            Column(
                children: List.generate(
                    controller.drawerItems.length,
                    (index) => ListTile(
                          enabled: controller.loggedInUser.role == "user" &&
                                  controller.drawerItems[index].title == "Users"
                              ? false
                              : true,
                          selected:
                              controller.drawerItems[index].select ?? false,
                          selectedColor: Colors.blue,
                          leading: Icon(
                            controller.drawerItems[index].icon ??
                                (Icons.ssid_chart),
                            color: controller.loggedInUser.role == "user" &&
                                    controller.drawerItems[index].title ==
                                        "Users"
                                ? Colors.grey
                                : Colors.blueAccent,
                            size: 30,
                          ),
                          title: Text(
                            controller.drawerItems[index].title ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          onTap: () {
                            controller.drawerOnTap(index);
                          },
                        ))),
            //drawer List data item
            // ListTile(
            //   //enabled: controller.isMenuSelect.value,
            //   selected: controller.isMenuSelect.value,
            //   selectedColor: Colors.blue,
            //
            //   leading: const Icon(
            //     Icons.person,
            //     color: Colors.blueAccent,
            //     size: 30,
            //   ),
            //   title: const Text(
            //     ' My Profile ',
            //     style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            //   ),
            //   onTap: () {
            //     // controller.selectedIndex.value = 1;
            //     // print("index : ${controller.selectedIndex.value}");
            //     controller.isMenuSelect.value = !controller.isMenuSelect.value;
            //   },
            // ),
            // const Divider(
            //   color: Colors.blueGrey,
            // ),
            // ListTile(
            //   //enabled: controller.isMenuSelect.value,
            //   selected: controller.selectedIndex.value == 2,
            //   selectedColor: Colors.blue,
            //   leading: const Icon(
            //     Icons.percent_rounded,
            //     color: Colors.blueAccent,
            //     size: 30,
            //   ),
            //   title: const Text(
            //     ' Users ',
            //     style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            //   ),
            //   onTap: () {
            //     // controller.selectedIndex.value = 2;
            //     // print("index : ${controller.selectedIndex.value}");
            //     // controller.isMenuSelect.value  = !controller.isMenuSelect.value;
            //   },
            // ),
            // Divider(
            //   color: Colors.blueGrey,
            // ),
            // ListTile(
            //   //enabled: controller.isMenuSelect.value,
            //   selected: controller.isMenuSelect.value,
            //   selectedColor: Colors.blue,
            //   leading: const Icon(
            //     Icons.edit,
            //     color: Colors.blueAccent,
            //     size: 30,
            //   ),
            //   title: const Text(
            //     ' Edit Profile ',
            //     style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            //   ),
            //   onTap: () {
            //     // controller.selectedIndex.value = 3;
            //     // print("index : ${controller.selectedIndex.value}");
            //     // controller.isMenuSelect.value  = !controller.isMenuSelect.value;
            //   },
            // ),
            // Divider(color: Colors.blueGrey),
            // ListTile(
            //   //enabled: controller.isMenuSelect.value,
            //   selected: controller.isMenuSelect.value,
            //   selectedColor: Colors.blue,
            //   leading: const Icon(
            //     Icons.logout,
            //     color: Colors.blueAccent,
            //     size: 30,
            //   ),
            //   title: const Text(
            //     'LogOut',
            //     style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            //   ),
            //   onTap: () {
            //     // controller.selectedIndex.value = 4;
            //     // print("index : ${controller.selectedIndex.value}");
            //     // controller.isMenuSelect.value  = !controller.isMenuSelect.value;
            //     // controller.logOut();
            //   },
            // ),
            // Divider(
            //   color: Colors.blueGrey,
            // ),
          ],
        ),
      ),
    );
  }

  Widget productList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          getProduct = snapshot.data!.docs;
          return Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: GridView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    controller.role.value == "admin"
                        ? print(getProduct[index].get("product_name"))
                        : null;
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            productView(context, getProduct[index]);
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: SizedBox(
                                      child: Stack(
                                    children: [
                                      ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15)),
                                          child:
                                              /*controller.pickedImage.value != null
                                              ? Image.file(
                                            File(controller.pickedImage.value!.path),
                                            fit: BoxFit.fill,
                                          )
                                              :*/
                                              Image.network(
                                            getProduct[index]
                                                .get("imageUrl")
                                                .toString(),
                                          )),
                                      controller.role.value == "admin"
                                          ? Positioned(
                                              right: -1,
                                              bottom: -4,
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                      onPressed: () {
                                                        Get.toNamed(
                                                            ProductScreen
                                                                .pageId,
                                                            arguments: {
                                                              'editProduct':
                                                                  controller
                                                                          .isEdit
                                                                          .value =
                                                                      true,
                                                              'productId':
                                                                  getProduct[
                                                                          index]
                                                                      .get(
                                                                          "productID"),
                                                              'proImage':
                                                                  getProduct[
                                                                          index]
                                                                      .get(
                                                                          "imageUrl"),
                                                              'proName': getProduct[
                                                                      index]
                                                                  .get(
                                                                      "product_name"),
                                                              'proPrice':
                                                                  getProduct[
                                                                          index]
                                                                      .get(
                                                                          "price"),
                                                              'proCategory':
                                                                  getProduct[
                                                                          index]
                                                                      .get(
                                                                          "category"),
                                                              'proDescription':
                                                                  getProduct[
                                                                          index]
                                                                      .get(
                                                                          "description"),
                                                            });
                                                        //productView(context, getProduct[index]);
                                                      },
                                                      icon: const Icon(
                                                        Icons.edit,
                                                        color: Colors.green,
                                                      )),
                                                  IconButton(
                                                      onPressed: () {
                                                        FirebaseFirestore.instance.collection("products").doc(getProduct[index].get("productID")).delete();
                                                        // showDialog(
                                                        //   context: context,
                                                        //   builder: (context) {
                                                        //     return AlertDialog(
                                                        //       title: Container(
                                                        //           color: Colors
                                                        //               .blue,
                                                        //           child: const Text(
                                                        //               "Flutter Product!!")),
                                                        //       content: const Text(
                                                        //           "Product delete ? "),
                                                        //     );
                                                        //   },
                                                        // );
                                                        //Get.toNamed(ProductScreen.pageId,);
                                                      },
                                                      icon: const Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      )),
                                                ],
                                              ))
                                          : const SizedBox(
                                              width: 0,
                                            ),
                                    ],
                                  )),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                dataList("Name : ",
                                    getProduct[index].get(("product_name"))),
                                //dataList("Description", getProduct[index].get("description")),
                                dataList(
                                    "Price : ", getProduct[index].get("price")),
                                dataList("Category : ",
                                    getProduct[index].get("category")),
                                Text(
                                  "Description : ${getProduct[index].get("description")}",
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w500),
                                ),
                                dataList("", ""),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 18,
                  childAspectRatio: 0.65
                  // childAspectRatio: MediaQuery.of(context).size.width /
                  // (MediaQuery.of(context).size.height / 1.4),
                  ),
              itemCount: getProduct.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
            ),
          );
        } else if (snapshot.hasError || snapshot.data == null) {
          return Text("something is wrong : ${snapshot.error}");
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            children: const [
              Text("no data in "),
              Center(child: CircularProgressIndicator()),
            ],
          );
        }
      },
    );
  }

  //for product details
  Widget dataList(title, description) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Text(title,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              )),
        ),
        Expanded(
          child: Text(
            description,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Future productView(context, product) {
    return showDialog(
      context: context,
      builder: (context) {
        return Stack(
          children: [
            SizedBox(
              height: Get.height * 0.75,
              child: AlertDialog(
                title: Container(
                  color: Colors.blue,
                  child: Text(
                    product.get(
                      "product_name",
                    ),
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                content: Column(
                  children: [
                    Image.network(
                      product.get("imageUrl").toString(),
                      fit: BoxFit.fitHeight,
                      height: Get.height * 0.4,
                    ),
                    Text("Category :  ${product.get("category")}"),
                    Text("Price :  ${product.get("price").toString()}"),
                    Text("Description :  ${product.get("description")}"),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0.0,
              right: 20.0,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80)),
                backgroundColor: Colors.white,
                mini: true,
                child: const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                //elevation: 5.0,
              ),
            ),
          ],
        );
      },
    );
  }
}
