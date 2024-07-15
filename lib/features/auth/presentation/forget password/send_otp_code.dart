import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/snack_bar.dart';
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_events.dart';
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_states.dart';
import 'package:inturn/features/auth/presentation/forget%20password/widgets/pin_text_field.dart';

class SendOTPCode extends StatefulWidget {
  const SendOTPCode({super.key, required this.email});

  final String email;

  @override
  State<SendOTPCode> createState() => _SendOTPCodeState();
}

class _SendOTPCodeState extends State<SendOTPCode> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordFlowBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state is VerifyCodeLoadingState) {
          EasyLoading.show();
        }
        if (state is VerifyCodeErrorMessageState) {
          EasyLoading.dismiss();
          EasyLoading.showError(state.errorMessage);
        }
        if (state is VerifyCodeSuccessMessageState) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess(state.successMessage);
          Navigator.pushNamed(context, Routes.resetPassword,
              arguments: widget.email);
        }
      },
      child: Scaffold(
        appBar: appBar(context, text: StringManager.forgetPassword.tr()),
        body: Padding(
          padding: EdgeInsets.all(AppSize.defaultSize! * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringManager.pleaseEnterYOurCode.tr(),
                maxLines: 4,
                style: TextStyle(
                    fontSize: AppSize.defaultSize! * 1.6,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis),
              ),
              SizedBox(
                height: AppSize.defaultSize! * 4,
              ),
              const CustomPinCodeTextField(),
              Text(
                '${StringManager.youCanResend.tr()}2.00',
                maxLines: 4,
                style: TextStyle(
                    fontSize: AppSize.defaultSize! * 1.6,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  StringManager.resendCode.tr(),
                  maxLines: 4,
                  style: TextStyle(
                      fontSize: AppSize.defaultSize! * 1.7,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.grey,
                      decorationThickness: 2,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
              MainButton(
                text: StringManager.verify.tr(),
                onTap: () {
                  if (CustomPinCodeTextField.otp.isNotEmpty &&
                      CustomPinCodeTextField.otp.length == 4) {
                    BlocProvider.of<ResetPasswordFlowBloc>(context).add(
                        VerifyCodeEvent(
                            code: CustomPinCodeTextField.otp,
                            email: widget.email));
                  } else {
                    errorSnackBar(context, StringManager.enterCode.tr());
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
