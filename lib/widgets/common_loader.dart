import 'package:flutter/material.dart';

class CommonLoader extends StatelessWidget {
  final Widget child;
  final bool isLoad;
  const CommonLoader({Key? key, required this.child, required this.isLoad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        isLoad ? const Opacity(
            opacity: 0.6,
            child: ModalBarrier(dismissible: false, color: Colors.grey))
            : const SizedBox(),

        isLoad ? const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.red),
          ),
        ) :
            Container(),
      ],
    );
  }
}
