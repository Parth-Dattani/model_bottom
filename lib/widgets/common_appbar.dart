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

      title: Text(title!),
      centerTitle: true,
      backgroundColor: Colors.red[50],
      elevation: 0.0,
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: Colors.redAccent),
      leading: leadingIcon,
      // leading: IconButton(
      //     onPressed: () {
      //       Get.back();
      //     },
      // icon: leadingIcon!),
    actions: [

    ],
    );
  }
}
