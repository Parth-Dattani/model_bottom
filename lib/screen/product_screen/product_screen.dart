import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:model_bottom/constant/image_path.dart';
import 'package:model_bottom/controller/product_controller.dart';

class ProductScreen extends GetView<ProductController> {
  static const pageId = '/ProductScreen';

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Product",
          ),
          leading: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
            child: Form(
              key: controller.productFormKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey, shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 35, bottom: 25.0, left: 35, right: 35),
                        child: Column(
                          children: [
                            IconButton(icon: Icon(Icons.add), onPressed: () {}),
                            Text("product Image")
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: controller.nameController,
                      decoration: InputDecoration(
                        filled: true,
                        // fillColor: Colors.white54,
                        labelText: "productName",
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter product name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: controller.priceController,
                      decoration: InputDecoration(
                        filled: true,
                        // fillColor: Colors.white54,
                        labelText: "Price",
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter price";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      //margin: EdgeInsets.only(left: 15, top: 0, right: 15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                            hint: Text(
                              controller.selectedItem.value.isNotEmpty
                                  ? controller.selectedItem.value.toString()
                                  : "Select category",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontFamily: "verdana_regular",
                              ),
                            ),
                            isExpanded: true,
                            isDense: true,
                            onChanged: (value) {
                              controller.selectedItem.value = value!;
                              print("select" +
                                  controller.selectedItem.value.toString());
                            },
                            items: controller.categoryList.map((item) {
                              return DropdownMenuItem(
                                  value: item.toString(),
                                  child: Row(
                                    children: [
                                      // CircleAvatar(
                                      //   backgroundImage:  Image.asset(ImagePath.profileLogo),
                                      // ),
                                      // SizedBox(
                                      //   width: 15,
                                      // ),
                                      Text(
                                        item,
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                    ],
                                  ));
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.addProduct(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                      ),
                      child: const Text("Add"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
