import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/utils/enums.dart';
import 'package:inturn/core/widgets/loading_widget.dart';
import 'package:inturn/features/home/data/model/major_model.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_bloc.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_states.dart';

class MajorDropDown extends StatefulWidget {
  const MajorDropDown({
    super.key,
  });

  static MajorModel? selectedValue;

  @override
  State<MajorDropDown> createState() => _MajorDropDownState();
}

class _MajorDropDownState extends State<MajorDropDown> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionsBloc, GetOptionsStates>(
      builder: (context, state) {
        if (state.getMajorRequest == RequestState.loaded) {
          return Container(
            // width: AppSize.screenWidth! * .9,
            height: AppSize.defaultSize! * 5,
            decoration: BoxDecoration(
                border:
                    Border.all(color: AppColors.borderColor.withOpacity(.4)),
                borderRadius: BorderRadius.circular(AppSize.defaultSize! * .5)),
            child: DropdownButton2<MajorModel>(
              value: MajorDropDown.selectedValue,
              buttonStyleData: ButtonStyleData(
                width: AppSize.screenWidth! * .9,
              ),
              dropdownStyleData: DropdownStyleData(
                  width: AppSize.screenWidth! * .9,
                  // padding: EdgeInsets.symmetric(horizontal: 10),
                  maxHeight: AppSize.screenHeight! * .5),
              underline: const SizedBox(),
              onChanged: (MajorModel? newValue) {
                setState(() {
                  MajorDropDown.selectedValue = newValue;
                });
              },
              hint: Padding(
                padding: EdgeInsets.only(left: AppSize.defaultSize!),
                child: Text(
                  StringManager.selectSkill.tr(),
                  style: TextStyle(
                    fontSize: AppSize.defaultSize!,
                  ),
                ),
              ),
              items: state.getMajor
                  .map<DropdownMenuItem<MajorModel>>((MajorModel value) {
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
        } else if (state.getMajorRequest == RequestState.loading) {
          return Container(
            // width: AppSize.screenWidth! * .9,
            height: AppSize.defaultSize! * 4,
            decoration: BoxDecoration(
                border:
                    Border.all(color: AppColors.borderColor.withOpacity(.4)),
                borderRadius: BorderRadius.circular(AppSize.defaultSize! * .5)),
            child: DropdownButton2(
                buttonStyleData: ButtonStyleData(
                  width: AppSize.screenWidth! * .9,
                ),
                dropdownStyleData: DropdownStyleData(
                    width: AppSize.screenWidth! * .9,
                    // padding: EdgeInsets.symmetric(horizontal: 10),
                    maxHeight: AppSize.screenHeight! * .5),
                underline: const SizedBox(),
                hint: Padding(
                  padding: EdgeInsets.only(left: AppSize.defaultSize!),
                  child: Text(
                    StringManager.selectArea.tr(),
                    style: TextStyle(
                      fontSize: AppSize.defaultSize!,
                    ),
                  ),
                ),
                items: []),
          );
        } else if (state.getMajorRequest == RequestState.error) {
          return ErrorWidget(state.getMajorMessage);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
