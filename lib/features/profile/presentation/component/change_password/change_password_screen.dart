import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/column_with_text_field.dart';
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
  bool isVisible = false;

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
                controller: oldPasswordController,
              ),
              ColumnWithTextField(
                text: StringManager.newPassword.tr(),
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
                text: StringManager.confirmNewPassword.tr(),
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
                  if((passwordController.text == passwordConfirmController.text) && (passwordController.text != oldPasswordController.text) && (oldPasswordController.text.isNotEmpty) && (passwordController.text.isNotEmpty)){
                    BlocProvider.of<ChangePasswordFlowBloc>(context).add(
                      ChangePasswordEvent(
                        oldPassword: oldPasswordController.text,
                        newPassword: passwordController.text,
                        id: MyApp.userId
                      ),
                    );
                  }else {
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
