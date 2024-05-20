import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/utils/enums.dart';
import 'package:inturn/core/widgets/loading_widget.dart';
import 'package:inturn/features/home/data/model/area_model.dart';
import 'package:inturn/features/home/data/model/area_model.dart';
import 'package:inturn/features/home/data/model/area_model.dart';
import 'package:inturn/features/home/data/model/area_model.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_bloc.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_states.dart';

class AreaDropDown extends StatefulWidget {
  const AreaDropDown({super.key, required this.cityId});

  final int cityId;
  static AreaModel? selectedValue2;

  @override
  State<AreaDropDown> createState() => _AreaDropDownState();
}

class _AreaDropDownState extends State<AreaDropDown> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionsBloc, GetOptionsStates>(
      builder: (context, state) {
        if (state.getAreasRequest == RequestState.loaded) {
          return Container(
          // width: AppSize.screenWidth! * .9,
          height: AppSize.defaultSize! * 5,
          decoration: BoxDecoration(
              border:
              Border.all(color: AppColors.borderColor.withOpacity(.4)),
              borderRadius: BorderRadius.circular(AppSize.defaultSize! * 2)),
          child: Center(
            child: DropdownButton2<AreaModel>(
              value:state.getAreas.contains(AreaDropDown.selectedValue2)? AreaDropDown.selectedValue2:null,
              buttonStyleData: ButtonStyleData(
                width: AppSize.screenWidth! * .9,
              ),
              iconStyleData: IconStyleData(
                iconSize: AppSize.defaultSize! * 2.5,
              ),
              dropdownStyleData: DropdownStyleData(
                  width: AppSize.screenWidth! * .9,
                  // padding: EdgeInsets.symmetric(horizontal: 10),
                  maxHeight: AppSize.screenHeight! * .5),
              underline: const SizedBox(),
              onChanged: (AreaModel? newValue) {
                setState(() {
                  AreaDropDown.selectedValue2 = newValue;
                });
              },

              hint: Padding(
                padding: EdgeInsets.only(left: AppSize.defaultSize!),
                child: Text(
                  StringManager.selectArea.tr(),
                  style: TextStyle(
                    fontSize: AppSize.defaultSize!,
                  ),
                ),
              ),
              items:
              (state.getAreas)
                  .map<DropdownMenuItem<AreaModel>>((AreaModel value) {
                return DropdownMenuItem(
                  value: value,
                  child: Padding(
                    padding: EdgeInsets.only(left: AppSize.defaultSize!),
                    child: Text(
                      value.areaNameEn??"",
                      style: TextStyle(
                        fontSize: AppSize.defaultSize!,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
        }
        else if (state.getAreasRequest == RequestState.loading) {
          return Container(
            // width: AppSize.screenWidth! * .9,
            height: AppSize.defaultSize! * 5,
            decoration: BoxDecoration(
                border:
                Border.all(color: AppColors.borderColor.withOpacity(.4)),
                borderRadius: BorderRadius.circular(AppSize.defaultSize! * 2)),
            child: Center(
              child: DropdownButton2<AreaModel>(
                // value:AreaDropDown.selectedValue2,
                buttonStyleData: ButtonStyleData(
                  width: AppSize.screenWidth! * .9,
                ),
                iconStyleData: IconStyleData(
                  iconSize: AppSize.defaultSize! * 2.5,
                ),
                dropdownStyleData: DropdownStyleData(
                    width: AppSize.screenWidth! * .9,
                    // padding: EdgeInsets.symmetric(horizontal: 10),
                    maxHeight: AppSize.screenHeight! * .5),
                underline: const SizedBox(),
                onChanged: (AreaModel? newValue) {
                  setState(() {
                    AreaDropDown.selectedValue2 = newValue;
                  });
                },

                hint: Padding(
                  padding: EdgeInsets.only(left: AppSize.defaultSize!),
                  child: Text(
                    StringManager.selectArea.tr(),
                    style: TextStyle(
                      fontSize: AppSize.defaultSize!,
                    ),
                  ),
                ),
                items:[]

              ),
            ),
          );
        } else if (state.getAreasRequest == RequestState.error) {
          return ErrorWidget(state.getAreasMessage);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
