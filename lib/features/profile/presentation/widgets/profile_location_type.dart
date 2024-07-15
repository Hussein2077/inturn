import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/models/profile_data_model.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/features/auth/presentation/widgets/segment_button.dart';

class ProfileLocationType extends StatefulWidget {
  const ProfileLocationType({super.key, required this.profileDataModel});
final ProfileDataModel profileDataModel;
static   int location = 0;

  @override
  State<ProfileLocationType> createState() => _ProfileLocationTypeState();
}

class _ProfileLocationTypeState extends State<ProfileLocationType> {
  void _onValueChangedLocation(int newValue) {
    setState(() {
      ProfileLocationType. location = newValue;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius:
      BorderRadius.circular(AppSize.defaultSize! * 1.5),
      elevation: 1,
      child: Container(
        width: AppSize.screenWidth!,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
              AppSize.defaultSize! * 1.5),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSize.defaultSize! * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: StringManager.locationType.tr(),
                fontSize: AppSize.defaultSize! * 1.6,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: AppSize.defaultSize! * 1.6,
              ),
              CustomSegmentedButton(
                initialSelectedIndex:
                (widget.profileDataModel?.jobLocationTypeId ??
                    0) >
                    0
                    ? (widget.profileDataModel
                    ?.jobLocationTypeId ??
                    0) -
                    1
                    : 0,
                segments: [
                  StringManager.onSite.tr(),
                  StringManager.remotely.tr(),
                  StringManager.hybrid.tr()
                ],
                onValueChanged: (index) =>
                    _onValueChangedLocation(index),
                width: AppSize.defaultSize! * 9,
              )
            ],
          ),
        ),
      ),
    );
  }
}
