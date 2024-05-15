import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inturn/core/models/profile_data_model.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/utils/enums.dart';
import 'package:inturn/core/utils/methods.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/custom_text_field.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/loading_widget.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/major_drop_down.dart';
import 'package:inturn/core/widgets/show_dialog.dart';
import 'package:inturn/core/widgets/university.dart';
import 'package:inturn/features/auth/presentation/add_info_flow/fields_of_work.dart';
import 'package:inturn/features/auth/presentation/add_info_flow/skills.dart';
import 'package:inturn/features/auth/presentation/widgets/multi_select2.dart';
import 'package:inturn/features/auth/presentation/widgets/segment_button.dart';
import 'package:inturn/features/auth/presentation/widgets/upload_photo.dart';
import 'package:inturn/features/home/data/model/skill_model.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_bloc.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_states.dart';
import 'package:inturn/features/profile/domain/use_case/edit_profile_uc.dart';
import 'package:inturn/features/profile/presentation/controller/edit_profile/edit_profile_bloc.dart';
import 'package:inturn/features/profile/presentation/controller/edit_profile/edit_profile_event.dart';
import 'package:inturn/features/profile/presentation/controller/edit_profile/edit_profile_state.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_profile_data/get_my_profile_data_bloc.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_profile_data/get_my_profile_data_event.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_profile_data/get_my_profile_data_state.dart';
import 'package:inturn/features/profile/presentation/widgets/profile-major.dart';
import 'package:inturn/features/profile/presentation/widgets/profile_skills.dart';
import 'package:inturn/main.dart';
import 'package:searchfield/searchfield.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.userId});
final String userId;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController emailController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController descriptionController;

  ProfileDataModel? profileDataModel;

  int education = 0;

  void _onValueChangededucation(int newValue) {
    setState(() {
      education = newValue;

    });
  }

  int jop = 0;

  void _onValueChangedJop(int newValue) {
    setState(() {
      jop = newValue;
    });
  }

  int location = 0;

  void _onValueChangedLocation(int newValue) {
    setState(() {
      location = newValue;
    });
  }

  @override
  void initState() {
    log(widget.userId+'skjdvbwjobwo');
    BlocProvider.of<GetMyProfileDataBloc>(context)
        .add(GetMyProfileDataEvent(widget.userId));
    emailController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
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
          BlocProvider.of<GetMyProfileDataBloc>(context)
              .add(GetMyProfileDataEvent(MyApp.userProfileId.toString()));
        }
      },
      child: BlocBuilder<GetMyProfileDataBloc, GetMyProfileDataState>(
        builder: (context, state) {
          if (state is GetMyProfileDataSuccessMessageState) {
            log('${profileDataModel?.graduationStatusId}profileDataModel?.graduationStatusId');
            profileDataModel = state.profileDataModel;
            UniversityDropDown.selectedValue = profileDataModel?.university;
            FacultyDropDown.selectedValue = profileDataModel?.faculty;
            emailController.text = state.profileDataModel.user?.email ?? "";
            firstNameController.text = state.profileDataModel.firstName ?? "";
            lastNameController.text = state.profileDataModel.lastName ?? "";

            return Scaffold(
              appBar: appBar(context,
                  text: StringManager.profile.tr(),
                  leading: false,
                  actions: true),
              body: Padding(
                padding: EdgeInsets.all(AppSize.defaultSize! * 1.5),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MainButton(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.changePassword);
                        },
                        text: StringManager.changePassword.tr(),
                        textColor: Colors.black,
                        color: AppColors.lightGreyColor,
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
                          textColor: Colors.black,
                          color: AppColors.lightGreyColor,
                          fontWeight: FontWeight.bold,
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
                                CustomTextField(
                                  controller: firstNameController,
                                ),
                                SizedBox(
                                  height: AppSize.defaultSize! * 2,
                                ),
                                CustomTextField(
                                  controller: lastNameController,
                                ),
                                SizedBox(
                                  height: AppSize.defaultSize! * 2,
                                ),
                                CustomTextField(
                                  controller: emailController,
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
                                SizedBox(
                                  height: AppSize.defaultSize! * 1.6,
                                ),
                                CustomText(
                                  text: StringManager.studentOrGraduated.tr(),
                                  color: AppColors.thirdColor,
                                ),
                                SizedBox(
                                  height: AppSize.defaultSize! * 1.6,
                                ),
                                CustomSegmentedButton(
                                  width: AppSize.defaultSize! * 15,
                                  initialSelectedIndex: (profileDataModel
                                                  ?.graduationStatusId ??
                                              1) >
                                          0
                                      ? (profileDataModel?.graduationStatusId ??
                                          1) - 1
                                      : 0,
                                  segments: [
                                    StringManager.student.tr(),
                                    StringManager.graduated.tr()
                                  ],
                                  onValueChanged: (index) =>
                                      _onValueChangededucation(index),
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
                                CustomSegmentedButton(
                                  width: AppSize.defaultSize! * 15,
                                  initialSelectedIndex:
                                      (profileDataModel?.jobLevelId ?? 1) > 0
                                          ? (profileDataModel?.jobLevelId ??
                                              1 )- 1
                                          : 0,
                                  segments: [
                                    StringManager.internship.tr(),
                                    StringManager.entryLevel.tr()
                                  ],
                                  onValueChanged: (index) =>
                                      _onValueChangedJop(index),
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
                                  CustomSegmentedButton(
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
                                        _onValueChangedLocation(index),
                                    width: AppSize.defaultSize! * 9,
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
                            List<int>? mergeSkill = ProfileSkills.newSkills
                                    .map((e) => e.skillId)
                                    .toList()
                                    .isEmpty
                                ? profileDataModel?.user?.userSkills
                                    ?.map((e) => (e.skillId!))
                                    .toList()
                                : ProfileSkills.newSkills
                                    .map((e) => e.skillId)
                                    .toList();
                            log('${state.profileDataModel.university
                                ?.universityId}wnwnrknpwn');
                            FieldsInfo.id = Methods.instance.combineLists(
                                FieldsInfo.id,
                                profileDataModel?.user?.userMajors
                                        ?.map((e) => e.major?.majorId ?? 0)
                                        .toList() ??
                                    []);
                            BlocProvider.of<EditProfileBloc>(context)
                                .add(EditProfileEvent(
                              EditPersonalInfoParams(
                                id: MyApp.userProfileId.toString(),
                                firstName: firstNameController.text.isEmpty?  state.profileDataModel.firstName:firstNameController.text,
                                lastName: lastNameController.text.isEmpty?  state.profileDataModel.lastName:lastNameController.text,
                                UniversityId: (UniversityDropDown
                                            .selectedValue?.universityId ??
                                        state.profileDataModel.university
                                            ?.universityId)
                                    .toString(),
                                FacultyId: (FacultyDropDown.selectedValue?.id ??
                                        state.profileDataModel.faculty?.id)
                                    .toString(),
                                Description: descriptionController.text.isEmpty?  state.profileDataModel.description:descriptionController.text,
                                JobLevelId: (jop+1).toString() ,
                                GraduationStatusId: (education+1).toString(),
                                JobLocationTypeId: (location+1).toString(),
                                MajorIds: FieldsInfo.id,
                                SkillIds: mergeSkill,
                                // CountryId: '',
                                // CityId: '',
                              ),
                            ));
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
}
