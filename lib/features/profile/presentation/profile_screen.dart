
import 'package:custom_accordion/custom_accordion.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inturn/core/models/profile_data_model.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/utils/methods.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/custom_text_field.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/loading_widget.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/major_drop_down.dart';
import 'package:inturn/core/widgets/show_dialog.dart';
import 'package:inturn/core/widgets/university.dart';
import 'package:inturn/features/auth/presentation/login_screen.dart';
import 'package:inturn/features/auth/presentation/widgets/multi_segment.dart';
import 'package:inturn/features/auth/presentation/widgets/segment_button.dart';
import 'package:inturn/features/auth/presentation/widgets/upload_photo.dart';
import 'package:inturn/features/home/presentation/controller/top_five_and_blogs/get_top_five_bloc.dart';
import 'package:inturn/features/home/presentation/controller/top_five_and_blogs/get_top_five_state.dart';
import 'package:inturn/features/profile/domain/use_case/edit_profile_uc.dart';
import 'package:inturn/features/profile/presentation/controller/edit_profile/edit_profile_bloc.dart';
import 'package:inturn/features/profile/presentation/controller/edit_profile/edit_profile_event.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_profile_data/get_my_profile_data_bloc.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_profile_data/get_my_profile_data_event.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_profile_data/get_my_profile_data_state.dart';
import 'package:inturn/main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController emailController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;

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
      jop = newValue;
    });
  }

  List <int>  _currentSegment = [-1];

  void _onValueChanged( List <int> newValue) {
    setState(() {
      _currentSegment = newValue;
    });
  }

  Widget closeIcon = Transform.rotate(
    angle: 180 * 3.14 / 180,
    child: SvgPicture.asset(
      AssetPath.collapsed,
    ),
  );

  Widget openIcon = SvgPicture.asset(
    AssetPath.collapsed,
  );

  @override
  void initState() {
    BlocProvider.of<GetMyProfileDataBloc>(context).add(GetMyProfileDataEvent(MyApp.userProfileId.toString()));

    emailController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetMyProfileDataBloc, GetMyProfileDataState>(
      listener: (context, state) {
        if(state is GetMyProfileDataSuccessMessageState){
          profileDataModel = state.profileDataModel;
          //UniversityDropDown.selectedValue = state.profileDataModel.university;
          emailController.text = state.profileDataModel.user?.email??"";
          firstNameController.text = state.profileDataModel.firstName??"";
          lastNameController.text = state.profileDataModel.lastName??"";
        }
      },
      child: Scaffold(
        appBar: appBar(context,
            text: StringManager.profile.tr(),
            leading: false,
            actions: [
              IconButton(
                  onPressed: () {
                    Methods.instance.saveUserToken(authToken: null);
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const LoginScreen();
                        },
                      ),
                      (_) => false,
                    );
                  },
                  icon: const Icon(Icons.logout))
            ]),
        body: Padding(
          padding: EdgeInsets.all(AppSize.defaultSize! * 1.5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MainButton(
                  onTap: () {},
                  text: StringManager.changePassword.tr(),
                  textColor: Colors.black,
                  color: AppColors.lightGreyColor,
                  fontWeight: FontWeight.bold,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: AppSize.defaultSize! * 2),
                  child: MainButton(
                    onTap: () {
                      showCV(context);
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
                      borderRadius:
                          BorderRadius.circular(AppSize.defaultSize! * 1.5),
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
                          const Center(child: UploadProfileImagePage()),
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
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: AppSize.defaultSize! * 2),
                  child: Material(
                    borderRadius:
                        BorderRadius.circular(AppSize.defaultSize! * 1.5),
                    elevation: 1,
                    child: Container(
                      width: AppSize.screenWidth!,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(AppSize.defaultSize! * 1.5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(AppSize.defaultSize! * 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: StringManager.academicInformation.tr(),
                              fontSize: AppSize.defaultSize! * 1.6,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(
                              height: AppSize.defaultSize! * 1,
                            ),
                            const UniversityDropDown(),
                            SizedBox(
                              height: AppSize.defaultSize! * 2,
                            ),
                            const FacultyDropDown(),
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
                      borderRadius:
                          BorderRadius.circular(AppSize.defaultSize! * 1.5),
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
                            initialSelectedIndex: (profileDataModel?.graduationStatusId??0) > 0 ? profileDataModel?.graduationStatusId??0 - 1 : 0,
                            segments: [StringManager.student.tr(), StringManager.graduated.tr()],
                            onValueChanged: (index) => _onValueChangededucation(index),
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
                            initialSelectedIndex: (profileDataModel?.jobLevelId??0) > 0 ? profileDataModel?.jobLevelId??0 - 1 : 0,
                            segments: [StringManager.internship.tr(), StringManager.entryLevel.tr()],
                            onValueChanged: (index) => _onValueChangedJop(index),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: AppSize.defaultSize! * 2),
                  child: Material(
                    borderRadius:
                        BorderRadius.circular(AppSize.defaultSize! * 1.5),
                    elevation: 1,
                    child: Container(
                      width: AppSize.screenWidth!,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(AppSize.defaultSize! * 1.5),
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
                              initialSelectedIndex: (profileDataModel?.jobLocationTypeId??0) > 0 ? profileDataModel?.jobLocationTypeId??0 - 1 : 0,
                              segments: [StringManager.onSite.tr(), StringManager.remotely.tr(), StringManager.hybrid.tr()],
                              onValueChanged: (index) => _onValueChangedLocation(index),
                              width: AppSize.defaultSize! * 9,
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
                      borderRadius:
                          BorderRadius.circular(AppSize.defaultSize! * 1.5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(AppSize.defaultSize! * 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: StringManager.fieldsOfWork.tr(),
                            fontSize: AppSize.defaultSize! * 1.6,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(
                            height: AppSize.defaultSize! * 1.6,
                          ),
                          BlocBuilder<HomeBloc, HomeState >(
                            builder: (context, state) {
                              if (state is GetMajorLoadingState) {
                                return const Center(child: LoadingWidget());
                              } else if (state is GetMajorSuccessMessageState) {
                                return ListView.builder(
                                    itemCount: state.topFiveModel.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      List<int> selected = [];
                                      for(int i = 0; i < state.topFiveModel.length; i++){
                                        selected = Methods.instance.findCommonItems(state.topFiveModel[i].positions, profileDataModel!.user!.majors!);
                                      }
                                      return CustomAccordion(
                                        title: state.topFiveModel[index].field,
                                        showContent: true,
                                        headerBackgroundColor: Colors.transparent,
                                        titleStyle: TextStyle(
                                          color: AppColors.thirdColor,
                                          fontSize: AppSize.defaultSize! * 1.4,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        toggleIconOpen: openIcon,
                                        toggleIconClose: closeIcon,
                                        headerIconColor: AppColors.primaryColor,
                                        accordionElevation: 0,
                                        widgetItems: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            MultiSegmentedButton(
                                              initialSelectedIndices: selected,
                                              segments: state.topFiveModel[index].positions.map((position) => position.majorNameEn).toList(),
                                              onValueChanged: (index) => _onValueChanged(index),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              }
                              return Container();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: AppSize.defaultSize! * 2),
                  child: Material(
                    borderRadius:
                        BorderRadius.circular(AppSize.defaultSize! * 1.5),
                    elevation: 1,
                    child: Container(
                      width: AppSize.screenWidth!,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(AppSize.defaultSize! * 1.5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(AppSize.defaultSize! * 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: StringManager.skills.tr(),
                              fontSize: AppSize.defaultSize! * 1.6,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(
                              height: AppSize.defaultSize! * 1.6,
                            ),
                            CustomTextField(
                              hintText: StringManager.searchForSkills.tr(),
                              hintStyle: TextStyle(
                                  fontSize: AppSize.defaultSize! * 1.4),
                            ),
                            SizedBox(
                              height: AppSize.defaultSize! * 1.6,
                            ),
                            CustomText(
                              text: StringManager.selectSkills.tr(),
                              color: AppColors.thirdColor,
                            ),
                            SizedBox(
                              height: AppSize.defaultSize! * 1.6,
                            ),
                            // CustomSegmentedButton(
                            //   segments: const [
                            //     'Java',
                            //     'python',
                            //     '.net',
                            //     'react'
                            //   ],
                            //   width: AppSize.defaultSize! * 6,
                            //   onValueChanged: (index) => _onValueChanged(index),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: AppSize.defaultSize! * 2),
                  child: MainButton(
                    onTap: () {
                      BlocProvider.of<EditProfileBloc>(context).add(EditProfileEvent(
                        EditPersonalInfoParams(
                          id: '',
                          firstName: '',
                          lastName: '',
                          UniversityId: '',
                          FacultyId: '',
                          Description: '',
                          JobLevelId: '',
                          GraduationStatusId: '',
                          JobLocationTypeId: '',
                          MajorIds: [],
                          SkillIds: [],
                          CountryId: '',
                          CityId: '',
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
