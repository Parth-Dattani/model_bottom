// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:model_bottom/model/product_response.dart';

class CartProvider with ChangeNotifier {
  List<ProductResponse> cartList = [];
  ProductResponse? cartModel;

  Future getCartData() async {
    List<ProductResponse> newCartList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("cart")
        // .doc(FirebaseAuth.instance.currentUser!.uid)
        // .collection("userCart")
        .get();

    querySnapshot.docs.forEach((element) {
      //cartModel = ProductResponse.fromDocument(element);
      notifyListeners();
      newCartList.add(cartModel!);
    });
    cartList = newCartList;
    notifyListeners();
  }

  List<ProductResponse> get getCartList {
    return cartList;
  }

  double subTotal() {
    double subtotal = 0.0;
    cartList.forEach((element) {
      subtotal += element.price! * element.quantity!;
    });
    return subtotal;
  }
}
