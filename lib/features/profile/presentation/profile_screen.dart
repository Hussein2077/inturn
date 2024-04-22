
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/custom_text_field.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/major_drop_down.dart';
import 'package:inturn/core/widgets/show_dialog.dart';
import 'package:inturn/core/widgets/university.dart';
import 'package:inturn/features/auth/presentation/widgets/segment_button.dart';
import 'package:inturn/features/auth/presentation/widgets/upload_photo.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late TextEditingController emailController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController skillsController;

  int _currentSegment = 0;

  void _onValueChanged(int newValue) {
    setState(() {
      _currentSegment = newValue;
    });
  }

  @override
  void initState() {
    emailController = TextEditingController(text: "email@gmail.com");
    firstNameController = TextEditingController(text: "ahmed");
    lastNameController = TextEditingController(text: "sameh");
    skillsController = TextEditingController(text: "Highly skilled software developer with 8 years of experience in designing, developing, and implementing software solutions. Proficient in multiple programming languages and technologies.");
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    skillsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, text: StringManager.profile.tr(), leading: false),
      body: Padding(
        padding: EdgeInsets.all(AppSize.defaultSize! * 1.5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MainButton(
                onTap: (){},
                text: StringManager.changePassword.tr(),
                textColor: Colors.black,
                color: AppColors.lightGreyColor,
                fontWeight: FontWeight.bold,
              ),
          
              Padding(
                padding: EdgeInsets.symmetric(vertical: AppSize.defaultSize! * 2),
                child: MainButton(
                  onTap: (){
                    showCV(context);
                  },
                  text: StringManager.downloadCV.tr(),
                  textColor: Colors.black,
                  color: AppColors.lightGreyColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              Material(
                borderRadius: BorderRadius.circular(AppSize.defaultSize! * 1.5),
                elevation: 1,
                child: Container(
                  width: AppSize.screenWidth!,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSize.defaultSize! * 1.5),
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
          
                        SizedBox(
                          height: AppSize.defaultSize! * 2,
                        ),

                        SizedBox(
                          width: double.maxFinite,
                          child: TextFormField(
                            maxLines: 20,
                            minLines: 1,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(AppSize.defaultSize! * .8),
                              labelStyle: TextStyle(
                                color: AppColors.greyColor,
                                fontSize: AppSize.screenHeight! * .015,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(AppSize.defaultSize! * 1.5)),
                                borderSide:
                                BorderSide(color: AppColors.borderColor.withOpacity(.4)),
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(AppSize.defaultSize! * 1.5)),
                                borderSide:
                                BorderSide(color: AppColors.borderColor.withOpacity(.4)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(AppSize.defaultSize! * 1.5)),
                                  borderSide:
                                  BorderSide(color: AppColors.primaryColor.withOpacity(.4))),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(AppSize.defaultSize! * 1.5)),
                                  borderSide:
                                  BorderSide(color: AppColors.borderColor.withOpacity(.4))),
                            ),
                            controller: skillsController,
                          ),
                        ),
          
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: AppSize.defaultSize! * 2),
                child: Material(
                  borderRadius: BorderRadius.circular(AppSize.defaultSize! * 1.5),
                  elevation: 1,
                  child: Container(
                    width: AppSize.screenWidth!,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppSize.defaultSize! * 1.5),
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
                          const MajorDropDown(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Material(
                borderRadius: BorderRadius.circular(AppSize.defaultSize! * 1.5),
                elevation: 1,
                child: Container(
                  width: AppSize.screenWidth!,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSize.defaultSize! * 1.5),
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
                          segments: const ['Student', 'Graduated'],
                          onValueChanged: (index) => _onValueChanged(index),
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
                          segments: const ['Internship', 'Entry Level'],
                          onValueChanged: (index) => _onValueChanged(index),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: AppSize.defaultSize! * 2),
                child: Material(
                  borderRadius: BorderRadius.circular(AppSize.defaultSize! * 1.5),
                  elevation: 1,
                  child: Container(
                    width: AppSize.screenWidth!,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppSize.defaultSize! * 1.5),
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
                          const UniversityDropDown(),
                          SizedBox(
                            height: AppSize.defaultSize! * 2,
                          ),
                          const MajorDropDown(),
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
                            segments: const ['On Site', 'Remotly','Hybrid'],
                            onValueChanged: (index) => _onValueChanged(index),
                            width:  AppSize.defaultSize! * 9,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Material(
                borderRadius: BorderRadius.circular(AppSize.defaultSize! * 1.5),
                elevation: 1,
                child: Container(
                  width: AppSize.screenWidth!,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSize.defaultSize! * 1.5),
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
                        fieldsRow(text: 'Accounting/Finance Jobs'),
                        SizedBox(
                          height: AppSize.defaultSize! * 1.6,
                        ),
                        CustomSegmentedButton(
                          segments: const [
                            'Internal Audit',
                            'Internal Audit',
                            'Internal Audit'
                          ],
                          onValueChanged: (index) => _onValueChanged(index),
                          width: AppSize.defaultSize! * 15,
                        ),
                        SizedBox(
                          height: AppSize.defaultSize! * 4,
                        ),
                        fieldsRow(text: 'Accounting/Finance Jobs'),
                        SizedBox(
                          height: AppSize.defaultSize! * 1.6,
                        ),
                        CustomSegmentedButton(
                          segments: const [
                            'Internal Audit',
                            'Internal Audit',
                            'Internal Audit'
                          ],
                          onValueChanged: (index) => _onValueChanged(index),
                          width: AppSize.defaultSize! * 15,
                        ),
                        SizedBox(
                          height: AppSize.defaultSize! * 4,
                        ),
                        fieldsRow(text: 'Accounting/Finance Jobs'),
                        SizedBox(
                          height: AppSize.defaultSize! * 1.6,
                        ),
                        CustomSegmentedButton(
                          segments: const [
                            'Internal Audit',
                            'Internal Audit',
                            'Internal Audit'
                          ],
                          onValueChanged: (index) => _onValueChanged(index),
                          width: AppSize.defaultSize! * 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ),



              Padding(
                padding: EdgeInsets.symmetric(vertical: AppSize.defaultSize! * 2),
                child: Material(
                  borderRadius: BorderRadius.circular(AppSize.defaultSize! * 1.5),
                  elevation: 1,
                  child: Container(
                    width: AppSize.screenWidth!,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppSize.defaultSize! * 1.5),
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
                            hintStyle: TextStyle(fontSize: AppSize.defaultSize! * 1.4),
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
                          CustomSegmentedButton(
                            segments: const ['Java', 'python','.net','react'],
                            width:  AppSize.defaultSize! * 6,
                            onValueChanged: (index) => _onValueChanged(index),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: AppSize.defaultSize! * 2),
                child: MainButton(
                    onTap: (){},
                    text: StringManager.confirm.tr(),
                ),
              ),
            ],
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
