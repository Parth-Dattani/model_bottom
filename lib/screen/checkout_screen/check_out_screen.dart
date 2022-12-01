import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:model_bottom/constant/text_style.dart';
import 'package:model_bottom/controller/check_out_controller.dart';
import 'package:model_bottom/screen/checkout_screen/payment.dart';
import 'package:model_bottom/widgets/common_button.dart';

import '../../widgets/widgets.dart';



class CheckOutScreen extends GetView<CheckOutController>{
static const pageId ='/CheckOutScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:
      AppBar(

        title: Text("CheckOut"),
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new)),),
      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            children: [
              CommonTextFormField(
                controller: controller.addressController,
                //multiLine: false,
                labelText: "enter address",

                validator: (value){
                  if(value!.isEmpty){
                    return "please enter address";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15,),


              Row(
                children: [
                  SizedBox(
                    width: Get.width/2.5,
                    child: CommonTextFormField(
                      controller: controller.cityController,
                      labelText: "city",
                      validator: (value){
                        if(value!.isEmpty){
                          return "please enter city";
                        }
                        return null;
                      },
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: Get.width/2.5,
                    child: CommonTextFormField(
                      controller: controller.stateController,
                      labelText: "state",
                      validator: (value){
                        if(value!.isEmpty){
                          return "please enter state";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15,),

              CommonTextFormField(
                controller: controller.pincodeController,
                labelText: "pincode",
                validator: (value) {
                  if(value!.isEmpty){
                    return "please enter pincode";
                  }
                  return null;
                },
              ),

              Container(
                margin: const EdgeInsets.all(20),
                width: Get.width * 0.8,
                height: Get.height/2,
                child: Card(

                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(28.0),
                      side: const BorderSide(
                          color: Colors.white10)),
                  elevation: 12,
                  child:
                  Column(
                    children: [
                     const ListTile(
                        leading: Text("Sub Total"),
                        trailing: Text("\₹ subTotal"),
                      ),
                     const ListTile(
                        leading: Text("Discount"),
                        trailing: Text("5%"),
                      ),
                      const ListTile(
                        leading: Text("Shipping Charge"),
                        trailing: Text("₹10"),
                      ),
                       const Divider(
                        thickness: 2,
                      ),
                      ListTile(
                        leading: Text("Total"),
                        trailing: Text("\₹ ${controller.subTotal}"),
                      ),
                  //Text("object:${controller.getCartData.length}");
                  //   for (int i = 0; i <=3 - 1; i++) {
          //     Text("============================================");
          //     Text("Item ${i + 1}: ");
          //     Text("price:${controller.getCartData[i]['price']}");
          //     Text("Qty:${controller.getCartData[i]['quantity']}");
          //     controller.total = controller.getCartData[i]['quantity'] *
          //     controller.getCartData[i]['price'];
          //     controller.subTotal += controller.total;
          //     Text("total: $controller.total");
          //     // tot =  controller.getCartData[i]['quantity'] * controller.getCartData[i]['price'];
          //     // print(tot);
          //     }
          //         print("============================================");
          //   print("Sub Total : ${controller.subTotal}");
          // print("============================================");
          //
          //             Text(controller.addressController.text),
          //             Text(controller.cityController.text),
          //             Text(controller.stateController.text),
          //             Text(controller.pincodeController.text),
SizedBox(height: 20,),
                      Text("Your Total Billing is ", style: CustomTextStyle.billText,),
                      Text(controller.subTotal.toString(),style: CustomTextStyle.HighLightBillText),
                      Text("data"),
                      //printError("1115-805 : 8:50")

                      CommonButton(
                        width: Get.width*0.5,
                        color: Colors.indigo,
                        onPressed: (){
                          Get.toNamed(PaymentPage.pageID);

                        },
                        child: Text("Pay"),
                      )
                    ],
                  ),
                ),
              ),

            ],

          ),
        ),
      ),
    );
  }
  
}


