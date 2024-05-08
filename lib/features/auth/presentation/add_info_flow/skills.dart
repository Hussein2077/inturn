import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/utils/enums.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/loading_widget.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/snack_bar.dart';
import 'package:inturn/features/auth/presentation/controller/add_info_bloc/add_info_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/add_info_bloc/add_info_events.dart';
import 'package:inturn/features/auth/presentation/controller/add_info_bloc/add_info_states.dart';
import 'package:inturn/features/auth/presentation/controller/add_skill/bloc.dart';
import 'package:inturn/features/auth/presentation/controller/add_skill/event.dart';
import 'package:inturn/features/auth/presentation/controller/add_skill/state.dart';
import 'package:inturn/features/auth/presentation/widgets/multi_select2.dart';
import 'package:inturn/features/home/data/model/skill_model.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_bloc.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_states.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_data/get_my_data_bloc.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_data/get_my_data_event.dart';
import 'package:inturn/main.dart';
import 'package:searchfield/searchfield.dart';

class SkillInfo extends StatefulWidget {
  const SkillInfo({super.key});
static   List<SkillModel> skillIds = [];

  @override
  State<SkillInfo> createState() => _SkillInfoState();
}

class _SkillInfoState extends State<SkillInfo> {
  late TextEditingController controller = TextEditingController();

  @override
  initState() {

    controller = TextEditingController();
    super.initState();
  }
@override
  dispose() {
  controller.dispose();
  super.dispose();
}
  List<int> _currentSegment = [];

  void _onValueChanged(List<int> newValue) {
    setState(() {

      _currentSegment = newValue;
    });
  }

  ValueNotifier<int> addToSkill = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context, text: StringManager.yourSkills.tr()),
        body: BlocListener<AddSkillsBloc , AddSkillsState>(
          listener: (context, state) {
            if (state is AddSkillsSuccessState) {
              Navigator.pushNamed(context, Routes.thanks);
              BlocProvider.of<GetMyDataBloc>(context).add( CompleteProfileEvent(MyApp.userId));
            }
            else if (state is AddSkillsErrorState) {
              EasyLoading.showError(state.errorMessage);
            }
          },
          child: BlocBuilder<OptionsBloc, GetOptionsStates>(
            builder: (context, state) {
              switch (state.getSkillsRequest) {
                case RequestState.loaded:
                  return Padding(
                    padding: EdgeInsets.all(AppSize.defaultSize! * 1.5),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<OptionsBloc, GetOptionsStates>(
                            builder: (context, state) {
                              log('sijvgwogbowgowrgb');
                              if(!SkillInfo.skillIds.contains(state.getSkills[0])) {

                                SkillInfo.skillIds.add(state.getSkills[0]);
                              }
                              if (state.getSkillsRequest ==
                                  RequestState.loading) {
                                return const LoadingWidget();
                              } else if (state.getSkillsRequest ==
                                  RequestState.loaded) {
                                return SearchField<SkillModel>(
                                  controller: controller,
                                  itemHeight:   AppSize.defaultSize! * 5,
                                  onSuggestionTap: (v) {
                                    if (!SkillInfo.skillIds.contains(v.item!)) {
                                      SkillInfo.skillIds.add(v.item!);
                                    }
                                    addToSkill.value++;
                                    controller.clear();

                                    _currentSegment=SkillInfo.skillIds
                                        .map((e) => SkillInfo.skillIds.indexOf(e))
                                        .toList();
                                  },

                                  suggestions: state.getSkills
                                      .map(
                                        (e) => SearchFieldListItem<SkillModel>(
                                          e.skillNameEn ?? "",
                                          item: e,
                                          // Use child to show Custom Widgets in the suggestions
                                          // defaults to Text widget
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                AppSize.defaultSize!),
                                            child: CustomText(
                                                text: e.skillNameEn ?? ""),
                                          ),

                                        ),
                                      )
                                      .toList(),
                                  hint: StringManager.searchForSkills.tr(),
                                  searchStyle: TextStyle(
                                    fontSize: AppSize.defaultSize! * 1.2,
                                    decoration: TextDecoration.none,
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                  // autofocus: true,
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                          // CustomTextField(
                          //   hintText: StringManager.searchForSkills.tr(),
                          //   hintStyle: TextStyle(
                          //       fontSize: AppSize.defaultSize! * 1.4),
                          // ),
                          SizedBox(
                            height: AppSize.defaultSize! * 3,
                          ),
                          CustomText(
                            text: StringManager.selectSkills.tr(),
                            color: AppColors.thirdColor,
                          ),
                          SizedBox(
                            height: AppSize.defaultSize! * 3,
                          ),
                          ValueListenableBuilder(
                              valueListenable: addToSkill,
                              builder: (context_, value, child) {
                                return CustomSegmentedButton2(
                                  onTapClose: (i) {
                                    SkillInfo.skillIds.removeAt(i);
                                    addToSkill.value++;
                                  },
                                  segments: SkillInfo.skillIds
                                      .map((e) => e.skillNameEn ?? "")
                                      .toList(),
                                  onValueChanged: (index) =>
                                      _onValueChanged(index),
                                  initialSelectedIndexes: SkillInfo.skillIds
                                      .map((e) => SkillInfo.skillIds.indexOf(e))
                                      .toList(),
                                );
                              }),
                          SizedBox(
                            height: AppSize.defaultSize! * 4,
                          ),
                          MainButton(
                            text: StringManager.next.tr(),
                            onTap: () {
                              if (SkillInfo.skillIds.isNotEmpty) {
                              BlocProvider.of<AddSkillsBloc>(context)
                                  .add(
                                SendSkillsIdEvent(
                                    skills: SkillInfo.skillIds
                                        .map((e) => (e.skillId ?? 0))
                                        .toList()),
                              );
                            } else {
                              errorSnackBar(context,
                                  StringManager.pleaseCompleteYourData.tr());
                            }
                              // if (_currentSegment.isNotEmpty) {
                              //   // Map the indexes in _currentSegment to their corresponding skill IDs
                              //   List<int> selectedSkillIds = _currentSegment
                              //       .map((index) => skillIds[index].skillId ?? 0)
                              //       .toList();
                              //   log('${selectedSkillIds} _currentSegment');
                              //
                              //   // Ensure that there are actually IDs to send (e.g., handle null or default values if needed)
                              //   if (selectedSkillIds.any((id) => id != 0)) {
                              //     BlocProvider.of<AddPersonalInfoBloc>(context).add(
                              //       SendSkillsIdEvent(skills: selectedSkillIds),
                              //     );
                              //   } else {
                              //     // Handle the case where no valid IDs are available
                              //     errorSnackBar(context, StringManager.pleaseCompleteYourData.tr());
                              //   }
                              // } else {
                              //   // Handle the case where no segments are selected
                              //   errorSnackBar(context, StringManager.pleaseCompleteYourData.tr());
                              // }

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
          ),
        ));
  }
}
