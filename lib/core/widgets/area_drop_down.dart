import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/utils/enums.dart';
import 'package:inturn/core/widgets/loading_widget.dart';
import 'package:inturn/features/home/data/model/cities_model.dart';
import 'package:inturn/features/home/data/model/major_model.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_bloc.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_states.dart';
class CitiesDropDown extends StatefulWidget {
  const CitiesDropDown({
    super.key,
  });
static  CitiesModel? selectedValue;
  @override
  State<CitiesDropDown> createState() => _CitiesDropDownState();
}

class _CitiesDropDownState extends State<CitiesDropDown> {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionsBloc, GetOptionsStates>(
      builder: (context, state) {
        if (state.getCitiesRequest == RequestState.loaded) {
          return Container(
            // width: AppSize.screenWidth! * .9,
            height: AppSize.defaultSize! * 4,
            decoration: BoxDecoration(
                border:
                Border.all(color: AppColors.borderColor.withOpacity(.4)),
                borderRadius: BorderRadius.circular(AppSize.defaultSize! * .5)),
            child: DropdownButton2<CitiesModel>(
              value: CitiesDropDown.selectedValue,
              buttonStyleData: ButtonStyleData(
                width: AppSize.screenWidth! * .9,
              ),
              dropdownStyleData: DropdownStyleData(
                  width: AppSize.screenWidth! * .9,
                  // padding: EdgeInsets.symmetric(horizontal: 10),
                  maxHeight: AppSize.screenHeight! * .5),
              underline: const SizedBox(),
              onChanged: (CitiesModel? newValue) {
                setState(() {
                  CitiesDropDown.selectedValue = newValue;
                });
              },

              hint: Padding(
                padding:   EdgeInsets.only(left: AppSize.defaultSize!),
                child: Text(
                  StringManager.selectArea.tr(),
                  style: TextStyle(
                    fontSize: AppSize.defaultSize!,
                  ),
                ),
              ),
              items: state.getCities
                  .map<DropdownMenuItem<CitiesModel>>((CitiesModel value) {
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
        } else if (state.getCitiesRequest == RequestState.loading) {
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
                padding:   EdgeInsets.only(left: AppSize.defaultSize!),
                child: Text(
                  StringManager.selectArea.tr(),
                  style: TextStyle(
                    fontSize: AppSize.defaultSize!,
                  ),
                ),
              ),
              items: []

            ),
          );
        } else if (state.getCitiesRequest == RequestState.error) {
          return ErrorWidget(state.getCitiesMessage);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
