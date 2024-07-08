import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inturn/core/models/profile_data_model.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/utils/methods.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/loading_widget.dart';
import 'package:inturn/features/auth/presentation/add_info_flow/fields_of_work.dart';
import 'package:inturn/features/auth/presentation/widgets/multi_segment.dart';
import 'package:inturn/features/auth/presentation/widgets/multi_select2.dart';
import 'package:inturn/features/home/data/model/major_model.dart';
import 'package:inturn/features/home/presentation/controller/get_major/bloc.dart';
import 'package:inturn/features/home/presentation/controller/get_major/event.dart';
import 'package:inturn/features/home/presentation/controller/get_major/state.dart';
import 'package:inturn/features/home/presentation/controller/top_five_and_blogs/get_top_five_bloc.dart';
import 'package:inturn/features/home/presentation/controller/top_five_and_blogs/get_top_five_event.dart';
import 'package:inturn/features/home/presentation/controller/top_five_and_blogs/get_top_five_state.dart';
import 'package:searchfield/searchfield.dart';

class ProfileMajor extends StatefulWidget {
  const ProfileMajor({super.key, required this.profileDataModel});

  final ProfileDataModel? profileDataModel;
  static List<CommonType> newMajors = [];

  @override
  State<ProfileMajor> createState() => _ProfileMajorState();
}

class _ProfileMajorState extends State<ProfileMajor> {
  late TextEditingController controller;

  @override
  initState() {
    BlocProvider.of<GetMajorBloc>(context).add(GetMajorEvent());
    for (int i = 0;
        i < widget.profileDataModel!.user!.userMajors!.length;
        i++) {
      ProfileMajor.newMajors.add(CommonType(
          widget.profileDataModel!.user!.userMajors![i].major!.majorNameEn!,
          widget.profileDataModel!.user!.userMajors![i].majorId!));
    }
    ProfileMajor.newMajors.toSet();

    controller = TextEditingController();
    super.initState();
  }

  List<int> _currentSegment = [-1];

  void _onValueChanged(List<int> newValue) {
    log('${FieldsInfo.majorsId} FieldsInfo.id');
    setState(() {
      _currentSegment = newValue;
    });
  }

  Widget closeIcon = Transform.rotate(
    angle: 180 * 3.14 / 180,
    child: SvgPicture.asset(
      AssetPath.collapsed,
    ),
  );

