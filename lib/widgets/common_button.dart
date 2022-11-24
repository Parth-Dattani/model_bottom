import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {

  const CommonButton({Key? key, this.onPressed,  this.color, this.child, this.height, this.width}) : super(key: key);


  final Color? color;
  final Function()? onPressed;
  final Widget? child;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: width,
      height: height,
      elevation: 2,
      color: color,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}
