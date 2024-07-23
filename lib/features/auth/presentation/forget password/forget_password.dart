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
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_events.dart';
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_states.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late TextEditingController emailController;

  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordFlowBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state is SendCodeForForgetLoadingState) {
          EasyLoading.show();
        }
        if (state is SendCodeForForgetErrorMessageState) {
          EasyLoading.dismiss();
          EasyLoading.showError(state.errorMessage);
        }
        if (state is SendCodeForForgetSuccessMessageState) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess(state.successMessage);
          Navigator.pushNamed(context, Routes.sendOTPCode,
              arguments: emailController.text);
        }
      },
      child: Scaffold(
        appBar: appBar(context, text: StringManager.forgetPassword.tr()),
        body: Padding(
          padding: EdgeInsets.all(AppSize.defaultSize! * 2),
          child: Column(
            children: [
              Text(
                StringManager.weWillSend.tr(),
                maxLines: 4,
                style: TextStyle(
                    fontSize: AppSize.defaultSize! * 1.6,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis),
              ),
              ColumnWithTextField(
                text: StringManager.enterEmailOrPhone.tr(),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: AppSize.defaultSize! * 4,
              ),
              MainButton(
                text: StringManager.sendCode.tr(),
                onTap: () {
                  if (emailController.text.isNotEmpty) {
                    BlocProvider.of<ResetPasswordFlowBloc>(context).add(
                        SendCodeForForgotEvent(
                            phoneOrEmail: emailController.text,
                            phoneOrEmailType: Methods.instance.isEmail(emailController.text)
                                ? PhoneOrEmail.email
                                : PhoneOrEmail.phone));
                  } else {
                    EasyLoading.showError(StringManager.enterEmail.tr());
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
