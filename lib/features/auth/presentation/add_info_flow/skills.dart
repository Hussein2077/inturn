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
import 'package:inturn/core/widgets/major_drop_down.dart';
import 'package:inturn/core/widgets/snack_bar.dart';
import 'package:inturn/core/widgets/university.dart';
import 'package:inturn/features/auth/presentation/widgets/segment_button.dart';

class SkillInfo extends StatefulWidget {
  const SkillInfo({super.key});

  @override
  State<SkillInfo> createState() => _SkillInfoState();
}

class _SkillInfoState extends State<SkillInfo> {
  int _currentSegment = 0;

  void _onValueChanged(int newValue) {
    setState(() {
      _currentSegment = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context, text: StringManager.yourSkills.tr()),
        body: Padding(
          padding: EdgeInsets.all(AppSize.defaultSize! * 1.5),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomTextField(
              hintText: StringManager.searchForSkills.tr(),
              hintStyle: TextStyle(fontSize: AppSize.defaultSize! * 1.4),
            ),
            SizedBox(
              height: AppSize.defaultSize! * 1.6,
            ),
            CustomText(
              text: StringManager.selectSkills.tr(),
              color: AppColors.thirdColor,
            ),
            SizedBox(
              height: AppSize.defaultSize! * 1.6,
            ),
            CustomSegmentedButton(
              segments: ['Java', 'Java','Java','Java'],
              width:  AppSize.defaultSize! * 10,
              onValueChanged: (index) => _onValueChanged(index),
            ),
            SizedBox(
              height: AppSize.defaultSize! * 4,
            ),
            MainButton(
              text: StringManager.next.tr(),
              onTap: () {
                if (true) {
                  Navigator.pushNamed(context, Routes.main);
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
