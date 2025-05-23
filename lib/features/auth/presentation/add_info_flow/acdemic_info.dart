import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/major_drop_down.dart';
import 'package:inturn/core/widgets/snack_bar.dart';
import 'package:inturn/core/widgets/university.dart';
import 'package:inturn/features/auth/presentation/controller/add_info_bloc/add_info_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/add_info_bloc/add_info_events.dart';
import 'package:inturn/features/auth/presentation/controller/add_info_bloc/add_info_states.dart';

class AcademicInfo extends StatelessWidget {
  const AcademicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
        appBar(context, text: StringManager.fillAcademicInformation.tr(),leading: true,actions: true),
        body: BlocListener<AddPersonalInfoBloc, AddPersonalInfoState >(
          listener: (context, state) {
            if (state is AddUniversitySuccessState) {
              EasyLoading.dismiss();
              Navigator.pushNamed(context, Routes.experienceInfo,);
            }
            else if (state is AddUniversityErrorState) {
              EasyLoading.dismiss();
              EasyLoading.showError(state.errorMessage);
            }
            else if(state  is AddUniversityLoadingState){
              EasyLoading.show();
            }

          },
          child: Padding(
            padding: EdgeInsets.all(AppSize.defaultSize! * 1.5),
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              const UniversityDropDown(),
              SizedBox(
                height: AppSize.defaultSize! * 2,
              ),
              const FacultyDropDown(),
              SizedBox(
                height: AppSize.defaultSize! * 4,
              ),
              MainButton(
                text: StringManager.next.tr(),
                onTap: () {
                  if (UniversityDropDown.selectedValue != null &&
                      FacultyDropDown.selectedValue != null) {
                    BlocProvider.of<AddPersonalInfoBloc>(context).add(
                        AddUniversityAndFacultiesEvent(
                            universityId: UniversityDropDown.selectedValue
                                ?.universityId.toString() ?? "",
                            facultyId: FacultyDropDown.selectedValue?.id
                                .toString() ?? ""));
                  } else if(UniversityDropDown.selectedValue == null) {
                    errorSnackBar(
                        context, StringManager.pleaseAddUniversity.tr());
                  }else if( FacultyDropDown.selectedValue == null) {
                    errorSnackBar(
                        context, StringManager.pleaseAddFaculty.tr());
                  }

                },
              ),
            ]),
          ),
        ));
  }
}
