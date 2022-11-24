import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:model_bottom/constant/text_style.dart';
import 'package:model_bottom/controller/check_out_controller.dart';
import 'package:model_bottom/widgets/common_button.dart';

import '../../widgets/widgets.dart';

class CheckOutScreen extends GetView<CheckOutController>{
static const pageID ='/CheckOutScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

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
                      controller: controller.cityController,
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

              SizedBox(height: 15,),

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
                margin: EdgeInsets.all(20),
                width: Get.width * 0.8,
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
                      Text("Your Total Billing is ", style: CustomTextStyle.billText,),
                      Text(controller.total.toString(),style: CustomTextStyle.HighLightBillText),
                      Text("data"),
                      //printError("1130-830 : 8:30")

                      CommonButton(
                        width: Get.width*0.5,
                        color: Colors.indigo,
                        onPressed: (){},
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