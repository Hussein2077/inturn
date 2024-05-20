import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/country_drop_down.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/major_drop_down.dart';
import 'package:inturn/core/widgets/snack_bar.dart';
import 'package:inturn/core/widgets/university.dart';
import 'package:inturn/features/auth/presentation/controller/add_info_bloc/add_info_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/add_info_bloc/add_info_events.dart';
import 'package:inturn/features/auth/presentation/controller/add_info_bloc/add_info_states.dart';
import 'package:inturn/features/auth/presentation/widgets/segment_button.dart';

class LocationInfo extends StatefulWidget {
  const LocationInfo({super.key});

  static int locationSegment = 0;

  @override
  State<LocationInfo> createState() => _LocationInfoState();
}

class _LocationInfoState extends State<LocationInfo> {

  void _onValueChanged(int newValue) {
    setState(() {
      LocationInfo.locationSegment = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context, text: StringManager.workLocationAndType.tr(),leading: true),
        body: BlocListener<AddPersonalInfoBloc, AddPersonalInfoState >(
          listener: (context, state) {
            if(state is AddLocationTypeSuccessState){
              EasyLoading.dismiss();
              Navigator.pushNamed(context, Routes.fieldInfo,);
            }
            else if(state is AddLocationTypeErrorState){
              EasyLoading.dismiss();
                  EasyLoading.showError(state.errorMessage);
            }
            else if(state is AddLocationTypeLoadingState){
              EasyLoading.show();
            }

          },
          child: Padding(
            padding: EdgeInsets.all(AppSize.defaultSize! * 1.5),
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const CitiesDropDown(),
              SizedBox(
                height: AppSize.defaultSize! * 2.4,
              ),
              CustomText(
                text: StringManager.selectLocationType.tr(),
                color: AppColors.thirdColor,
              ),
              SizedBox(
                height: AppSize.defaultSize! * 1.6,
              ),
              CustomSegmentedButton(
                segments: const ['On Site', 'Remotly', 'Hybrid'],
                onValueChanged: (index) => _onValueChanged(index),
                width: AppSize.defaultSize! * 10,
              ),
              SizedBox(
                height: AppSize.defaultSize! * 4,
              ),
              MainButton(
                text: StringManager.next.tr(),
                onTap: () {
                  if (CitiesDropDown.selectedValue != null &&
                      CitiesDropDown.selectedValue2 != null) {
                    BlocProvider.of<AddPersonalInfoBloc>(context).add(
                        SendLocationEvent(
                          countryID: CitiesDropDown.selectedValue?.countryId
                              .toString() ?? '',
                          cityID: CitiesDropDown.selectedValue2?.cityId
                              .toString() ?? '',
                          locationTypeID: (LocationInfo.locationSegment+1)
                              .toString(),)
                    );
                  } else {
                    errorSnackBar(
                        context, StringManager.pleaseCompleteYourData.tr());
                  }
                },
              ),
            ]),
          ),
        ));
  }
}
