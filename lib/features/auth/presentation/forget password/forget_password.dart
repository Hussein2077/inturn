import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/column_with_text_field.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late TextEditingController phoneController;

  @override
  void initState() {
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
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
            Text(
              StringManager.weWillSend.tr(),
              maxLines: 4,
              style: TextStyle(
                  fontSize: AppSize.defaultSize! * 1.6,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis),
            ),
            ColumnWithTextField(
              text:  StringManager.enterYourMobile.tr(),
              controller: phoneController,
            ),
            SizedBox(
              height: AppSize.defaultSize!*4,
            ),
            MainButton(text:  StringManager.sendCode.tr(),onTap: (){
              Navigator.pushNamed(context, Routes.sendOTPCode);
            },)
          ],
        ),
      ),
    );
  }
}
