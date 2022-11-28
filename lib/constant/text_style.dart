import 'package:flutter/material.dart';
import 'package:model_bottom/constant/color_config.dart';

class AppTextStyle{
  static const textFontSize18 = 18.0;
  static const textFontSize20 = 20.0;
  static const textFontSize24 = 24.0;
}


class CustomTextStyle{

  static TextStyle buttonText = const TextStyle(
    fontSize: AppTextStyle.textFontSize24,
    color: ColorConfig.colorWhite,
    fontWeight: FontWeight.w500
  );

  static TextStyle billText = const TextStyle(
      fontSize: AppTextStyle.textFontSize20,
      color: ColorConfig.colorBlack,
      fontWeight: FontWeight.w500
  );

  static TextStyle HighLightBillText = const TextStyle(
      fontSize: AppTextStyle.textFontSize20,
      color: ColorConfig.colorRed,
      fontWeight: FontWeight.w500
  );

  static TextStyle linkText = const TextStyle(
      fontSize: AppTextStyle.textFontSize18,
      color: ColorConfig.colorLightBlue,
      fontWeight: FontWeight.w500
  );
}

