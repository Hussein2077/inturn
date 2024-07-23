import 'dart:async';
import 'dart:math';

import 'package:animated_visibility/animated_visibility.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/utils/methods.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/snack_bar.dart';
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_events.dart';
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_states.dart';
import 'package:inturn/features/auth/presentation/controller/sign_up_bloc/sign_up_with_email_and_password_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/sign_up_bloc/sign_up_with_email_and_password_events.dart';
import 'package:inturn/features/auth/presentation/controller/sign_up_bloc/sign_up_with_email_and_password_states.dart';
import 'package:inturn/features/auth/presentation/forget%20password/widgets/pin_text_field.dart';
import 'package:inturn/features/auth/presentation/signup/counter_by_widget.dart';
import 'package:inturn/features/auth/presentation/signup/intle_phone.dart';
import 'package:inturn/features/auth/presentation/signup/pass_and_confirm.dart';
import 'package:inturn/features/auth/presentation/signup/send_code_button.dart';
import 'package:inturn/main.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static bool otpVisible = false;
  static String phoneNumber = '';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmController;
  bool passAndConfirmVisible = false;
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;
bool phoneReadOnly = false;
  @override
  void initState() {
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    passwordConfirmController.dispose();
    passAndConfirmVisible = false;
    SignUpScreen.otpVisible = false;
    SignUpScreen.phoneNumber = '';
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpWithEmailAndPasswordBloc,
        SignUpWithEmailAndPasswordState>(
      listener: (context, state) {
        if (state is SignUpWithEmailAndPasswordSuccessMessageState) {
          EasyLoading.dismiss();
          Methods.instance.navigateToAddInfo(
              isComplete: state.isCompleted,
              completion: state.completion,
              userId: state.userId);
        } else if (state is SignUpWithEmailAndPasswordErrorMessageState) {
          EasyLoading.dismiss();
          errorSnackBar(context, state.errorMessage);
        } else if (state is SignUpWithEmailAndPasswordLoadingState) {
          EasyLoading.show(status: 'loading...');
        }
      },
      child: BlocListener<ResetPasswordFlowBloc, ResetPasswordState>(
        listener: (context, state) {
          if (state is SendCodeSuccessMessageState) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess(  StringManager.codeSent.tr());
            if (SignUpScreen.otpVisible == false) {
              setState(() {
                SignUpScreen.otpVisible = true;
              });
            }
          } else if (state is SendCodeErrorMessageState) {
            EasyLoading.dismiss();
            errorSnackBar(context, state.errorMessage);
          } else if (state is SendCodeLoadingState) {
            EasyLoading.show(status: 'loading...');
          }
          else if (state is VerifyCodeSignUpErrorMessageState) {
            EasyLoading.dismiss();
            errorSnackBar(context, state.errorMessage);
          }
          else if (state is VerifyCodeSignUpSuccessMessageState) {
            EasyLoading.dismiss();
            SignUpScreen.otpVisible = false;
            passAndConfirmVisible = true;
            phoneReadOnly = true;
            setState(() {});
          }
          else if (state is VerifyCodeSignUpLoadingState) {
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
                    child: IntlPhone(
                      readOnly: phoneReadOnly,
                      suffixIcon: Padding(
                          padding: EdgeInsets.all(AppSize.defaultSize!),

                          child: SendCodeButton(
                            text: phoneReadOnly
                                ? StringManager.sent
                                : StringManager.sendCode,
                            color: SignUpScreen.otpVisible
                                ?AppColors.greyColor:AppColors.primaryColor, readOnly: phoneReadOnly ,
                          )),
                      onChanged: (phone) {
                        SignUpScreen.phoneNumber = phone.number;
                      },
                      onSubmitted: (phone) {
                        // phoneNumber = phone;
                      },
                    ),
                  ),
                  AnimatedVisibility(
                    visible: SignUpScreen.otpVisible,
                    enter: slideInVertically(initialOffsetY: -1),
                    exit: fadeOut() + slideOutHorizontally(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppSize.defaultSize! * 4,
                          vertical: AppSize.defaultSize!),
                      child: Column(
                        children: [
                          CustomPinCodeTextField(
                            onCompleted: (v) {
                              print("Completed");
                              CustomPinCodeTextField.otp = v;

                              BlocProvider.of< ResetPasswordFlowBloc>(
                                  context
                              ).add(VerifyCodeSignUpEvent(phone:  SignUpScreen.phoneNumber, code: CustomPinCodeTextField.otp ));


                            },
                          ),
                          const CounterByMinute(),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(AppSize.defaultSize!),
                    child: AnimatedVisibility(
                      visible: passAndConfirmVisible,
                      enter: slideInVertically(initialOffsetY: -1),
                      exit: fadeOut() + slideOutHorizontally(),
                      child: PassAndConfirmPass(
                        passwordController: passwordController,
                        passwordConfirmController: passwordConfirmController,
                      ),
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

                          if (SignUpScreen.phoneNumber.length == 10 &&
                              passwordController.text ==
                                  passwordConfirmController.text &&
                              passwordController.text.isNotEmpty &&
                              passwordConfirmController.text.isNotEmpty &&
                              CustomPinCodeTextField.otp.isNotEmpty) {
                            BlocProvider.of<SignUpWithEmailAndPasswordBloc>(
                                    context)
                                .add(SignUpWithEmailAndPasswordEvent(
                              phone: '0${SignUpScreen.phoneNumber}',
                              password: passwordController.text,
                              otp: CustomPinCodeTextField.otp,
                            ));
                          }
                          else if(SignUpScreen.phoneNumber.length != 10){
                            errorSnackBar(context, StringManager.enterPhoneNumber.tr());
                          }
                          else if(passwordController.text != passwordConfirmController.text){
                            errorSnackBar(context, StringManager.passwordsDontMatch.tr());
                          }
                          else if(CustomPinCodeTextField.otp.isEmpty){
                            errorSnackBar(context, StringManager.enterOtp.tr());
                          }

                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
