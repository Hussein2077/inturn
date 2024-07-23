import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final Color? fillColor;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle ;
  final TextStyle? textStyle ;
  final GlobalKey<FormState>? formKey;
final List<TextInputFormatter>? inputFormatters;
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
    this.labelStyle,
    this.width,
    this.height,
    this.maxLines,
    this.formKey,
    this.fillColor,
    this.onChanged,
    this.textStyle
    ,this.inputFormatters
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? AppSize.defaultSize! * 4.5,
      width: widget.width ?? double.maxFinite,
      child: Form(
        key: widget.formKey,
        child: TextFormField(
          onTap: widget.onTap,
          inputFormatters: widget. inputFormatters,
          style:  widget.textStyle??TextStyle(
            fontSize: AppSize.defaultSize! * 1.5,
          ),
          onChanged: widget.onChanged ,
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
            fillColor: widget.fillColor,

            filled: widget.fillColor != null ? true : false,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            suffixIcon: widget.suffixIcon,
            contentPadding: EdgeInsets.all(AppSize.defaultSize! * .8),
            labelStyle: widget.labelStyle ?? TextStyle(
              color: AppColors.greyColor,
              fontSize: AppSize.screenHeight! * .015,
            ),
            prefixIcon: widget.prefixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(AppSize.defaultSize! * 1.5)),
              borderSide:
                  BorderSide(color: AppColors.borderColor.withOpacity(.4)),
            ),
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(AppSize.defaultSize! * 1.5)),
              borderSide:
                  BorderSide(color: AppColors.borderColor.withOpacity(.4)),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(AppSize.defaultSize! * 1.5)),
                borderSide:
                    BorderSide(color: AppColors.primaryColor.withOpacity(.4))),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(AppSize.defaultSize! * 1.5)),
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
