import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/column_with_text_field.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/snack_bar.dart';
import 'package:inturn/features/profile/presentation/controller/change_password/change_password_bloc.dart';
import 'package:inturn/features/profile/presentation/controller/change_password/change_password_event.dart';
import 'package:inturn/features/profile/presentation/controller/change_password/change_password_state.dart';
import 'package:inturn/main.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController oldPasswordController;
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmController;
  bool oldPasswordVisible = false;
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;
  @override
  void initState() {
    oldPasswordController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordFlowBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordLoadingState) {
          EasyLoading.show();
        }
        if (state is ChangePasswordErrorState) {
          EasyLoading.dismiss();
          EasyLoading.showError(state.errorMessage);
        }
        if (state is ChangePasswordSuccessState) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess(state.successMessage);
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: appBar(context, text: StringManager.changePassword.tr()),
        body: Padding(
          padding: EdgeInsets.all(AppSize.defaultSize! * 2),
          child: Column(
            children: [
              ColumnWithTextField(
                text: StringManager.oldPassword.tr(),
                obscureText: oldPasswordVisible,
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      oldPasswordVisible = !oldPasswordVisible; ;
                    });
                  },
                  child: Icon(
                    oldPasswordVisible ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
                controller: oldPasswordController,
              ),
              SizedBox(
                height: AppSize.defaultSize!,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.forgetPassword);
                  },
                  child: CustomText(
                    text: StringManager.forgetYourPassword.tr(),
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: AppSize.defaultSize! * 1.4,
                  ),
                ),
              ),
              ColumnWithTextField(
                text: StringManager.newPassword.tr(),
                obscureText: passwordVisible,
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                  child: Icon(
                    passwordVisible ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
                controller: passwordController,
              ),
              ColumnWithTextField(
                text: StringManager.confirmNewPassword.tr(),
                controller: passwordConfirmController,
                obscureText: confirmPasswordVisible,
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      confirmPasswordVisible = !confirmPasswordVisible;
                    });
                  },
                  child: Icon(
                    confirmPasswordVisible ? Icons.visibility_off : Icons.visibility,
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
                  if ((passwordController.text ==
                          passwordConfirmController.text) &&
                      (passwordController.text != oldPasswordController.text) &&
                      (oldPasswordController.text.isNotEmpty) &&
                      (passwordController.text.isNotEmpty)) {
                    BlocProvider.of<ChangePasswordFlowBloc>(context).add(
                      ChangePasswordEvent(
                          oldPassword: oldPasswordController.text,
                          newPassword: passwordController.text,
                          id: MyApp.userId),
                    );
                  } else if (passwordController.text !=
                      passwordConfirmController.text) {
                    errorSnackBar(context, StringManager.passwordNotMatch.tr());
                  } else if (oldPasswordController.text.isEmpty) {
                    errorSnackBar(
                        context, StringManager.pleaseEnterPassword.tr());
                  } else if (passwordController.text.isEmpty) {
                    errorSnackBar(
                        context, StringManager.pleaseEnterPassword.tr());
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
