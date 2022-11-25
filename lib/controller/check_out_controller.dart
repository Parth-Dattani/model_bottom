import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:model_bottom/controller/base_controller.dart';

class CheckOutController extends BaseController{

  var price, qty, total, subTotal;
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pincodeController = TextEditingController();

  void onInit(){
    price = Get.arguments['price'];
    qty = Get.arguments['qty'];
    total = Get.arguments['total'];
    subTotal = Get.arguments['subTotal'];

    print("price from Cart page : $price");
    print("qty from Cart page : $qty");
    print("total from Cart page : $total");
    print("Subtotal from Cart page : $subTotal");
    super.onInit();
  }

}