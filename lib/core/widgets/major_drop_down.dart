import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/utils/enums.dart';
import 'package:inturn/core/widgets/loading_widget.dart';
import 'package:inturn/features/home/data/model/faculty_model.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_bloc.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_events.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_states.dart';

class FacultyDropDown extends StatefulWidget {
  const FacultyDropDown({
    super.key,
    this.facultyId,
  });

  static FacultyModel? selectedValue;
  final FacultyModel? facultyId;

  @override
  State<FacultyDropDown> createState() => _FacultyDropDownState();
}

class _FacultyDropDownState extends State<FacultyDropDown> {
  @override
  void initState() {
    FacultyDropDown.selectedValue = widget.facultyId;
    if(widget.facultyId?.universityId!=null) {
      BlocProvider.of<OptionsBloc>(context).add(GetFacultyEvent(
        widget.facultyId!.universityId!));
    }
    super.initState();
  }

  @override
  void dispose() {
    FacultyDropDown.selectedValue = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionsBloc, GetOptionsStates>(
      builder: (context, state) {
        if (state.getFacultyRequest == RequestState.loaded) {
          return Container(
            // width: AppSize.screenWidth! * .9,
            height: AppSize.defaultSize! * 5,
            decoration: BoxDecoration(
                border:
                    Border.all(color: AppColors.borderColor.withOpacity(.4)),
                borderRadius: BorderRadius.circular(AppSize.defaultSize! * 2)),
            child: DropdownButton2<FacultyModel>(
              value: state.getFaculty.contains(widget.facultyId) ? widget.facultyId : null,
              buttonStyleData: ButtonStyleData(
                  width: AppSize.screenWidth! * .9,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(AppSize.defaultSize! * 2),
                  )),
              dropdownStyleData: DropdownStyleData(
                  width: AppSize.screenWidth! * .9,
                  // padding: EdgeInsets.symmetric(horizontal: 10),
                  maxHeight: AppSize.screenHeight! * .5),
              underline: const SizedBox(),
              onChanged: (FacultyModel? newValue) {
                setState(() {
                  FacultyDropDown.selectedValue = newValue;
                });
              },
              hint: Padding(
                padding: EdgeInsets.only(left: AppSize.defaultSize!),
                child: Text(
                 widget.facultyId?.name ?? StringManager.selectFaculty.tr(),
                  style: TextStyle(
                    fontSize: AppSize.defaultSize!,
                  ),
                ),
              ),
              items: state.getFaculty
                  .map<DropdownMenuItem<FacultyModel>>((FacultyModel value) {
                return DropdownMenuItem(
                  value: value,
                  child: Padding(
                    padding: EdgeInsets.only(left: AppSize.defaultSize!),
                    child: Text(
                      value.name ?? "",
                      style: TextStyle(
                        fontSize: AppSize.defaultSize!,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        } else if (state.getFacultyRequest == RequestState.loading) {
          return Container(
            // width: AppSize.screenWidth! * .9,
            height: AppSize.defaultSize! * 4,
            decoration: BoxDecoration(
                border:
                    Border.all(color: AppColors.borderColor.withOpacity(.4)),
                borderRadius: BorderRadius.circular(AppSize.defaultSize! * 2)),
            child: DropdownButton2(
                buttonStyleData: ButtonStyleData(
                    width: AppSize.screenWidth! * .9,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppSize.defaultSize! * 2),
                    )),
                dropdownStyleData: DropdownStyleData(
                    width: AppSize.screenWidth! * .9,
                    // padding: EdgeInsets.symmetric(horizontal: 10),
                    maxHeight: AppSize.screenHeight! * .5),
                underline: const SizedBox(),
                hint: Padding(
                  padding: EdgeInsets.only(left: AppSize.defaultSize!),
                  child: Text(
                    StringManager.selectFaculty.tr(),
                    style: TextStyle(
                      fontSize: AppSize.defaultSize!,
                    ),
                  ),
                ),
                items: []),
          );
        } else if (state.getFacultyRequest == RequestState.error) {
          return ErrorWidget(state.getFacultyMessage);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
