
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/custom_text_field.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/snack_bar.dart';
import 'package:inturn/features/auth/presentation/controller/add_info_bloc/add_info_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/add_info_bloc/add_info_events.dart';
import 'package:inturn/features/auth/presentation/controller/add_info_bloc/add_info_states.dart';
import 'package:inturn/features/auth/presentation/widgets/upload_photo.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  late TextEditingController firstNameController;
  late TextEditingController secondNameController;

  @override
  void initState() {
    firstNameController = TextEditingController();
    secondNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    secondNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, text: StringManager.personalInformation.tr(),actions: true,leading: false),
      body: Padding(
        padding: EdgeInsets.all(AppSize.defaultSize! * 1.5),
        child: BlocListener<AddPersonalInfoBloc, AddPersonalInfoState >(
          listener: (context, state) {
            if (state is AddPersonalInfoSuccessState) {
              Navigator.pushNamedAndRemoveUntil(context, Routes.academicInfo, (route) => false);
            }
            else if (state is AddPersonalInfoErrorState) {
              EasyLoading.showError(state.errorMessage);
            }
          },
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const UploadProfileImagePage(),
                SizedBox(
                  height: AppSize.defaultSize! * 2,
                ),
                CustomText(
                  text: StringManager.uploadProfileImage.tr(),
                  fontSize: AppSize.defaultSize! * 1.6,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: AppSize.defaultSize! * 2,
                ),
                CustomTextField(
                  labelText: StringManager.firstName.tr(),
                  controller: firstNameController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: AppSize.defaultSize! * 2,
                ),
                CustomTextField(
                  labelText: StringManager.secondName.tr(),
                  controller: secondNameController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: AppSize.defaultSize! * 2,
                ),
                // CustomTextField(
                //   labelText: StringManager.email.tr(),
                //   keyboardType: TextInputType.emailAddress,
                // ),
                SizedBox(
                  height: AppSize.defaultSize! * 2,
                ),
                MainButton(
                  text: StringManager.next.tr(),
                  onTap: () {
                    if (UploadProfileImagePage.imageFile != null &&
                        firstNameController.text.isNotEmpty &&
                        secondNameController.text.isNotEmpty) {
                      BlocProvider.of<AddPersonalInfoBloc>(context).add(
                          AddPersonalInfoButtonPressedEvent(
                            image: UploadProfileImagePage.imageFile!,
                            firstName: firstNameController.text,
                            lastName: secondNameController.text,
                          ));
                    } else {
                      errorSnackBar(
                          context, StringManager.pleaseCompleteYourData.tr());
                    }
                  },
                ),
              ]),
        ),
      ),
    );
  }
}
