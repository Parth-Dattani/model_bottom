import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_bottom/controller/base_controller.dart';

class TypesAhedController extends BaseController{

  final typeAhedController = TextEditingController();

  List<String> suggestionList = [
    "hello",
    "one",
    "Two",
    "Hei",
    "Three",
    "Hi"
  ];

  List<IconData> iconList = [
    Icons.add_alert_rounded,
    Icons.coffee_sharp,
    Icons.ac_unit,
    Icons.access_alarms_rounded,
    Icons.accessibility_new_outlined,
    Icons.account_balance_outlined,
  ];

  Future<List<String>> getSuggestions(pattern) async {
    await Future.delayed(const Duration(seconds: 2));
    return suggestionList.where((element) {
      return element.toLowerCase().contains(pattern.toLowerCase());
    }).toList();
  }



}