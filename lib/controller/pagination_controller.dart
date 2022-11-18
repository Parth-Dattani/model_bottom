import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_bottom/controller/base_controller.dart';
import 'package:model_bottom/model/pagination_response.dart';
import 'package:model_bottom/service/service.dart';

class PaginationController extends BaseController {
  ScrollController scrollController = ScrollController();
  RxInt pageNo = 0.obs;
  RxInt pageSize = 10.obs;
  RxBool isPaginateData = false.obs;
  RxList<Items> listOfData = <Items>[].obs;

  @override
  void onInit() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        isPaginateData.value = true;
        if (isPaginateData.value) {
          pageNo.value++;
          getApiData(pageNoData: pageNo.value, pageSize: pageSize.value);
        }
      }
    });
    getApiData();
    super.onInit();
  }

  Future<void> getApiData({int pageNoData = 0, int pageSize = 10}) async {

    loader.value = true;

    var response = await RemoteServices.getApiData(pageNoData, pageSize);
    var jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      loader.value = false;
      if (pageNoData == 0) {
        pageNo.value = pageNoData;
        listOfData.clear();
      }
      var data = jsonData['Items'] as List;
      if (data.isNotEmpty) {
        for (dynamic i in data) {
          listOfData.add(Items.fromJson(i));
        }
        print(listOfData[1]);
      } else {
        loader.value = false;
        isPaginateData.value = false;
      }
    } else {}
    loader.value = false;
  }
}
