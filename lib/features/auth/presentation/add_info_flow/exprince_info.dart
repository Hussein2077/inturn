import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/snack_bar.dart';
import 'package:inturn/features/auth/presentation/controller/add_info_bloc/add_info_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/add_info_bloc/add_info_events.dart';
import 'package:inturn/features/auth/presentation/controller/add_info_bloc/add_info_states.dart';
import 'package:inturn/features/auth/presentation/widgets/segment_button.dart';

class ExperienceInfo extends StatefulWidget {
  const ExperienceInfo({super.key});

  static int jobLevel = 0;
  static int experience = 0;

  @override
  State<ExperienceInfo> createState() => _ExperienceInfoState();
}

class _ExperienceInfoState extends State<ExperienceInfo> {
  void _onValueChanged(int newValue) {
    setState(() {
      ExperienceInfo.experience = newValue;
    });
  }

  void _jobLevelChanged(int newValue) {
    setState(() {
      ExperienceInfo.jobLevel = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context, text: StringManager.experience.tr(),leading: false),
        body: BlocListener<AddPersonalInfoBloc, AddPersonalInfoState >(
          listener: (context, state) {
            if (state is AddExperienceLevelLoadingState) {
             Navigator.pushNamedAndRemoveUntil(context, Routes.locationInfo,(route) => false);
            }
            if (state is AddExperienceLevelErrorState) {
              errorSnackBar(context, StringManager.unexpectedError.tr());
            }
          },
          child: Padding(
            padding: EdgeInsets.all(AppSize.defaultSize! * 1.5),
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomText(
                text: StringManager.studentOrGraduated.tr(),
                color: AppColors.thirdColor,
              ),
              SizedBox(
                height: AppSize.defaultSize! * 1.6,
              ),
              CustomSegmentedButton(
                segments: const ['Student', 'Graduated'],
                onValueChanged: (index) => _onValueChanged(index),
              ),
              SizedBox(
                height: AppSize.defaultSize! * 2.4,
              ),
              CustomText(
                text: StringManager.jobLevel.tr(),
                color: AppColors.thirdColor,
              ),
              SizedBox(
                height: AppSize.defaultSize! * 1.6,
              ),
              CustomSegmentedButton(
                segments: const ['Internship', 'Entry Level'],
                onValueChanged: (index) => _jobLevelChanged(index),
              ),
              SizedBox(
                height: AppSize.defaultSize! * 4,
              ),
              MainButton(
                  text: StringManager.next.tr(),
                  onTap: () {
                    BlocProvider.of<AddPersonalInfoBloc>(context).add(
                      SendExperienceLevelEvent(
                          typeID: (ExperienceInfo.experience + 1).toString(),
                          jobLevelId: (ExperienceInfo.jobLevel + 1).toString()),
                    );
                  }),
            ]),
          ),
        ));
  }
}
