import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonAppBar extends StatelessWidget {
  final String? title;
  final Widget? leadingIcon;
  final Widget? action;
  final VoidCallback? leadingOnTap;

  const CommonAppBar({Key? key, this.title, this.action, this.leadingOnTap, this.leadingIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AppBar(

      title: Text(title.toString()),
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
      icon: leadingIcon!),
    actions: [

    ],
    );
  }
}
