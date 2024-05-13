import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/models/profile_data_model.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/utils/methods.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/loading_widget.dart';
import 'dart:developer';
import 'package:inturn/core/utils/enums.dart';
import 'package:inturn/features/auth/presentation/add_info_flow/skills.dart';
import 'package:inturn/features/auth/presentation/widgets/multi_select2.dart';
import 'package:inturn/features/home/data/model/skill_model.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_bloc.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_states.dart';
import 'package:searchfield/searchfield.dart';

class ProfileSkills extends StatefulWidget {
  const ProfileSkills({super.key, required this.profileDataModel});
final ProfileDataModel? profileDataModel;
static  List<CommonType> newSkills=[];
  @override
  State<ProfileSkills> createState() => _ProfileSkillsState();
}

class _ProfileSkillsState extends State<ProfileSkills> {
  late TextEditingController controller ;
  ValueNotifier<int> addToSkill = ValueNotifier<int>(0);
  List<int> _currentSegment = [-1];

  void _onValueChanged(List<int> newValue) {
    setState(() {
      _currentSegment = newValue;
    });
  }
  @override
  void initState() {
    if(widget.profileDataModel?.user?.userSkills!=null) {
      ProfileSkills.newSkills=Methods.instance.castLists( SkillInfo.skillIds, widget.profileDataModel!.user!.userSkills!);
    }

    controller = TextEditingController();
    super.initState();
  }
@override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: EdgeInsets.symmetric(
          vertical: AppSize.defaultSize! * 2),
      child: Material(
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
                  text: StringManager.skills.tr(),
                  fontSize: AppSize.defaultSize! * 1.6,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: AppSize.defaultSize! * 1.6,
                ),
                BlocBuilder<OptionsBloc, GetOptionsStates>(
                  builder: (context, state2) {
                    log('sijvgwogbowgowrgb');

                    if (state2.getSkillsRequest ==
                        RequestState.loading) {
                      return const LoadingWidget();
                    } else if (state2.getSkillsRequest ==
                        RequestState.loaded) {
                      return SearchField<SkillModel>(
                        controller: controller,
                        itemHeight: AppSize.defaultSize! * 5,
                        onSuggestionTap: (v) {
                          v.item!.skillId;
                          // ProfileSkills.newSkills.add(v.item! as CommonType);
                          if(! ProfileSkills.newSkills.contains(CommonType(v.item!.skillNameEn!, v.item!.skillId!))) {
                            ProfileSkills.newSkills.add(CommonType(v.item!.skillNameEn!, v.item!.skillId!));
                          }

                            // ProfileSkills.newSkills.addAll(v.item!.((b) => CommonType(b.name, b.description.length)));


                          addToSkill.value++;
                          controller.clear();

                          _currentSegment = SkillInfo.skillIds
                              .map((e) => SkillInfo.skillIds
                              .indexOf(e))
                              .toList();
                        },

                        suggestions: state2.getSkills
                            .map(
                              (e) => SearchFieldListItem<
                                  SkillModel>(
                            e.skillNameEn ?? "",
                            item: e,
                            // Use child to show Custom Widgets in the suggestions
                            // defaults to Text widget
                            child: Padding(
                              padding: EdgeInsets.all(
                                  AppSize.defaultSize!),
                              child: CustomText(
                                  text: e.skillNameEn ??
                                      ""),
                            ),
                          ),
                        )
                            .toList(),
                        hint: StringManager.searchForSkills
                            .tr(),
                        searchStyle: TextStyle(
                          fontSize:
                          AppSize.defaultSize! * 1.2,
                          decoration: TextDecoration.none,
                          color:
                          Colors.black.withOpacity(0.8),
                        ),
                        // autofocus: true,
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
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
                          ProfileSkills.newSkills.removeAt(i);
                          addToSkill.value++;
                        },
                        segments: ProfileSkills.newSkills
                            .map((e) => e.skillNameEn ?? "")
                            .toList(),
                        onValueChanged: (index) =>
                            _onValueChanged(index),
                        initialSelectedIndexes:  ProfileSkills.newSkills
                            .map((e) =>
                            ProfileSkills.newSkills.indexOf(e))
                            .toList(),
                      );
                    }),
                SizedBox(
                  height: AppSize.defaultSize! * 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
