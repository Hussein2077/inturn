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
import 'package:inturn/features/home/data/model/university_model.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_bloc.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_events.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_states.dart';

class UniversityDropDown extends StatefulWidget {
  const UniversityDropDown({
    super.key,
    this.universityId,
  });

  static UniversityModel? selectedValue;
  final UniversityModel? universityId;

  @override
  State<UniversityDropDown> createState() => _UniversityDropDownState();
}

class _UniversityDropDownState extends State<UniversityDropDown> {
  @override
  void initState() {
    BlocProvider.of<OptionsBloc>(context).add(const GetUniversityEvent());

    super.initState();
  }

  @override
  void dispose() {
    UniversityDropDown.selectedValue = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<OptionsBloc, GetOptionsStates>(
      builder: (context, state) {
        if (state.getUniversityRequest == RequestState.loaded) {
          log('${UniversityDropDown.selectedValue}');
          log('${widget.universityId}');
           log('${ state.getUniversity.contains(widget.universityId)}fbwbwe');
          return Container(
            height: AppSize.defaultSize! * 5,
            decoration: BoxDecoration(
                border:
                    Border.all(color: AppColors.borderColor.withOpacity(.4)),
                borderRadius: BorderRadius.circular(AppSize.defaultSize! * 2)),
            child: DropdownButton2<UniversityModel>(
              value:widget.universityId==null?UniversityDropDown.selectedValue: ( state.getUniversity.contains(widget.universityId)
                  ? UniversityDropDown.selectedValue
                  : null),

              buttonStyleData: ButtonStyleData(
                  width: AppSize.screenWidth! * .9,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(AppSize.defaultSize! * 2),
                  )),
              dropdownStyleData: DropdownStyleData(
                  width: AppSize.screenWidth! * .9,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(AppSize.defaultSize! * 2),
                  ),
                  // padding: EdgeInsets.symmetric(horizontal: 10),
                  maxHeight: AppSize.screenHeight! * .5),
              underline: const SizedBox(),
              onChanged: (UniversityModel? newValue) {
                log('newValue: $newValue');
                setState(() {
                  UniversityDropDown.selectedValue = newValue;
                });
                BlocProvider.of<OptionsBloc>(context).add(GetFacultyEvent(
                    UniversityDropDown.selectedValue!.universityId!));
              },
              hint: Padding(
                padding: EdgeInsets.only(left: AppSize.defaultSize!),
                child: Text(

                      StringManager.university.tr(),
                  style: TextStyle(
                    fontSize: AppSize.defaultSize!,
                  ),
                ),
              ),
              items: state.getUniversity.map<DropdownMenuItem<UniversityModel>>(
                  (UniversityModel value) {
                return DropdownMenuItem(
                  value: value,
                  child: Padding(
                    padding: EdgeInsets.only(left: AppSize.defaultSize!),
                    child: Text(
                      value.universityName ?? "",
                      style: TextStyle(
                        fontSize: AppSize.defaultSize!,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        } else if (state.getUniversityRequest == RequestState.loading) {
          return const LoadingWidget();
          //   Container(
          //   height: AppSize.defaultSize! * 5,
          //   decoration: BoxDecoration(
          //       border:
          //           Border.all(color: AppColors.borderColor.withOpacity(.4)),
          //       borderRadius: BorderRadius.circular(AppSize.defaultSize! * 2)),
          //   child: DropdownButton2(
          //       buttonStyleData: ButtonStyleData(
          //           width: AppSize.screenWidth! * .9,
          //           decoration: BoxDecoration(
          //             borderRadius:
          //                 BorderRadius.circular(AppSize.defaultSize! * 2),
          //           )),
          //       dropdownStyleData: DropdownStyleData(
          //           width: AppSize.screenWidth! * .9,
          //           // padding: EdgeInsets.symmetric(horizontal: 10),
          //           maxHeight: AppSize.screenHeight! * .5),
          //       underline: const SizedBox(),
          //       hint: Padding(
          //         padding: EdgeInsets.only(left: AppSize.defaultSize!),
          //         child: Text(
          //           StringManager.selectUniversity.tr(),
          //           style: TextStyle(
          //             fontSize: AppSize.defaultSize!,
          //           ),
          //         ),
          //       ),
          //       items: []),
          // );
        } else if (state.getUniversityRequest == RequestState.error) {
          return ErrorWidget(state.getUniversityMessage);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
