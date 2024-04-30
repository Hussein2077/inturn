import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/utils/enums.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/custom_text_field.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/loading_widget.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/snack_bar.dart';
import 'package:inturn/features/auth/presentation/widgets/segment_button.dart';
import 'package:inturn/features/home/data/model/skill_model.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_bloc.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_states.dart';
import 'package:searchfield/searchfield.dart';

class SkillInfo extends StatefulWidget {
  const SkillInfo({super.key});

  @override
  State<SkillInfo> createState() => _SkillInfoState();
}

class _SkillInfoState extends State<SkillInfo> {
  late TextEditingController controller = TextEditingController();
  @override
  initState() {
    super.initState();
    controller=TextEditingController();
  }
    List<String> skillList = [];
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
        body: BlocBuilder<OptionsBloc, GetOptionsStates>(
          builder: (context, state) {
            switch (state.getSkillsRequest) {
              case RequestState.loaded:
                return Padding(
                  padding: EdgeInsets.all(AppSize.defaultSize! * 1.5),
                  child:
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start, children: [
                    BlocBuilder<OptionsBloc,  GetOptionsStates >(
                      builder: (context, state) {
                        if (state.getSkillsRequest == RequestState.loading) {
                          return const LoadingWidget();
                        }
                       else if (state.getSkillsRequest == RequestState.loaded) {
                         log('${state.getSkills[1].skillNameEn}state.getSkills');
                               return SearchField<SkillModel>(
                            controller: controller,
                                 onSuggestionTap:   ( v) {
                                   print('${v.item?.skillNameEn??""}skillList');


                                     skillList.add(v.item?.skillNameEn??"");
                                     setState(() {

                                     });

                                 },
                                 onSaved:   ( v) {
                                 },
                                onTap:  ( ) {

                                },
                                 onSubmit: ( v){
                                 },
                            suggestions: state.getSkills
                                .map(
                                  (e) =>
                                  SearchFieldListItem<SkillModel>(
                                    e.skillNameEn??"",
                                    item: e,
                                    // Use child to show Custom Widgets in the suggestions
                                    // defaults to Text widget
                                    child: Padding(
                                      padding:   EdgeInsets.all(AppSize.defaultSize! ),
                                      child: CustomText(text:e.skillNameEn??""),
                                    ),

                                  ),
                            ).toList(),
                                 hint: StringManager.searchForSkills.tr(),
                                 searchStyle: TextStyle(
                                   fontSize: AppSize.defaultSize! * 1.2,
                                   color: Colors.black.withOpacity(0.8),
                                 ),
                                // autofocus: true,
                          );
                        }
                       else return const SizedBox();


                      },
                    ),
                    // CustomTextField(
                    //   hintText: StringManager.searchForSkills.tr(),
                    //   hintStyle: TextStyle(
                    //       fontSize: AppSize.defaultSize! * 1.4),
                    // ),
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
                      segments: skillList,
                      width: AppSize.defaultSize! * 10,
                      onValueChanged: (index) => _onValueChanged(index),
                    ),
                    SizedBox(
                      height: AppSize.defaultSize! * 4,
                    ),
                    MainButton(
                      text: StringManager.next.tr(),
                      onTap: () {
                        if (true) {
                          Navigator.pushNamed(context, Routes.thanks);
                        } else {
                          errorSnackBar(
                              context, StringManager.pleaseCompleteYourData
                              .tr());
                        }
                      },
                    ),
                  ]),
                );
              case RequestState.loading:
                return const LoadingWidget();
              case RequestState.error:
                return ErrorWidget(state.getSkillsMessage);
            }
          },
        ));
  }
}
