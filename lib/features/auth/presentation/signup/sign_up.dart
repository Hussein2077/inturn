import 'dart:math';

import 'package:animated_visibility/animated_visibility.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/column_with_text_field.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/snack_bar.dart';
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_events.dart';
import 'package:inturn/features/auth/presentation/controller/sign_up_bloc/sign_up_with_email_and_password_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/sign_up_bloc/sign_up_with_email_and_password_events.dart';
import 'package:inturn/features/auth/presentation/controller/sign_up_bloc/sign_up_with_email_and_password_states.dart';
import 'package:inturn/features/auth/presentation/forget%20password/widgets/pin_text_field.dart';
import 'package:inturn/main.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmController;
  bool otpVisible = false;
  String phoneNumber = '';
  bool passAndConfirmVisible = false;
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;

  @override
  void initState() {
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    passAndConfirmVisible = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpWithEmailAndPasswordBloc,
        SignUpWithEmailAndPasswordState>(
      listener: (context, state) {
        if (state is SignUpWithEmailAndPasswordSuccessMessageState) {
          EasyLoading.dismiss();
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.main, (route) => false,
              arguments: MyApp.userId);
        } else if (state is SignUpWithEmailAndPasswordErrorMessageState) {
          EasyLoading.dismiss();
          errorSnackBar(context, StringManager.unexpectedError.tr());
        } else if (state is SignUpWithEmailAndPasswordLoadingState) {
          EasyLoading.show(status: 'loading...');
        }
      },
      child: Scaffold(
        appBar: appBar(context, text: StringManager.signUp.tr()),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSize.defaultSize! * 2),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppSize.defaultSize! * 3,
                ),
                Padding(
                  padding: EdgeInsets.all(AppSize.defaultSize!),
                  child: IntlPhoneField(
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(
                          color: AppColors.black,
                          fontSize: AppSize.defaultSize! * 1.4),
                      hintText: '1123456789',
                      hintStyle: TextStyle(
                        fontSize: AppSize.defaultSize! * 1.4,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MainButton(
                          text: otpVisible
                              ? StringManager.resend
                              : StringManager.sendCode,
                          width: AppSize.defaultSize! * 10,
                          // height: AppSize.defaultSize! * 2,
                          color: AppColors.primaryColor,
                          fontSize: AppSize.defaultSize! * 1.2,
                          textColor: Colors.white,
                          onTap: () {
                            if (phoneNumber.length == 10&&!otpVisible) {
                              BlocProvider.of<ResetPasswordFlowBloc>(context)
                                  .add(SendCodeEvent(phone: phoneNumber));
                              // setState(() {
                              //   otpVisible = true;
                              // });
                            }
                          },
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: AppColors.greyColor),
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppSize.defaultSize!)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppSize.defaultSize!)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: AppColors.greyColor),
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppSize.defaultSize!)),
                      ),
                    ),
                    initialCountryCode: 'EG',
                    onChanged: (phone) {
                      phoneNumber = phone.number;
                    },
                  ),
                ),
                AnimatedVisibility(
                  visible: otpVisible,
                  enter: slideInVertically(initialOffsetY: -1),
                  exit: fadeOut() + slideOutHorizontally(),
                  child: Padding(
                    padding: EdgeInsets.all(AppSize.defaultSize!),
                    child: CustomPinCodeTextField(
                      onCompleted: (v) {
                        print("Completed");
                        CustomPinCodeTextField.otp = v;
                        passAndConfirmVisible = true;
                        setState(() {});
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(AppSize.defaultSize!),
                  child: AnimatedVisibility(
                    visible: passAndConfirmVisible,
                    enter: slideInVertically(initialOffsetY: -1),
                    exit: fadeOut() + slideOutHorizontally(),
                    child: StatefulBuilder(builder: (context, setState) {
                      return Column(
                        children: [
                          ColumnWithTextField(
                            text: StringManager.password.tr(),
                            controller: passwordController,
                            obscureText: passwordVisible,
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                              child: Icon(
                                passwordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          ColumnWithTextField(
                            text: StringManager.confirmPassword.tr(),
                            obscureText: confirmPasswordVisible,
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  confirmPasswordVisible =
                                      !confirmPasswordVisible;
                                });
                              },
                              child: Icon(
                                confirmPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                            ),
                            controller: passwordConfirmController,
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: AppSize.defaultSize! * 3,
                ),
                AnimatedVisibility(
                  visible: passAndConfirmVisible,
                  enter: slideInVertically(initialOffsetY: 5),
                  exit: fadeOut() + slideOutHorizontally(),
                  child: MainButton(
                      text: StringManager.continue1.tr(),
                      onTap: () {
                        // if (phoneNumber.length == 10) {
                        //   BlocProvider.of<SignUpWithEmailAndPasswordBloc>(context)
                        //       .add(SignUpWithEmailAndPasswordEvent(
                        //     phone: phoneNumber,
                        //     password: passwordController.text,
                        //   ));
                        // }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dropDownSignUp({
    required String text,
    required String hintText,
    required String selectedValue,
    required List<String> data,
    required void Function(String?)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
              fontSize: AppSize.defaultSize! * 1.4,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: AppSize.defaultSize! * .3,
        ),
        Container(
          width: AppSize.screenWidth! * .4,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor),
              borderRadius: BorderRadius.circular(AppSize.defaultSize! * .5)),
          child: Center(
            child: DropdownButton<String>(
              value: selectedValue,
              underline: const SizedBox(),
              onChanged: onChanged,
              hint: Text(
                hintText,
                style: TextStyle(
                  fontSize: AppSize.defaultSize!,
                ),
              ),
              icon: Padding(
                padding: EdgeInsets.only(left: AppSize.defaultSize! * 3),
                child: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  size: AppSize.defaultSize! * 3,
                ),
              ),
              items: data.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: AppSize.defaultSize!,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
