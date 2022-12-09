import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:model_bottom/controller/controller.dart';

class FavoriteScreen extends GetView<FavoriteController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favoite")),
      body: Column(
        children: [
        ],
      ),
    );
  }
}