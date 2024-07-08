import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inturn/core/models/profile_data_model.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/utils/enums.dart';
import 'package:inturn/core/utils/methods.dart';
import 'package:inturn/core/widgets/academic_year_drop_down.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/column_with_text_field.dart';
import 'package:inturn/core/widgets/custom_text_field.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/graduation_years_drop_down.dart';
import 'package:inturn/core/widgets/loading_widget.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/major_drop_down.dart';
import 'package:inturn/core/widgets/show_dialog.dart';
import 'package:inturn/core/widgets/snack_bar.dart';
import 'package:inturn/core/widgets/university.dart';
import 'package:inturn/features/auth/presentation/add_info_flow/fields_of_work.dart';
import 'package:inturn/features/auth/presentation/widgets/segment_button.dart';
import 'package:inturn/features/auth/presentation/widgets/upload_photo.dart';
import 'package:inturn/features/home/data/model/skill_model.dart';
import 'package:inturn/features/profile/domain/use_case/edit_profile_uc.dart';
import 'package:inturn/features/profile/presentation/component/change_password/change_password_screen.dart';
import 'package:inturn/features/profile/presentation/controller/edit_profile/edit_profile_bloc.dart';
import 'package:inturn/features/profile/presentation/controller/edit_profile/edit_profile_event.dart';
import 'package:inturn/features/profile/presentation/controller/edit_profile/edit_profile_state.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_profile_data/get_my_profile_data_bloc.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_profile_data/get_my_profile_data_event.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_profile_data/get_my_profile_data_state.dart';
import 'package:inturn/features/profile/presentation/widgets/pick_pdf.dart';
import 'package:inturn/features/profile/presentation/widgets/profile-major.dart';
import 'package:inturn/features/profile/presentation/widgets/profile_skills.dart';
import 'package:inturn/main.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.userId});

  static bool isUploaded = false;
  final String userId;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  SingingCharacter language = SingingCharacter.no;

  late TextEditingController addressController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController descriptionController;

  ProfileDataModel? profileDataModel;
   int education=0;


  int jop = 0;



  int location = 0;


  @override
  void initState() {
    BlocProvider.of<GetMyProfileDataBloc>(context)
        .add(GetMyProfileDataEvent(widget.userId));

    intilanguage();
    addressController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    addressController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  List<SkillModel> skillIds = [];
  List<int> _skillSegment = [];

  void _onValueChangedSkill(List<int> newValue) {
    setState(() {
      _skillSegment = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileSuccessMessageState) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess('Success');
          BlocProvider.of<GetMyProfileDataBloc>(context)
              .add(GetMyProfileDataEvent(MyApp.userId.toString()));
        } else if (state is EditProfileErrorMessageState) {
          EasyLoading.dismiss();
          EasyLoading.showError(state.errorMessage);
        } else if (state is EditProfileLoadingState) {
          EasyLoading.show();
        }
      },
      child: BlocBuilder<GetMyProfileDataBloc, GetMyProfileDataState>(
        builder: (context, state) {
          if (state is GetMyProfileDataSuccessMessageState) {
            log('${education}education1111111111111111111111111');
            education = state.profileDataModel.graduationStatusId!;
            log('${education}educationssssssssssssssssssssssss');

            profileDataModel = state.profileDataModel;
            UniversityDropDown.selectedValue = profileDataModel?.university;
            FacultyDropDown.selectedValue = profileDataModel?.faculty;
            addressController.text = state.profileDataModel.address ?? "";
            firstNameController.text = state.profileDataModel.firstName ?? "";
            lastNameController.text = state.profileDataModel.lastName ?? "";
            descriptionController.text =
                state.profileDataModel.description ?? "";
            return Scaffold(
              appBar: appBar(
                context,
                text: StringManager.profile.tr(),
                leading: false,
                actions: true,

              ),
              body: Padding(
                padding: EdgeInsets.all(AppSize.defaultSize! * 1.5),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MainButton(
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: const ChangePasswordScreen(),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.fade,
                          );
                        },
                        text: StringManager.changePassword.tr(),
                        textColor: Colors.black,
                        color: AppColors.lightGreyColor,
                        child2: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AssetPath.changePassword,
                              width: AppSize.defaultSize! * 2.5,
                              height: AppSize.defaultSize! * 2.5,
                            ),
                            SizedBox(
                              width: AppSize.defaultSize! * .5,
                            ),
                            CustomText(
                              text: StringManager.changePassword.tr(),
                              color: AppColors.primaryColor,
                              fontSize: AppSize.defaultSize! * 1.4,
                              fontWeight: FontWeight.bold,
                            )
                          ],
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppSize.defaultSize! * 2),
                        child: MainButton(
                          onTap: () {
                            showCV(context, state.profileDataModel);
                          },
                          text: StringManager.downloadCV.tr(),
                          textColor: AppColors.primaryColor,
                          color: AppColors.lightGreyColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const PdfUploadForm(),
                      SizedBox(
                        height: AppSize.defaultSize! * 2,
                      ),
                      Material(
                        borderRadius:
                            BorderRadius.circular(AppSize.defaultSize! * 1.5),
                        elevation: 1,
                        child: Container(
                          width: AppSize.screenWidth!,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                AppSize.defaultSize! * 1.5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(AppSize.defaultSize! * 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: StringManager.personalInformation.tr(),
                                  fontSize: AppSize.defaultSize! * 1.6,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w700,
                                ),
                                SizedBox(
                                  height: AppSize.defaultSize! * 1,
                                ),
                                Center(
                                    child: UploadProfileImagePage(
                                  imagePath:
                                      state.profileDataModel.profileImage,
                                )),
                                SizedBox(
                                  height: AppSize.defaultSize! * 1,
                                ),
                                Center(
                                  child: CustomText(
                                    text: StringManager.changeProfileImage.tr(),
                                    fontSize: AppSize.defaultSize! * 1.6,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: AppSize.defaultSize! * 2.5,
                                ),
                                ColumnWithTextField(
                                  text: StringManager.firstName.tr(),
                                  controller: firstNameController,
                                ),
                                ColumnWithTextField(
                                  text: StringManager.secondName.tr(),
                                  controller: lastNameController,
                                ),
                                ColumnWithTextField(
                                  text: StringManager.address.tr(),
                                  controller: addressController,
                                ),
                                SizedBox(
                                  height: AppSize.defaultSize! * 2,
                                ),
                                CustomTextField(
                                  controller: descriptionController,
                                  hintText: StringManager.description.tr(),
                                  hintStyle: TextStyle(
                                    fontSize: AppSize.defaultSize! * 1.2,
                                  ),
                                  maxLines: 10,
                                  height: AppSize.defaultSize! * 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppSize.defaultSize! * 2),
                        child: Material(
                          borderRadius:
                              BorderRadius.circular(AppSize.defaultSize! * 1.5),
                          elevation: 1,
                          child: Container(
                            width: AppSize.screenWidth!,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  AppSize.defaultSize! * 1.5),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(AppSize.defaultSize! * 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text:
                                        StringManager.academicInformation.tr(),
                                    fontSize: AppSize.defaultSize! * 1.6,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  SizedBox(
                                    height: AppSize.defaultSize! * 1,
                                  ),
                                  UniversityDropDown(
                                    universityId:
                                        state.profileDataModel.university,
                                  ),
                                  SizedBox(
                                    height: AppSize.defaultSize! * 2,
                                  ),
                                  FacultyDropDown(
                                    facultyId: state.profileDataModel.faculty,
                                  ),
                                  SizedBox(
                                    height: AppSize.defaultSize! * 2,
                                  ),
                                  GraduationYearsDropDown(
                                    initValue:
                                        state.profileDataModel.graduationDate,
                                  ),
                                  SizedBox(
                                    height: AppSize.defaultSize! * 2,
                                  ),
                                  if (state.profileDataModel.graduationStatusId==1)
                                    AcademicYearsDropDown(
                                      initValue:
                                          state.profileDataModel.academicYear!.isEmpty?"1st Year":state.profileDataModel.academicYear,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Material(
                        borderRadius:
                            BorderRadius.circular(AppSize.defaultSize! * 1.5),
                        elevation: 1,
                        child: Container(
                          width: AppSize.screenWidth!,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                AppSize.defaultSize! * 1.5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(AppSize.defaultSize! * 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: StringManager.experiences.tr(),
                                  fontSize: AppSize.defaultSize! * 1.6,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w700,
                                ),
                                if(state.profileDataModel.graduationStatusId==1)
                                SizedBox(
                                  height: AppSize.defaultSize! * 1.6,
                                ),
                                if(state.profileDataModel.graduationStatusId==1)
                                CustomText(
                                  text: StringManager.studentOrGraduated.tr(),
                                  color: AppColors.thirdColor,
                                ),
                                if(state.profileDataModel.graduationStatusId==1)
                                SizedBox(
                                  height: AppSize.defaultSize! * 1.6,
                                ),
                                if(state.profileDataModel.graduationStatusId==1)
                                StatefulBuilder(
                                  builder: (context, setState) {
                                    return CustomSegmentedButton(
                                      width: AppSize.defaultSize! * 15,
                                      initialSelectedIndex: (profileDataModel
                                                      ?.graduationStatusId ??
                                                  1) >
                                              0
                                          ? (profileDataModel?.graduationStatusId ??
                                                  1) -
                                              1
                                          : 0,
                                      segments: [
                                        StringManager.student.tr(),
                                        StringManager.graduated.tr()
                                      ],
                                      onValueChanged: (index) =>
                                          (int newValue) {
                                        setState(() {
                                          education = newValue;
                                        });
                                      },
                                    );
                                  }
                                ),
                                SizedBox(
                                  height: AppSize.defaultSize! * 2.4,
                                ),
                                CustomText(
                                  text: StringManager.jobLevel.tr(),
                                  color: AppColors.thirdColor,
                                ),
                                SizedBox(
                                  height: AppSize.defaultSize! * 1.6,
                                ),
                                StatefulBuilder(
                                  builder: (context, setState) {
                                    return CustomSegmentedButton(
                                      width: AppSize.defaultSize! * 15,
                                      initialSelectedIndex:
                                          (profileDataModel?.jobLevelId ?? 1) > 0
                                              ? (profileDataModel?.jobLevelId ??
                                                      1) -
                                                  1
                                              : 0,
                                      segments: [
                                        StringManager.internship.tr(),
                                        StringManager.entryLevel.tr()
                                      ],
                                      onValueChanged: (index) =>
                                          (int newValue) {
                                        setState(() {
                                          jop = newValue;
                                        });
                                      },
                                    );
                                  }
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppSize.defaultSize! * 2),
                        child: Material(
                          borderRadius:
                              BorderRadius.circular(AppSize.defaultSize! * 1.5),
                          elevation: 1,
                          child: Container(
                            width: AppSize.screenWidth!,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  AppSize.defaultSize! * 1.5),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(AppSize.defaultSize! * 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: StringManager.locationType.tr(),
                                    fontSize: AppSize.defaultSize! * 1.6,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  SizedBox(
                                    height: AppSize.defaultSize! * 1.6,
                                  ),
                                  StatefulBuilder(
                                    builder: (context, setState) {
                                      return CustomSegmentedButton(
                                        initialSelectedIndex:
                                            (profileDataModel?.jobLocationTypeId ??
                                                        0) >
                                                    0
                                                ? (profileDataModel
                                                            ?.jobLocationTypeId ??
                                                        0) -
                                                    1
                                                : 0,
                                        segments: [
                                          StringManager.onSite.tr(),
                                          StringManager.remotely.tr(),
                                          StringManager.hybrid.tr()
                                        ],
                                        onValueChanged: (index) =>
                                            (int newValue) {
                                          setState(() {
                                            location = newValue;
                                          });
                                        },
                                        width: AppSize.defaultSize! * 9,
                                      );
                                    }
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      ProfileMajor(
                        profileDataModel: profileDataModel,
                      ),
                      ProfileSkills(
                        profileDataModel: profileDataModel,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppSize.defaultSize! * 2),
                        child: MainButton(
                          onTap: () {
                            log('${   (education)}   (education +1)');
                            List<int>? mergeSkill = ProfileSkills.newSkills
                                .map((e) => e.id)
                                .toSet()
                                .toList();
                            FieldsInfo.majorsId = ProfileMajor.newMajors
                                .map((e) => e.id).toSet()
                                .toList();
                            if (ProfileMajor.newMajors.isNotEmpty &&
                                mergeSkill.isNotEmpty) {
                              BlocProvider.of<EditProfileBloc>(context)
                                  .add(EditProfileEvent(
                                EditPersonalInfoParams(
                                  id: MyApp.userProfileId.toString(),
                                  address: addressController.text.isEmpty
                                      ? state.profileDataModel.address
                                      : addressController.text,
                                  graduationDate:  GraduationYearsDropDown.selectedValue ,
                                  academicYear:   AcademicYearsDropDown.selectedValue ,
                                  firstName: firstNameController.text.isEmpty
                                      ? state.profileDataModel.firstName
                                      : firstNameController.text,
                                  lastName: lastNameController.text.isEmpty
                                      ? state.profileDataModel.lastName
                                      : lastNameController.text,
                                  universityId: (UniversityDropDown
                                              .selectedValue?.universityId ??
                                          state.profileDataModel.university
                                              ?.universityId)
                                      .toString(),
                                  facultyId: (FacultyDropDown
                                              .selectedValue?.id ??
                                          state.profileDataModel.faculty?.id)
                                      .toString(),
                                  description:
                                      descriptionController.text.isEmpty
                                          ? state.profileDataModel.description
                                          : descriptionController.text,
                                  jobLevelId: (jop + 1).toString(),
                                  graduationStatusId:
                                      (education+1).toString(),
                                  jobLocationTypeId: (location + 1).toString(),
                                  majorIds: FieldsInfo.majorsId,
                                  skillIds: mergeSkill,
                                  image: ProfileScreen.isUploaded
                                      ? UploadProfileImagePage.imageFile!
                                      : null,
                                  // CountryId: '',
                                  // CityId: '',
                                ),
                              ));
                            } else if (ProfileMajor.newMajors.isEmpty) {
                              errorSnackBar(
                                  context, StringManager.majorError.tr());
                            } else if (mergeSkill.isEmpty) {
                              errorSnackBar(
                                  context, StringManager.pleaseAddSkill.tr());
                            }
                          },
                          text: StringManager.confirm.tr(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const LoadingWidget();
          }
        },
      ),
    );
  }

  fieldsRow({required String text}) {
    return Padding(
      padding: EdgeInsets.all(AppSize.defaultSize!),
      child: Row(children: [
        CustomText(text: text, color: AppColors.thirdColor),
        const Spacer(),
        SvgPicture.asset(
          AssetPath.collapsed,
        )
      ]),
    );
  }

  Future<void> intilanguage() async {
    String key = await Methods().getlocalization();
    if (key == "en") {
      language = SingingCharacter.English;
    } else if (key == "ar") {
      language = SingingCharacter.Arabic;
    } else {
      language = SingingCharacter.English;
    }
  }
}
