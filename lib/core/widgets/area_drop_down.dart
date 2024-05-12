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
import 'package:inturn/features/home/data/model/cities_model.dart';
import 'package:inturn/features/home/data/model/faculty_model.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_bloc.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_events.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_states.dart';
class CitiesDropDown extends StatefulWidget {
  final bool? showCountry;
  const CitiesDropDown({
    super.key,
    this.showCountry,
  });
static  Country? selectedValue;
static  CityModel? selectedValue2 ;
  @override
  State<CitiesDropDown> createState() => _CitiesDropDownState();
}

class _CitiesDropDownState extends State<CitiesDropDown> {
  List<CityModel>? cityModel;
@override
  void initState() {
    BlocProvider.of<OptionsBloc>(context).add(const GetCitiesEvent());
     super.initState();
  }
  @override
  void dispose() {
    CitiesDropDown.selectedValue=null;
    CitiesDropDown.selectedValue2=null;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionsBloc, GetOptionsStates>(
      builder: (context, state) {
        if (state.getCitiesRequest == RequestState.loaded) {
          return Column(
            children: [
              if(widget.showCountry?? true)
              Container(
                // width: AppSize.screenWidth! * .9,
                height: AppSize.defaultSize! * 5,
                decoration: BoxDecoration(
                    border:
                    Border.all(color: AppColors.borderColor.withOpacity(.4)),
                    borderRadius: BorderRadius.circular(AppSize.defaultSize! * 2)),
                child: DropdownButton2<Country>(
                  value: CitiesDropDown.selectedValue,
                  buttonStyleData: ButtonStyleData(
                    width: AppSize.screenWidth! * .9,
                  ),
                  dropdownStyleData: DropdownStyleData(
                      width: AppSize.screenWidth! * .9,
                      // padding: EdgeInsets.symmetric(horizontal: 10),
                      maxHeight: AppSize.screenHeight! * .5),
                  underline: const SizedBox(),
                  onChanged: (Country? newValue) {
                    setState(() {
                      CitiesDropDown.selectedValue = newValue;
                      cityModel=CitiesDropDown.selectedValue?.cities;
                    });
                  },

                  hint: Padding(
                    padding:   EdgeInsets.only(left: AppSize.defaultSize!),
                    child: Text(
                      StringManager.selectCountry.tr(),
                      style: TextStyle(
                        fontSize: AppSize.defaultSize!,
                      ),
                    ),
                  ),
                  items: state.getCities
                      .map<DropdownMenuItem<Country>>((Country value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Padding(
                        padding: EdgeInsets.only(left: AppSize.defaultSize!),
                        child: Text(
                          value.countryNameEn ?? "",
                          style: TextStyle(
                            fontSize: AppSize.defaultSize!,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              if(widget.showCountry?? true)
                SizedBox(
                height: AppSize.defaultSize! * 2,
              ),
              Container(
                // width: AppSize.screenWidth! * .9,
                height: AppSize.defaultSize! * 5,
                decoration: BoxDecoration(
                    border:
                    Border.all(color: AppColors.borderColor.withOpacity(.4)),
                    borderRadius: BorderRadius.circular(AppSize.defaultSize! * 2)),
                child: DropdownButton2<CityModel>(
                  value: CitiesDropDown.selectedValue2,
                  buttonStyleData: ButtonStyleData(
                    width: AppSize.screenWidth! * .9,
                  ),
                  dropdownStyleData: DropdownStyleData(
                      width: AppSize.screenWidth! * .9,
                      // padding: EdgeInsets.symmetric(horizontal: 10),
                      maxHeight: AppSize.screenHeight! * .5),
                  underline: const SizedBox(),
                  onChanged: (CityModel? newValue) {
                    setState(() {
                      CitiesDropDown.selectedValue2 = newValue;
                    });
                  },

                  hint: Padding(
                    padding:   EdgeInsets.only(left: AppSize.defaultSize!),
                    child: Text(
                      StringManager.selectCity.tr(),
                      style: TextStyle(
                        fontSize: AppSize.defaultSize!,
                      ),
                    ),
                  ),
                  items:
                  (cityModel??( state.getCities.isNotEmpty?  state.getCities[0].cities:[])??[])
                      .map<DropdownMenuItem<CityModel>>((CityModel value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Padding(
                        padding: EdgeInsets.only(left: AppSize.defaultSize!),
                        child: Text(
                          value.cityNameEn,
                          style: TextStyle(
                            fontSize: AppSize.defaultSize!,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        } else if (state.getCitiesRequest == RequestState.loading) {
          return loadingCity();
        } else if (state.getCitiesRequest == RequestState.error) {
          return ErrorWidget(state.getCitiesMessage);
        } else {
          return const SizedBox();
        }
      },
    );
  }
  loadingCity(){
    return  Column(
      children: [
        Container(
          // width: AppSize.screenWidth! * .9,
          height: AppSize.defaultSize! * 5,
          decoration: BoxDecoration(
              border:
              Border.all(color: AppColors.borderColor.withOpacity(.4)),
              borderRadius: BorderRadius.circular(AppSize.defaultSize! * 2)),
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
                  StringManager.selectCountry.tr(),
                  style: TextStyle(
                    fontSize: AppSize.defaultSize!,
                  ),
                ),
              ),
              items: []

          ),
        ),
        SizedBox(
          height: AppSize.defaultSize! * 2,
        ),
        Container(
          // width: AppSize.screenWidth! * .9,
          height: AppSize.defaultSize! * 5,
          decoration: BoxDecoration(
              border:
              Border.all(color: AppColors.borderColor.withOpacity(.4)),
              borderRadius: BorderRadius.circular(AppSize.defaultSize! * 2)),
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
                  StringManager.selectCity.tr(),
                  style: TextStyle(
                    fontSize: AppSize.defaultSize!,
                  ),
                ),
              ),
              items: []

          ),
        ),
      ],
    );
  }
}
