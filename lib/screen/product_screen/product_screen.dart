import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_bottom/constant/image_path.dart';
import 'package:model_bottom/controller/product_controller.dart';

class ProductScreen extends GetView<ProductController> {
  static const pageId = '/ProductScreen';

  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text(
                controller.isEdit.value == true
                    ? "Edit Product"
                    : "Add Product",
              ),
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new)),
            ),
            body: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
                child: Form(
                  key: controller.productFormKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.white,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                  width: Get.width * 0.30,
                                  height: Get.height * 0.19,
                                  //margin: const EdgeInsets.all(15),
                                  //padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    border:
                                        Border.all(color: Colors.transparent),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.transparent,
                                        offset: Offset(2, 2),
                                        spreadRadius: 2,
                                        blurRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                      borderRadius:
                                          const BorderRadius.all(Radius.zero),
                                      child: controller.isEdit.value == true
                                          ? controller.pickedImage.value == null
                                              ? Image.network(
                                                  controller.imageUrl
                                                      .toString(),
                                                  fit: BoxFit.fill,
                                                )
                                              : Image.file(
                                                  File(controller
                                                      .pickedImage.value!.path),
                                                  fit: BoxFit.fill,
                                                )
                                          : controller.pickedImage.value != null
                                              ? Image.file(
                                                  File(controller
                                                      .pickedImage.value!.path),
                                                  fit: BoxFit.fill,
                                                )
                                              : Image.asset(
                                                  ImagePath.imageLogo,
                                                  fit: BoxFit.fill,
                                                ))),
                              Positioned(
                                  bottom: 2,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      print("picked ing");
                                      print(
                                          controller.pickedImage.value != null);
                                      controller.selectImage();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: const BorderSide(
                                              color: Colors.blue)),
                                      elevation: 5.0,
                                      backgroundColor: Colors.blue,
                                      textStyle:
                                          const TextStyle(color: Colors.white),
                                      //padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                      //splashColor: Colors.grey,
                                      minimumSize: const Size(90, 25),
                                    ),
                                    child: controller.isUpload.value == true &&
                                            controller.imageUrl.value.isEmpty
                                        ? const Text("Upload Image",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ))
                                        : const Text("Edit Image",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            )),
                                  ))
                              /*: Positioned(
                                      bottom: 2,
                                      right: 20,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            //controller.selectImage();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            // shape: RoundedRectangleBorder(
                                            //     borderRadius: BorderRadius.circular(38.0),
                                            //     side: BorderSide(color: Colors.blue)
                                            // ),
                                            elevation: 5.0,
                                            backgroundColor: Colors.transparent,
                                            textStyle: const TextStyle(
                                                color: Colors.white),
                                            // /minimumSize: Size(10, 5),
                                          ),
                                          child: IconButton(
                                            icon: const Icon(Icons.edit),
                                            onPressed: () {},
                                          )),
                                    ),*/
                            ],
                          ),
                        ),
                        // controller.pickedImage.value == null ?Text('please select a product Image') : Container(),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: controller.productNameController,
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

                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: controller.descController,
                          decoration: InputDecoration(
                            filled: true,
                            // fillColor: Colors.white54,
                            labelText: "Description",
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
                              return "please enter descrition";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: Get.width / 2.5,
                              child: TextFormField(
                                controller: controller.productQtyController,
                                decoration: InputDecoration(
                                  filled: true,
                                  // fillColor: Colors.white54,
                                  labelText: "Quantity",
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 8.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please enter product Quantity";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: Get.width / 2.5,
                              child: TextFormField(
                                controller: controller.priceController,
                                decoration: InputDecoration(
                                  filled: true,
                                  // fillColor: Colors.white54,
                                  labelText: "Price",
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 8.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
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
                            ),
                          ],
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
                                  print(
                                      "select${controller.selectedItem.value}");
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
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ));
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (controller.productFormKey.currentState!
                                .validate() /* &&  controller.pickedImage.value != null*/) {
                              if (controller.selectedItem.value.isNotEmpty) {
                                controller.loader.value = true;
                                controller.isEdit.value == true
                                    ? controller.updateProduct()
                                    : controller.addProduct(context);
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        content: Text(
                                  "Please select a Category",
                                )));
                              }
                            }
                            /* else{
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Please select a Product Image" ,)));
                          }*/
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                          ),
                          child: Text(
                              controller.isEdit.value == true ? "Save" : "Add"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          controller.loader.value
              ? const Opacity(
                  opacity: 0.6,
                  child: ModalBarrier(dismissible: false, color: Colors.grey))
              : const SizedBox(),
          controller.loader.value
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.red),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
