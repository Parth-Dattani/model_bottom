import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {

  const CommonButton({Key? key, required this.icon, this.onPressed,  this.color}) : super(key: key);

  final IconData icon;
  final Color? color;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 40,
      height: 30,
      elevation: 2,
      color: color,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(icon),
    );
  }
}
