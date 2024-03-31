import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/utils/app_size.dart';

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final double? width;
  final double? height;
  final int? maxLines;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final TextStyle? hintStyle;
  final  GlobalKey<FormState>? formKey ;

  const CustomTextField({
    Key? key,
    this.labelText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.hintText,
    this.hintStyle,
    this.width,
    this.height,
    this.maxLines, this.formKey,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? AppSize.defaultSize! * 6,
      width: widget.width ?? AppSize.screenWidth! - (AppSize.defaultSize! * 4),
      child: Form(
        key: widget.formKey,
        child: TextFormField(

          onTap: widget.onTap,
          maxLines: widget.maxLines,
          readOnly: widget.readOnly,
          validator: (value) {
            if (value == null || value.isEmpty) {

              return 'Please complete this field';
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: widget.labelText,

            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            suffixIcon: widget.suffixIcon,
            contentPadding: EdgeInsets.all(AppSize.defaultSize! * .8),
            labelStyle: TextStyle(
              color: AppColors.primaryColor,
              fontSize: AppSize.screenHeight! * .02,
            ),
            prefixIcon: widget.prefixIcon,
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: AppColors.borderColor.withOpacity(.4)),
            ),
            border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: AppColors.borderColor.withOpacity(.4)),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.primaryColor.withOpacity(.4))),
            disabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.borderColor.withOpacity(.4))),
          ),
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
        ),
      ),
    );
  }
}
