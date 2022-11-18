import 'package:flutter/material.dart';


class CommonSelectDropDown extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onTap;
  final bool isOpen;
  final String? labelText;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final Color fillColors;
  final Widget? list;
  final String? errorText;

  final bool? isPadding;

  const CommonSelectDropDown(
      {Key? key,
        this.onTap,
        required this.controller,
        this.labelText,
        this.hintText,
        this.fillColors = Colors.grey,
        this.hintTextStyle,
        this.isOpen = false,
        this.isPadding = true,
        this.list,
        this.errorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: TextFormField(
            textAlignVertical: TextAlignVertical.bottom,
            controller: controller,
            readOnly: true,
            enabled: false,
            // validator: Validator.checkName,
            style: TextStyle(fontSize: 15),
            decoration: InputDecoration(
                contentPadding: isPadding!
                    ? const EdgeInsets.fromLTRB(20, 0, 12, 12)
                    : const EdgeInsets.fromLTRB(20, -10, 12, 16),
                filled: true,
                hintText: hintText,
                hintStyle: hintTextStyle,
                fillColor: fillColors,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Icon(
                  isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.lightBlue,
                ),
                isDense: true,
                labelText: labelText,
                labelStyle:TextStyle(fontSize: 16),
                floatingLabelStyle:TextStyle(fontSize: 14)),
          ),
        ),
        const SizedBox(
          height: 6.0,
        ),
        errorText != null
            ? Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            errorText.toString(),
            style: const TextStyle(
                color: Colors.red, fontSize: 12.0),
          ),
        )
            : Container(),
        list!,
      ],
    );
  }
}
