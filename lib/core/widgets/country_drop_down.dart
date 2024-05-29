import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/utils/enums.dart';
import 'package:inturn/core/widgets/area_drop_down.dart';
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
  ValueNotifier<bool> cityVisible = ValueNotifier<bool>(false);
  ValueNotifier<bool> areaVisible = ValueNotifier<bool>(false);


@override
  void initState() {
    BlocProvider.of<OptionsBloc>(context).add(const GetCitiesEvent());
    cityVisible.value=cityModel!=null;
    areaVisible.value=CitiesDropDown.selectedValue2!=null;

    super.initState();
  }
  @override
  void dispose() {
    // CitiesDropDown.selectedValue=null;
    // CitiesDropDown.selectedValue2=null;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    cityVisible.value=cityModel!=null;
    areaVisible.value=CitiesDropDown.selectedValue2!=null;
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
                child: Center(
                  child: DropdownButton2<Country>(
                    value:state.getCities.contains(CitiesDropDown.selectedValue)? CitiesDropDown.selectedValue:null,
                    buttonStyleData: ButtonStyleData(
                      width: AppSize.screenWidth! * .9,
                    ), iconStyleData: IconStyleData(
                    iconSize: AppSize.defaultSize! * 2.5,
                  ),
                    dropdownStyleData: DropdownStyleData(
                        width: AppSize.screenWidth! * .9,
                        // padding: EdgeInsets.symmetric(horizontal: 10),
                        maxHeight: AppSize.screenHeight! * .5),
                    underline: const SizedBox(),
                    onChanged: (Country? newValue) {
                      setState(() {
                        CitiesDropDown.selectedValue = newValue;
                        cityModel=newValue?.cities;
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
              ),
              if(cityVisible.value)
                SizedBox(
                height: AppSize.defaultSize! * 2,
              ),
              ValueListenableBuilder(
                  valueListenable:  cityVisible,

                  builder: (context_, value, child) {
                    if(value) {
                      return Container(
                    // width: AppSize.screenWidth! * .9,
                    height: AppSize.defaultSize! * 5,
                    decoration: BoxDecoration(
                        border:
                        Border.all(color: AppColors.borderColor.withOpacity(.4)),
                        borderRadius: BorderRadius.circular(AppSize.defaultSize! * 2)),
                    child: Center(
                      child: DropdownButton2<CityModel>(
                        value:(cityModel?.contains(CitiesDropDown.selectedValue2)??false)? CitiesDropDown.selectedValue2:null,
                        buttonStyleData: ButtonStyleData(
                          width: AppSize.screenWidth! * .9,
                        ), iconStyleData: IconStyleData(
                        iconSize: AppSize.defaultSize! * 2.5,
                      ),
                        dropdownStyleData: DropdownStyleData(
                            width: AppSize.screenWidth! * .9,
                            // padding: EdgeInsets.symmetric(horizontal: 10),
                            maxHeight: AppSize.screenHeight! * .5),
                        underline: const SizedBox(),
                        onChanged: (CityModel? newValue) {
                          AreaDropDown.selectedValue2=null;

                          BlocProvider.of<OptionsBloc>(context).add(  GetAreasEvent(newValue?.cityId??  (CitiesDropDown.selectedValue2 ?.cityId??1)));
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
                  );
                    }
                    else {
                      return const SizedBox();
                    }
                }
              ),
              SizedBox(
                height: AppSize.defaultSize! * 2,
              ),
              ValueListenableBuilder(
                  valueListenable: areaVisible,

                  builder: (context_, value, child) {
                    if(value) {
                      return AreaDropDown(cityId: CitiesDropDown.selectedValue2?.cityId??1);
                    }
                    else {
                      return const SizedBox();
                    }
                }
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
              ), iconStyleData: IconStyleData(
            iconSize: AppSize.defaultSize! * 2.5,
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
              ), iconStyleData: IconStyleData(
            iconSize: AppSize.defaultSize! * 2.5,
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
