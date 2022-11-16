import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_bottom/controller/base_controller.dart';

import '../screen/screen.dart';

class ProductController extends BaseController {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  final productFormKey = GlobalKey<FormState>();

  List categoryList = ["mobile", "food", "wear", "laptop"];

  var selectedItem = "".obs;
  var category = "".obs;

  @override
  void onInit() {
    super.onInit();
    clearController();
  }

  void clearController(){
    nameController.clear();
    priceController.clear();
  }

  Future<void> addProduct(context) async {
    if (productFormKey.currentState!.validate()) {
      FirebaseFirestore.instance.collection("products").add({
        "product_name": nameController.text,
        "price": priceController.text,
        "category": selectedItem.value.toString()
      }).then((value) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Container(color: Colors.blue, child: const Text("Flutter!!")),
              content: const Text("Product Added Successfully..."),
            );
          },
        );
        clearController();
        Future.delayed(const Duration(seconds: 10),(){
         //Get.offAndToNamed(HomeScreen.pageId);
          Get.back();
          Get.back();
        });
      });
    }
  }
}