  Widget openIcon = SvgPicture.asset(
    AssetPath.collapsed,
  );
  ValueNotifier<int> addToMajor = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMajorBloc, GetMajorsState>(
      builder: (context, state1) {
        if (state1 is GetMajorLoadingState) {
          return const Center(child: LoadingWidget());
        } else if (state1 is GetMajorSuccessMessageState) {
          List<Position> listOfPosition = [];
          for (int i = 0; i < state1.topFiveModel.length; i++) {
            for (int j = 0; j < state1.topFiveModel[i].positions.length; j++) {
              listOfPosition.add(state1.topFiveModel[i].positions[j]);
            }
          }

          return Material(
              borderRadius: BorderRadius.circular(AppSize.defaultSize! * 1.5),
              elevation: 1,
              child: Container(
                  width: AppSize.screenWidth!,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(AppSize.defaultSize! * 1.5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(AppSize.defaultSize! * 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: StringManager.majors.tr(),
                          fontSize: AppSize.defaultSize! * 1.6,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(
                          height: AppSize.defaultSize! * 1.6,
                        ),
                        SearchField<Position>(
                          controller: controller,
                          itemHeight: AppSize.defaultSize! * 5,
                          onSuggestionTap: (v) {
                            v.item!.majorId;
                            if (!ProfileMajor.newMajors.contains(CommonType(
                                v.item!.majorNameEn, v.item!.majorId))) {
                              ProfileMajor.newMajors.add(CommonType(
                                  v.item!.majorNameEn, v.item!.majorId));
                            }
                            addToMajor.value++;
                            controller.clear();
                            _currentSegment = FieldsInfo.majorsId
                                .map((e) => FieldsInfo.majorsId.indexOf(e))
                                .toList();
                          },

                          suggestions: listOfPosition
                              .map(
                                (e) => SearchFieldListItem<Position>(
                                  e.majorNameEn ?? "",
                                  item: e,
                                  // Use child to show Custom Widgets in the suggestions
                                  // defaults to Text widget
                                  child: Padding(
                                    padding:
                                        EdgeInsets.all(AppSize.defaultSize!),
                                    child:
                                        CustomText(text: e.majorNameEn ?? ""),
                                  ),
                                ),
                              )
                              .toList(),
                          hint: StringManager.searchForMajors.tr(),
                          searchStyle: TextStyle(
                            fontSize: AppSize.defaultSize! * 1.2,
                            decoration: TextDecoration.none,
                            color: Colors.black.withOpacity(0.8),
                          ),
                          // autofocus: true,
                        ),
                        SizedBox(
                          height: AppSize.defaultSize! * 3,
                        ),
                        CustomText(
                          text: StringManager.selectMajor.tr(),
                          color: AppColors.thirdColor,
                        ),
                        SizedBox(
                          height: AppSize.defaultSize! * 3,
                        ),
                        ValueListenableBuilder(
                            valueListenable: addToMajor,
                            builder: (context_, value, child) {
                              ProfileMajor.newMajors =
                                  ProfileMajor.newMajors.toSet().toList();
                              log('${ProfileMajor.newMajors}  ProfileMajor.newMajors');
                              return CustomSegmentedButton2(
                                onTapClose: (i) {
                                  ProfileMajor.newMajors.removeAt(i);
                                  addToMajor.value++;
                                },
                                segments: ProfileMajor.newMajors
                                    .map((e) => e.nameEn ?? "")
                                    .toList(),
                                onValueChanged: (index) =>
                                    _onValueChanged(index),
                                initialSelectedIndexes: ProfileMajor.newMajors
                                    .map((e) =>
                                        ProfileMajor.newMajors.indexOf(e))
                                    .toList(),
                              );
                            }),
                      ],
                    ),
                  )));
        }
        return Container();
      },
    );
  }
}
/*
  CustomText(
                          text: StringManager.yourFields.tr(),
                          fontSize: AppSize.defaultSize! * 1.6,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                        CustomSegmentedButton2(
                          segments: widget.profileDataModel?.user?.userMajors
                                  ?.map((e) => e.major?.majorNameEn??"")
                                  .toSet().toList() ??
                              [],
                          showClose: false,
                          onValueChanged: (List<int> list) {},
                          onTapClose: (int index) {},
                        ),
                        CustomText(
                          text: StringManager.updateFields.tr(),
                          fontSize: AppSize.defaultSize! * 1.6,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(
                          height: AppSize.defaultSize! * 1.6,
                        ),
                        ListView.builder(
                            itemCount: state1.topFiveModel.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              // List<int> selected = [];
                              // for (int i = 0;
                              // i < state1.topFiveModel.length;
                              // i++) {
                              //   selected = Methods.instance
                              //       .findCommonItems(
                              //       state1.topFiveModel[i]
                              //           .positions,
                              //       widget.profileDataModel!
                              //           .user!.userMajors??[]);
                              // }
                              return CustomAccordion(
                                title: state1.topFiveModel[index].field,
                                showContent: true,
                                headerBackgroundColor: Colors.transparent,
                                titleStyle: TextStyle(
                                  color: AppColors.thirdColor,
                                  fontSize: AppSize.defaultSize! * 1.4,
                                  fontWeight: FontWeight.w400,
                                ),
                                toggleIconOpen: openIcon,
                                toggleIconClose: closeIcon,
                                headerIconColor: AppColors.primaryColor,
                                accordionElevation: 0,
                                widgetItems: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    MultiSegmentedButton(
                                      initialIndex: index,
                                      segments: state1.topFiveModel,
                                      ids: state1.topFiveModel[index].positions
                                          .map((position) => position.majorId)
                                          .toList(),
                                      onValueChanged: (index) =>
                                          _onValueChanged(index),
                                    ),
                                  ],
                                ),
                              );
                            }),
 */
