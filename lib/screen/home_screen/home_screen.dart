import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_bottom/constant/image_path.dart';
import 'package:model_bottom/controller/controller.dart';
import 'package:model_bottom/model/product_response.dart';
import 'package:model_bottom/screen/cart_screen/cart_screen.dart';
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
                    //deleteProduct': controller.isDelete.value = false,
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

  //get all products
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
                return Column(
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
                                          getProduct[index].get("imageUrl")
                                              .toString(),
                                        )),
                                    controller.role.value == "admin"
                                        ? Positioned(
                                            right: -5,
                                            //left: -,
                                            bottom: -4,
                                            child: SizedBox(
                                              // width: Get.width * 0.33,
                                              child: Row(
                                                //crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                                                      "productName"),
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
                                                        //size: ,
                                                        color: Colors.green,
                                                      )),
                                                  IconButton(
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: Container(
                                                                  color: Colors
                                                                      .blue,
                                                                  child: const Text(
                                                                      "Flutter Product!!")),
                                                              content: const Text(
                                                                  "Are You Sure Product delete ? "),
                                                              actions: [
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Get.back();
                                                                    },
                                                                    child: const Text(
                                                                        "Cancel")),
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      controller.deleteProduct(
                                                                          context,
                                                                          getProduct[
                                                                              index]);
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(const SnackBar(
                                                                              content: Text(
                                                                        "Product delete Succesfully",
                                                                      )));
                                                                    },
                                                                    child: const Text(
                                                                        "Delete")),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                      icon: const Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      )),
                                                ],
                                              ),
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
                                  getProduct[index].get("productName")),
                              //dataList("Description", getProduct[index].get("description")),
                              dataList("Price : ",
                                  getProduct[index].get("price").toString()),
                              dataList("Category : ",
                                  getProduct[index].get("category")),
                              dataList("Qty : ",
                                  getProduct[index].get("quantity").toString()),
                              /*Text(
                                "Description : ${getProduct[index].get("description")}",
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w500),
                              ),*/
                              dataList("", ""),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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
          width: 80,
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(title,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                )),
          ),
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

  //product display at cardView
  Future productView(context, product) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Stack(
          children: [
            SizedBox(
              height: Get.height * 0.9,
              //width: Get.width,
              child: AlertDialog(
                title: Container(
                  color: Colors.blue,
                  child: Text(
                    product.get(
                      "productName",
                    ),
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                content: Column(
                  children: [
                    Image.network(
                      product.get("imageUrl").toString(),
                      fit: BoxFit.fill,
                      height: Get.height * 0.5,
                      width: Get.width,
                    ),
                    Text("Category :  ${product.get("category")}"),
                    Text("Price :  ${product.get("price").toString()}"),
                    Text("Description :  ${product.get("description")}"),
                    ElevatedButton(
                        onPressed: () async {
                          print("pid... ${product.get("productID").toString()}");
                          var value = await FirebaseFirestore.instance
                              .collection("cart")
                              .get();

                          for (int i = 0; i < value.docs.length; i++) {
                            if (value.docs[i].get('productID') == product.get("productID")) {
                              print("Return");
                             //controller.s.value = controller.quantity.value.toString();
//                             controller.s.value = value.docs[i].get("quantity")+1;
                              //print(controller.quantity.value);
                              //print("S quantity value : ${controller.s.toString()}");

                              //controller.quantityUpdate(controller.s.value.toString());
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Item already in your cart")));
                              Get.back();
                              return;
                            }
                          }
                          // value.docs.map((e) {
                          //   print("cart product id: ${e.get('productID')}");
                          //   if (e.get('productID') ==
                          //       product.get("productID")) {
                          //     print("Return");
                          //     return;
                          //   }
                          // });

                          print("Not Return");
                          FirebaseFirestore.instance
                              .collection('cart')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection('cart_2')
                              .doc(product.get("productID").toString(),)
                              .set(ProductResponse(
                                productName: product.get("productName"),
                                description: product.get("description"),
                                quantity: controller.quantity.value,
                                price: product.get("price"),
                                category: product.get("category"),
                                imageUrl: product.get("imageUrl"),
                                productID: product.get("productID").toString(),
                              ).toMap());
                          //     .then((value) {
                          //   value.set(
                          //       {"cartID": value.id}, SetOptions(merge: true));
                          // });


                          /* .where(product.get("productID").toString()*/
                          // FirebaseFirestore.instance.collection("products").doc(product.pr)
                          // )
                          //     .add(ProductResponse(
                          //       productName: product.get("productName"),
                          //       description: product.get("description"),
                          //       quantity: controller.quantity,
                          //       price: product.get("price"),
                          //       category: product.get("category"),
                          //       imageUrl: product.get("imageUrl"),
                          //       productID: product.get("productID").toString(),
                          //     ).toMap())
                          //     .then((value) {
                          //   value.set(
                          //       {"cartID": value.id}, SetOptions(merge: true));
                          // });
                          //Get.back();
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Item's are added in your cart")));
                          Get.back();
                          //Get.offAndToNamed(CartScreen.pageId,);

                        },
                        child: const Text("Add Cart")),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0.0,
              right: 35.0,
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
