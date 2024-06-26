import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/features/auth/presentation/signup/sign_up.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinCodeTextField extends StatefulWidget {
  const CustomPinCodeTextField({super.key, this.onCompleted});
  static String otp = "";
  final void Function(String)? onCompleted;
  @override
  State<CustomPinCodeTextField> createState() => _CustomPinCodeTextFieldState();
}

class _CustomPinCodeTextFieldState extends State<CustomPinCodeTextField> {
  late TextEditingController controller;
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controller = TextEditingController();
    errorController = StreamController<ErrorAnimationType>();

    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 4,

      keyboardType: TextInputType.phone,
      obscureText: false,
      animationType: AnimationType.fade,
      textStyle:     TextStyle(fontSize: AppSize.defaultSize! * 1.8),
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(AppSize.defaultSize!),
        fieldHeight: AppSize.defaultSize! * 4.5,
        fieldWidth: AppSize.defaultSize! * 4.5,
        activeFillColor: Colors.white,
        disabledColor: Colors.white,
        selectedFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        inactiveColor: AppColors.borderColor,
        selectedColor: AppColors.borderColor,
        activeColor: AppColors.primaryColor,
      ),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      errorAnimationController: errorController,
      controller: controller,
      onCompleted:widget.onCompleted ?? (v) {
        print("Completed");
        CustomPinCodeTextField.otp = v;

      },
      onChanged: (value) {
        print(value);
        setState(() {
          currentText = value;
          CustomPinCodeTextField.otp = value;


        });
      },
      beforeTextPaste: (text) {
        print("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
    );
  }
}
