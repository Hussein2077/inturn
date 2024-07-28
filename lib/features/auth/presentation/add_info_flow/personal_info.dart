import 'dart:developer';

import 'package:animated_visibility/animated_visibility.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/resource_manager/themes/enums.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/custom_text_field.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/snack_bar.dart';
import 'package:inturn/features/auth/presentation/controller/add_info_bloc/add_info_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/add_info_bloc/add_info_events.dart';
import 'package:inturn/features/auth/presentation/controller/add_info_bloc/add_info_states.dart';
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_events.dart';
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_states.dart';
import 'package:inturn/features/auth/presentation/forget%20password/widgets/pin_text_field.dart';
import 'package:inturn/features/auth/presentation/signup/counter_by_widget.dart';
import 'package:inturn/features/auth/presentation/signup/sign_up.dart';
import 'package:inturn/features/auth/presentation/widgets/upload_photo.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key, required this.userId});

  final String userId;
 static ValueNotifier<int> otpVisibleNotifier = ValueNotifier<int>(0);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  late TextEditingController firstNameController;
  late TextEditingController secondNameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  ValueNotifier<bool> isVerifiedNotifier = ValueNotifier<bool>(false);
  ValueNotifier<bool> emailReadOnly = ValueNotifier<bool>(false);


  @override
  void initState() {
    firstNameController = TextEditingController();
    secondNameController = TextEditingController();
    emailController = TextEditingController();
    addressController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    secondNameController.dispose();
    emailController.dispose();
    addressController.dispose();
    UploadProfileImagePage.imageFile = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context,
          text: StringManager.personalInformation.tr(),
          actions: true,
          leading: false),
      body: Padding(
        padding: EdgeInsets.all(AppSize.defaultSize! * 1.5),
        child: BlocListener<AddPersonalInfoBloc, AddPersonalInfoState>(
          listener: (context, state) {
            if (state is AddPersonalInfoSuccessState) {
              EasyLoading.dismiss();
              Navigator.pushNamed(
                context,
                Routes.experienceInfo,
              );
            } else if (state is AddPersonalInfoErrorState) {
              EasyLoading.dismiss();
              EasyLoading.showError(state.errorMessage);
            } else if (state is AddPersonalInfoLoadingState) {
              EasyLoading.show();
            }
          },
          child: SingleChildScrollView(
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
                  ),
                  SizedBox(
                    height: AppSize.defaultSize! * 2,
                  ),
                  CustomTextField(
                    labelText: StringManager.secondName.tr(),
                    controller: secondNameController,
                  ),
                  SizedBox(
                    height: AppSize.defaultSize! * 2,
                  ),
                  CustomTextField(
                    labelText: StringManager.address.tr(),
                    keyboardType: TextInputType.streetAddress,
                    controller: addressController,
                  ),
                  SizedBox(
                    height: AppSize.defaultSize! * 2,
                  ),
                  BlocListener<ResetPasswordFlowBloc, ResetPasswordState>(
                    listener: (context, state) {
                      if (state is SendCodeSuccessMessageState) {
                        EasyLoading.dismiss();
                        EasyLoading.showSuccess(StringManager.codeSent.tr());

                        if (PersonalInfo.otpVisibleNotifier.value == 0) {
                          PersonalInfo.otpVisibleNotifier.value++;
                        }
                      } else if (state is SendCodeErrorMessageState) {
                        EasyLoading.dismiss();
                        errorSnackBar(context, state.errorMessage);
                      } else if (state is SendCodeLoadingState) {
                        EasyLoading.show(status: 'loading...');
                      }
                      if (state is VerifyCodeLoadingState) {
                        EasyLoading.show(status: 'loading...');
                      }
                      if (state is VerifyCodeSuccessMessageState) {
                        EasyLoading.dismiss();
                        EasyLoading.showSuccess(
                            StringManager.codeVerified.tr());
                        emailReadOnly.value = true;
                        if (PersonalInfo.otpVisibleNotifier.value!=0) {
                          PersonalInfo.otpVisibleNotifier.value = 0;
                        }
                        isVerifiedNotifier.value = true;
                      }
                      if (state is VerifyCodeErrorMessageState) {
                        EasyLoading.dismiss();
                        errorSnackBar(context, state.errorMessage);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ValueListenableBuilder(
                          valueListenable:  emailReadOnly,
                          builder: (context,  value, child) {
                            return CustomTextField(
                              labelText: StringManager.email.tr(),
                            readOnly: emailReadOnly.value,

                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              width: AppSize.screenWidth! * .72,

                              suffixIcon: ValueListenableBuilder(
                                  valueListenable: isVerifiedNotifier,
                                  builder: (context, value, child) {
                                    if (value == false) {
                                      return const Icon(
                                        Icons.verified_outlined,
                                        color: AppColors.greyColor,
                                      );
                                    } else {
                                      return const Icon(
                                        Icons.verified,
                                        color: AppColors.primaryColor,
                                      );
                                    }
                                  }),
                            );
                          }
                        ),
                        MainButton(
                          text: (PersonalInfo.otpVisibleNotifier.value == 0&&emailReadOnly.value==false)
                              ? StringManager.sendCode.tr()
                              : StringManager.sent.tr(),
                          color:(PersonalInfo.otpVisibleNotifier.value == 0&&emailReadOnly.value==false)
                              ? AppColors.primaryColor
                              : AppColors.greyColor,
                          onTap: () {
                            if (PersonalInfo.otpVisibleNotifier.value==0 &&
                                emailController.text.isNotEmpty&&emailReadOnly.value==false) {
                              BlocProvider.of<ResetPasswordFlowBloc>(context)
                                  .add(SendCodeEvent(
                                      phoneOrEmail: emailController.text,
                                      phoneOrEmailType: PhoneOrEmail.email));
                            } else if (emailController.text.isEmpty) {
                              errorSnackBar(
                                  context, StringManager.enterEmail.tr());
                            }
                          },
                          width: AppSize.screenWidth! * .18,
                          fontSize: AppSize.defaultSize! * 1.2,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppSize.defaultSize! * 2,
                  ),
                  ValueListenableBuilder(
                    valueListenable: PersonalInfo.otpVisibleNotifier,
                    builder: (context, value, child) {
                      log('sssssssssccsc${value} ${PersonalInfo.otpVisibleNotifier}');
                      return (value!=0)
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSize.defaultSize! * 4,
                                vertical: AppSize.defaultSize!),
                            child: Column(
                              children: [
                                CustomPinCodeTextField(
                                  onCompleted: (v) {
                                    print("Completedssssss");
                                    CustomPinCodeTextField.otp = v;
                                    BlocProvider.of<ResetPasswordFlowBloc>(
                                            context)
                                        .add(VerifyCodeEvent(
                                            email: emailController.text,
                                            code: v, fromForgot: false));
                                  },
                                ),
                                CounterByMinute(
                                  email: emailController.text,
                                ),
                              ],
                            ),
                          )
                        : const SizedBox();
                    },
                  ),
                  MainButton(
                    text: StringManager.next.tr(),
                    onTap: () {
                      if (UploadProfileImagePage.imageFile != null &&
                          firstNameController.text.isNotEmpty &&
                          secondNameController.text.isNotEmpty &&
                          isVerifiedNotifier.value &&
                          addressController.text.isNotEmpty) {
                        BlocProvider.of<AddPersonalInfoBloc>(context)
                            .add(AddPersonalInfoButtonPressedEvent(
                          image: UploadProfileImagePage.imageFile!,
                          userID: widget.userId,
                          firstName: firstNameController.text,
                          lastName: secondNameController.text,
                          email: emailController.text,
                          address: addressController.text,
                        ));
                      } else if (UploadProfileImagePage.imageFile == null) {
                        errorSnackBar(
                            context, StringManager.pleaseUploadImage.tr());
                      } else if (firstNameController.text.isEmpty ||
                          secondNameController.text.isEmpty) {
                        errorSnackBar(
                            context, StringManager.pleaseUploadName.tr());
                      } else if (addressController.text.isEmpty) {
                        errorSnackBar(
                            context, StringManager.pleaseUploadAddress.tr());
                      } else if (emailController.text.isEmpty) {
                        errorSnackBar(
                            context, StringManager.pleaseUploadEmail.tr());
                      } else if (isVerifiedNotifier.value == false) {
                        errorSnackBar(
                            context, StringManager.pleaseVerifyEmail.tr());
                      }
                    },
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
