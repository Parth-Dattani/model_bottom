import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_bottom/controller/base_controller.dart';

class ForgotPasswordController extends BaseController{
  TextEditingController productNameController = TextEditingController();

  RxString email = "".obs;
}