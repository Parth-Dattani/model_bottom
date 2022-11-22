import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:model_bottom/controller/base_controller.dart';

class CartController extends BaseController{



  RxString productName = "".obs;
 // RxString productCategory = "".obs;
  RxString imageUrl = "".obs;
  RxString description = "".obs;
  RxString price = "".obs;
  RxString productId = "".obs;

  var selectedItem = "".obs;
  var category = "".obs;

  RxList cartData = [].obs;

  var getCartData;

  void onInit() {
    //clearController();
    // productId.value = Get.arguments['productId'].toString();
    // imageUrl.value = Get.arguments['proImage'].toString();
    // productName.value = Get.arguments['proName'].toString();
    // price.value = Get.arguments['proPrice'].toString();
    // selectedItem.value = Get.arguments['proCategory'].toString();
    // description.value = Get.arguments['proDescription'].toString();
    // print(Get.arguments['productId']);
    // print(Get.arguments['proName']);
    // print(Get.arguments['proPrice']);
    // print(Get.arguments['proCategory']);
    // print(Get.arguments['proDescription']);
    //
    // cartData.add(productId);
    print("cart Data: $cartData");
    print("cart image: $imageUrl");
    //print("Product Id : ${productId.value}");
    super.onInit();
  }

  Future deleteCart(context, cartIndex) async {
    await FirebaseFirestore.instance
        .collection("cart")
        .doc(cartIndex.get("cartID"))
        .delete();

  }


}