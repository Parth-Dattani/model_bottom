import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:model_bottom/constant/constant.dart';
import 'package:model_bottom/controller/base_controller.dart';
import 'package:model_bottom/model/product_response.dart';

import '../screen/notification/notification_service.dart';

class ProductController extends BaseController {
  TextEditingController productNameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController productQtyController = TextEditingController();

  final productFormKey = GlobalKey<FormState>();

  List categoryList = ["mobile", "food", "wear", "laptop"];
  List categoryImage = [
    ImagePath.mobileLogo,
    ImagePath.profileLogo,
    ImagePath.imageLogo,
    ImagePath.googleLogo
  ];

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
      Future.delayed(const Duration(seconds: 3), () async {
        //Get.offAndToNamed(HomeScreen.pageId);
        Get.back();
        Get.back();
        print("Awesome Notification called...");
        // NotificationService.awesomeNoti();

        var addToken = <String>[];

        //when new product add displaying i
        var user = await FirebaseFirestore.instance.collection('users').get();
        print("user ${user.docs}");
        user.docs
            .where((element) =>
                element.get('uid') != FirebaseAuth.instance.currentUser!.uid)
            .map((e) => addToken.add(e.get('registerToken')))
            .toList();
        sendPushMessage(
            productNameController.text, descController.text, addToken);
        print("dfgg");

        // var not = FirebaseMessaging.instance;
        // not.sendMessage();
        /*    NotificationService.showNotification(
          id: 0,
          title: "E-commerce",
          body: "Hello, user this for only Testing purpose.",
          //payload: "E-commerce",
        );*/
        // AwesomeNotifications()
        //     .createNotification(
        //     content: NotificationContent(
        //         id: 101,
        //         channelKey: 'AddProduct',
        //       title: "New Product Arrived",
        //       body: "Hurry Up!! New Product Selling Fast",
        //         payload: {'notificationId': '1234567890'},),
        //         actionButtons: [
        //           NotificationActionButton(key: 'REDIRECT', label: 'Redirect'),
        //           NotificationActionButton(
        //               key: 'REPLY',
        //               label: 'Reply Message',
        //               requireInputText: true,
        //               actionType: ActionType.SilentAction
        //           ),
        //           NotificationActionButton(
        //               key: 'DISMISS',
        //               label: 'Dismiss',
        //               actionType: ActionType.DismissAction,
        //               isDangerousOption: true)
        //         ]
        //
        // );
      });
    });
  }

  void sendPushMessage(String body, String title, token) async {
    // try {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAALJWWpsM:APA91bHX0cWCrrm-iBCc3gnCIoS-INlik21hwhJ37OC4yMhx5L_d_RYVQn9m88L0nBn0xZSk_scIkL8BS6PwP_SEGVFIPulDZgbuiH9GWup-lowR0-TCcq_-MmvWoY6O4AAT63wdz1gH',
      },
      // {
      //   "registration_ids": ["device_token"],
      //   "notification": {
      //     "title": "FCM",
      //     "body": "messaging tutorial"
      //   },
      //   "data": {
      //     "msgId": "msg_12342"
      //   }
      // }
      body: jsonEncode(<String, dynamic>{
        "registration_ids": token,
        'notification': <String, dynamic>{
          'body': body,
          'title': title,
        },
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          'status': 'done'
        }
        // "to": token,
      }),
    );
    print('done');
    // } catch (e) {
    //   print("error push notification");
    // }
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
    final path = 'productImages/${productId.toString()}';
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
