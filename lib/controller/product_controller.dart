import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:model_bottom/constant/constant.dart';
import 'package:model_bottom/controller/base_controller.dart';
import 'package:model_bottom/model/product_response.dart';

class ProductController extends BaseController {
  TextEditingController productNameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController productQtyController = TextEditingController();

  final productFormKey = GlobalKey<FormState>();

  List categoryList = ["mobile", "food", "wear", "laptop"];
  List categoryImage = [ImagePath.mobileLogo, ImagePath.profileLogo, ImagePath.imageLogo, ImagePath.googleLogo];

  var selectedItem = "".obs;
  var category = "".obs;

  RxString productImg = "".obs;
  final ImagePicker imagePicker = ImagePicker();

  // XFile? pickedImage;
  final pickedImage = Rxn<XFile>();

  RxBool isUpload = true.obs;
  RxString imageUrl = "".obs;
  RxString productId = "".obs;

  ProductResponse product = ProductResponse();

  @override
  void onInit() {
    clearController();
    // print("Check path value: ${pickedImage.value!.path}");
    isEdit.value = Get.arguments['editProduct'];
    imageUrl.value = Get.arguments['proImage'].toString();
    productId.value = Get.arguments['productId'].toString();
    productNameController.text = Get.arguments['proName'].toString();
    priceController.text = Get.arguments['proPrice'].toString();
    productQtyController.text = Get.arguments['proQuantity'].toString();
    selectedItem.value = Get.arguments['proCategory'].toString();
    descController.text = Get.arguments['proDescription'].toString();
    print(Get.arguments['proImage']);
    print(Get.arguments['proName']);
    print(Get.arguments['proPrice']);
    print(Get.arguments['proQuantity']);
    print(Get.arguments['proCategory']);
    print(Get.arguments['proDescription']);
    print("Product Id : ${productId.value}");
    super.onInit();
  }

  void clearController() {
    productNameController.clear();
    descController.clear();
    priceController.clear();
    productQtyController.clear();
  }

  final currenUserId = FirebaseAuth.instance.currentUser!.uid;

  //add new product
  Future<void> addProduct(context) async {
    await uploadImage();
    await FirebaseFirestore.instance
        .collection("products")
        .doc(productId.value)
        .set(ProductResponse(
      productID: productId.value,
                    productName: productNameController.text,
                    description: descController.text,
                    quantity: int.parse(productQtyController.text),
                    price: int.parse(priceController.text),
                    category: selectedItem.value.toString(),
                    imageUrl: imageUrl.value.toString())
                .toMap())
        .then((value) {
      //uploadImage();
      //print("Added Product Value ${value.id}");
      //value.set({'productID': value.id}, SetOptions(merge: true));
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:
                Container(color: Colors.blue, child: const Text("Flutter!!")),
            content: const Text("Product Added Successfully..."),
          );
        },
      );
      clearController();
      Future.delayed(const Duration(seconds: 3), () {
        //Get.offAndToNamed(HomeScreen.pageId);
        Get.back();
        Get.back();
      });
    });
  }

  //update product
  Future updateProduct() async {
    //loader.value = true;
    productFormKey.currentState!.save();
    if (productFormKey.currentState!.validate()) {

      await uploadImage();
      FirebaseFirestore.instance
          .collection("products")
          .doc(productId.value)
          .update(ProductResponse(
                  productName: productNameController.text,
                  description: descController.text,
                  quantity: int.parse(productQtyController.value.text),
                  price: int.parse(priceController.value.text),
                  category: selectedItem.value.toString(),
                  imageUrl: imageUrl.value.toString(),
                  productID: productId.value)
              .toMap());
      Future.delayed(const Duration(seconds: 5), () {
        Get.back();
        loader.value = false;
      });
      print("Update data ");
    }
  }

  //delete product
  Future deleteProduct() async {
    FirebaseFirestore.instance
        .collection("products")
        .doc(productId.value)
        .delete();
  }

  Future selectImage() async {
    pickedImage.value =
        await imagePicker.pickImage(source: ImageSource.gallery);

    //if (pickedImage.value != null) {
    print('picked Image path: ${pickedImage.value!.path} ');
    imageUrl.value = pickedImage.value!.path;
    isUpload.value = false;
    //}
  }

  Future uploadImage() async {
    print("loader value sd:  ${loader.value.toString()} ");
    print("loader value sd:  ${productId.toString()} ");
    final path = 'productImages/${productId.toString()}_${productNameController.text}';
    //final path = 'productImages/${productNameController.value.text.trim()}${currenUserId}';
    //final path = 'productImages/${productNameController.value.text} ${DateTime.now()}';
    print(path);
    final file = File(pickedImage.value!.path);
    print("File $file");

    final ref = FirebaseStorage.instance.ref().child(path);
    await ref.putFile(file);

    imageUrl.value = await ref.getDownloadURL();
    print("download Url : $imageUrl.value");

    isUpload.value = false;
  }
}
