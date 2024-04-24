import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/major_drop_down.dart';
import 'package:inturn/core/widgets/snack_bar.dart';
import 'package:inturn/core/widgets/university.dart';

class AcademicInfo extends StatelessWidget {
  const AcademicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            appBar(context, text: StringManager.fillAcademicInformation.tr()),
        body: Padding(
          padding: EdgeInsets.all(AppSize.defaultSize! * 1.5),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            UniversityDropDown(),
            SizedBox(
              height: AppSize.defaultSize! * 2,
            ),
            const FacultyDropDown(),
                SizedBox(
                  height: AppSize.defaultSize! * 4,
                ),
                MainButton(
                  text: StringManager.next.tr(),
                  onTap: () {
                    if (UniversityDropDown.selectedValue!=null&&FacultyDropDown.selectedValue!=null) {
                      Navigator.pushNamed(context, Routes.experienceInfo);
                    } else {
                      errorSnackBar(
                          context, StringManager.pleaseCompleteYourData.tr());
                    }
                  },
                ),
          ]),
        ));
  }
}
