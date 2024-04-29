import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/cutom_text.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    this.onTap,
    this.color,
    this.textColor,
    required this.text,
    this.height,
    this.width,
    this.padding,
    this.fontSize,
    this.fontWeight,
  });

  final void Function()? onTap;
  final Color? color;
  final Color? textColor;
  final String text;
  final double? height;
  final double? width;
  final double? padding;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:   EdgeInsets.all(padding??0),
      child: SizedBox(
        height: height ?? AppSize.defaultSize! * 4.5,
        width: width ?? AppSize.screenWidth! * .9,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.defaultSize!*2),
            ),
          ),
          child: CustomText(
            text: text,
            color: textColor ?? AppColors.secondaryColor,
            fontSize: fontSize??AppSize.defaultSize! * 1.5,
            fontWeight:fontWeight ,
          ),
        ),
      ),
    );
  }
}
