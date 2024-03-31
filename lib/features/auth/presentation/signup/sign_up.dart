import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/column_with_text_field.dart';
import 'package:inturn/core/widgets/major_drop_down.dart';
import 'package:inturn/core/widgets/snack_bar.dart';
import 'package:inturn/core/widgets/university.dart';
import 'package:inturn/features/auth/presentation/controller/sign_up_bloc/sign_up_with_email_and_password_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/sign_up_bloc/sign_up_with_email_and_password_events.dart';
import 'package:inturn/features/auth/presentation/controller/sign_up_bloc/sign_up_with_email_and_password_states.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  String eduLevel = 'hhhh';
  String graduationYear = '2023';
  bool isVisible = false;

  @override
  void initState() {
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpWithEmailAndPasswordBloc,
        SignUpWithEmailAndPasswordState>(
      listener: (context, state) {
        if (state is SignUpWithEmailAndPasswordSuccessMessageState) {
          EasyLoading.dismiss();

          Navigator.pushNamedAndRemoveUntil(
              context, Routes.main, (route) => false);
        } else if (state is SignUpWithEmailAndPasswordErrorMessageState) {
          EasyLoading.dismiss();
          errorSnackBar(context, StringManager.unexpectedError.tr());
        } else if (state is SignUpWithEmailAndPasswordLoadingState) {
          EasyLoading.show(status: 'loading...');
        }
      },
      child: Scaffold(
        appBar: appBar(context, text: StringManager.signUp.tr()),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSize.defaultSize! * 2),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: AppSize.defaultSize! * 4.8,
                  decoration: const BoxDecoration(
                    color: AppColors.containerColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        StringManager.youAlready.tr(),
                        style: TextStyle(
                            color: AppColors.greyColor,
                            fontSize: AppSize.defaultSize! * 1.4,
                            fontWeight: FontWeight.w700),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.login);
                        },
                        child: Text(
                          StringManager.signIn.tr(),
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: AppSize.defaultSize! * 1.5,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    ColumnWithTextField(
                      text: StringManager.firstName.tr(),
                      controller: firstNameController,
                      width: AppSize.screenWidth! * .4,
                    ),
                    const Spacer(),
                    ColumnWithTextField(
                      text: StringManager.secondName.tr(),
                      controller: lastNameController,
                      width: AppSize.screenWidth! * .4,
                    ),
                  ],
                ),
                ColumnWithTextField(
                  text: StringManager.phoneNum.tr(),
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                ),
                ColumnWithTextField(
                  text: StringManager.email.tr(),
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: AppSize.defaultSize! * 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StatefulBuilder(builder: (context, setState) {
                      return dropDownSignUp(
                          text: StringManager.educationLevel.tr(),
                          hintText: StringManager.selectEdu.tr(),
                          onChanged: (String? newValue) {
                            setState(() {
                              eduLevel = newValue!;
                            });
                          },
                          selectedValue: eduLevel,
                          data: ['hhhh', 'hhhhhh']);
                    }),
                    StatefulBuilder(builder: (context, setState) {
                      return dropDownSignUp(
                          text: StringManager.graduationYear.tr(),
                          hintText: StringManager.selectGrad.tr(),
                          onChanged: (String? newValue) {
                            setState(() {
                              graduationYear = newValue!;
                            });
                          },
                          selectedValue: graduationYear,
                          data: ['2023', '2022']);
                    }),
                  ],
                ),
                SizedBox(
                  height: AppSize.defaultSize! * 3,
                ),
                const UniversityDropDown(),
                SizedBox(
                  height: AppSize.defaultSize! * 3,
                ),
                const MajorDropDown(),
                ColumnWithTextField(
                  text: StringManager.password.tr(),
                  controller: passwordController,
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    child: Icon(
                      isVisible ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                  ),
                ),
                ColumnWithTextField(
                  text: StringManager.confirmPassword.tr(),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    child: Icon(
                      isVisible ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                  ),
                  controller: passwordConfirmController,
                ),
                SizedBox(
                  height: AppSize.defaultSize! * 3,
                ),
                MainButton(
                  text: StringManager.signUp.tr(),
                  onTap: () {
                    if (validation()) {
                      BlocProvider.of<SignUpWithEmailAndPasswordBloc>(context)
                          .add(SignUpWithEmailAndPasswordEvent(
                        phone: phoneController.text,
                        password: passwordController.text,
                        major:
                            MajorDropDown.selectedValue?.id.toString() ?? "0",
                        universityID: UniversityDropDown
                                .selectedValue?.universityId
                                .toString() ??
                            "0",
                        name: firstNameController.text,
                        email: emailController.text,
                        lastName: lastNameController.text,
                        eduLevel: eduLevel,
                        graduationYear: graduationYear, confirmPassword: passwordConfirmController.text,
                      ));
                    } else {
                      errorSnackBar(
                          context, StringManager.pleaseCompleteYourData.tr());
                    }
                  },
                ),
                SizedBox(
                  height: AppSize.defaultSize! * 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dropDownSignUp({
    required String text,
    required String hintText,
    required String selectedValue,
    required List<String> data,
    required void Function(String?)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
              fontSize: AppSize.defaultSize! * 1.4,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: AppSize.defaultSize! * .3,
        ),
        Container(
          width: AppSize.screenWidth! * .4,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor),
              borderRadius: BorderRadius.circular(AppSize.defaultSize! * .5)),
          child: Center(
            child: DropdownButton<String>(
              value: selectedValue,
              underline: const SizedBox(),
              onChanged: onChanged,
              hint: Text(
                hintText,
                style: TextStyle(
                  fontSize: AppSize.defaultSize!,
                ),
              ),
              icon: Padding(
                padding: EdgeInsets.only(left: AppSize.defaultSize! * 3),
                child: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  size: AppSize.defaultSize! * 3,
                ),
              ),
              items: data.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: AppSize.defaultSize!,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  bool validation() {
    if (emailController.text == '') {
      return false;
    } else if (firstNameController.text == '') {
      return false;
    } else if (lastNameController.text == '') {
      return false;
    } else if (phoneController.text == '') {
      return false;
    }else if (passwordController.text == '') {
      return false;
    } else if (passwordConfirmController.text == '') {
      return false;
    } else if (eduLevel == '') {
      return false;
    } else if (graduationYear == '') {
      return false;
    } else {
      return true;
    }
  }
}
