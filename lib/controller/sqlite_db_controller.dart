import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_bottom/constant/db_helper.dart';
import 'package:model_bottom/controller/base_controller.dart';
import 'package:model_bottom/model/data_model.dart';

class SqliteDbController extends BaseController {
  RxList<DataModel> listOfData = <DataModel>[].obs;
  DBHelper dbHelper = DBHelper();

  final TextEditingController titleController = TextEditingController();
  int? dataId;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(Duration(seconds: 10));
   // Future.delayed(Duration(seconds: 10), () {
      featchAllData();
    //},);

  }

  // FutureOr da(t){
  //   Future.delayed(Duration(seconds: 10), (){
  //   //featchAllData() async {
  //     var data = await dbHelper.getData();
  //     listOfData.value = data;
  //   //}
  // });
  //   return featchAllData();
  // }

  featchAllData() async {
    var data = await dbHelper.getData();
    listOfData.value = data;
  }

  addData(DataModel dataModel) async {
    loader.value = true;
    await dbHelper.addDataBase(dataModel);
    Future.delayed(Duration(seconds: 10), () {
      featchAllData();
    },);
  }

  updateData(DataModel dataModel) {
    dbHelper.updates(dataModel);
    featchAllData();
  }
  deleteData(int id) {
    dbHelper.deleteDB(id);
    featchAllData();
  }

  clearController() {
    titleController.clear();
  }
}
