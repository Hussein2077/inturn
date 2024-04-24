import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/major_drop_down.dart';
import 'package:inturn/core/widgets/snack_bar.dart';
import 'package:inturn/core/widgets/university.dart';
import 'package:inturn/features/auth/presentation/widgets/segment_button.dart';

class LocationInfo extends StatefulWidget {
  const LocationInfo({super.key});

  @override
  State<LocationInfo> createState() => _LocationInfoState();
}

class _LocationInfoState extends State<LocationInfo> {
  int _currentSegment = 0;

  void _onValueChanged(int newValue) {
    setState(() {
      _currentSegment = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context, text: StringManager.workLocationAndType.tr()),
        body: Padding(
          padding: EdgeInsets.all(AppSize.defaultSize! * 1.5),
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            UniversityDropDown(),
            SizedBox(
              height: AppSize.defaultSize! * 2,
            ),
            FacultyDropDown(),
            SizedBox(
              height: AppSize.defaultSize! * 2.4,
            ),
            CustomText(
              text: StringManager.selectLocationType.tr(),
              color: AppColors.thirdColor,
            ),
            SizedBox(
              height: AppSize.defaultSize! * 1.6,
            ),
            CustomSegmentedButton(
              segments: ['On Site', 'Remotly','Hybrid'],
              onValueChanged: (index) => _onValueChanged(index),
              width:  AppSize.defaultSize! * 10,
            ),
            SizedBox(
              height: AppSize.defaultSize! * 4,
            ),
            MainButton(
              text: StringManager.next.tr(),
              onTap: () {
                if (true) {
                  Navigator.pushNamed(context, Routes.fieldInfo);
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
