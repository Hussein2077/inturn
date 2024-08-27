import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/resource_manager/themes/enums.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/utils/methods.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/column_with_text_field.dart';
import 'package:inturn/core/widgets/snack_bar.dart';
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_events.dart';
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_states.dart';
import 'package:inturn/features/auth/presentation/forget%20password/widgets/pin_text_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({
    super.key,
    required this.resetPasswordParam,
  });

  final ResetPasswordParam  resetPasswordParam;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmController;
  bool isVisible = false;

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

    super.dispose();
  }

  late bool isLogin;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordFlowBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordLoadingState) {
          EasyLoading.show();
        }
        if (state is ResetPasswordErrorMessageState) {
          EasyLoading.dismiss();
          EasyLoading.showError(state.errorMessage);
        }
        if (state is ResetPasswordSuccessMessageState) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess(state.successMessage);

          Future.delayed(Duration.zero, () async {
            isLogin = await Methods.instance.returnUserToken() != 'noToken';
          });
          if (!isLogin) {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.login, (Route<dynamic> route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.main, (Route<dynamic> route) => false);
          }
        }
      },
      child: Scaffold(
        appBar: appBar(context, text: StringManager.resetPassword.tr()),
        body: Padding(
          padding: EdgeInsets.all(AppSize.defaultSize! * 2),
          child: Column(
            children: [
              ColumnWithTextField(
                text: StringManager.password.tr(),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  child: Icon(
                    isVisible ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
                controller: passwordController,
              ),
              ColumnWithTextField(
                text: StringManager.confirmPassword.tr(),
                controller: passwordConfirmController,
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  child: Icon(
                    isVisible ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.defaultSize! * 4,
              ),
              MainButton(
                text: StringManager.confirm.tr(),
                onTap: () {
                  if (passwordController.text ==
                          passwordConfirmController.text &&
                      passwordController.text.isNotEmpty &&
                      passwordConfirmController.text.isNotEmpty) {
                    BlocProvider.of<ResetPasswordFlowBloc>(context).add(
                      ResetPasswordEvent(
                          email: widget.resetPasswordParam.email,
                          password: passwordController.text,
                          code: CustomPinCodeTextField.otp,
                          guid:widget.resetPasswordParam.guid ,
                          phoneOrEmailType:
                              Methods.instance.isEmail(widget.resetPasswordParam.email) == true
                                  ? PhoneOrEmail.email
                                  : PhoneOrEmail.phone),
                    );
                  } else if (passwordController.text !=
                      passwordConfirmController.text) {
                    errorSnackBar(context, StringManager.passwordNotMatch.tr());
                  } else {
                    errorSnackBar(context, StringManager.fillAllFields.tr());
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
