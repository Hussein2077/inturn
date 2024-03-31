import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/column_with_text_field.dart';
class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context,text: StringManager.forgetPassword.tr()),
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
              controller: passwordConfirmController,   suffixIcon: InkWell(
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
              height: AppSize.defaultSize!*4,
            ),
              MainButton(text: StringManager.confirm.tr(),onTap: (){
                Navigator.pushNamedAndRemoveUntil(context, Routes.login, (Route<dynamic> route) => false) ;
              },)
          ],
        ),
      ),
      
    );
  }
}
