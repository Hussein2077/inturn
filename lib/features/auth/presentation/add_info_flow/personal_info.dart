import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/custom_text_field.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/snack_bar.dart';
import 'package:inturn/features/auth/presentation/widgets/upload_photo.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, text: StringManager.personalInformation.tr()),
      body: Padding(
        padding:   EdgeInsets.all( AppSize.defaultSize! * 1.5),
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const UploadProfileImagePage(),
              SizedBox(
                height: AppSize.defaultSize! * 2,
              ),
              CustomText(
                text: StringManager.uploadProfileImage.tr(),
                fontSize: AppSize.defaultSize! * 1.6,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: AppSize.defaultSize! * 2,
              ),
              CustomTextField(
                labelText: StringManager.firstName.tr(),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: AppSize.defaultSize! * 2,
              ),
              CustomTextField(
                labelText: StringManager.secondName.tr(),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: AppSize.defaultSize! * 2,
              ),
              CustomTextField(
                labelText: StringManager.email.tr(),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: AppSize.defaultSize! * 2,
              ),
              MainButton(
                text: StringManager.next.tr(),
                onTap: () {
                  if (true) {
                    Navigator.pushNamed(context, Routes.academicInfo);
                  } else {
                    errorSnackBar(
                        context, StringManager.pleaseCompleteYourData.tr());
                  }
                },
              ),
            ]),
      ),
    );
  }
}
