import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/service/navigator_services.dart';
import 'package:inturn/core/service/service_locator.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/utils/methods.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/custom_text_field.dart';
import 'package:inturn/core/widgets/snack_bar.dart';
import 'package:inturn/features/auth/presentation/controller/login_bloc/login_with_email_and_password_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/login_bloc/login_with_email_and_password_events.dart';
import 'package:inturn/features/auth/presentation/controller/login_bloc/login_with_email_and_password_states.dart';
import 'package:inturn/features/auth/presentation/controller/sign_in_with_platform_bloc/sign_in_with_platform_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/sign_in_with_platform_bloc/sign_in_with_platform_event.dart';
import 'package:inturn/features/auth/presentation/controller/sign_in_with_platform_bloc/sign_in_with_platform_state.dart';
import 'package:inturn/features/auth/presentation/widgets/sign_in_button.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_data/get_my_data_bloc.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_data/get_my_data_event.dart';
import 'package:inturn/main.dart';
import 'package:linkedin_login/linkedin_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocListener<LoginWithEmailAndPasswordBloc,
            LoginWithEmailAndPasswordState>(
          listener: (context, state) {
            if (state is LoginWithEmailAndPasswordSuccessMessageState) {
              EasyLoading.dismiss();
              MyApp.userId=state.userId;
                            Methods.instance.navigateToAddInfo(
                  isComplete: state.isCompleted,
                  userId: state.userId,
                  completion: state.completion);
            } else if (state is LoginWithEmailAndPasswordErrorMessageState) {
              EasyLoading.dismiss();
              EasyLoading.showError(state.errorMessage);
            } else if (state is LoginWithEmailAndPasswordLoadingState) {
              EasyLoading.show(status: 'loading...');
              
            }
            else {
              EasyLoading.dismiss();
            }
          },
          child: BlocListener<SignInWithPlatformBloc, SignInWithPlatformState>(
            listener: (context, state) async {
              if (state is SignWithGoogleSuccesMessageState) {
                EasyLoading.dismiss();
                MyApp.userId=state.userId;
                Methods.instance.navigateToAddInfo(
                    isComplete: state.isCompleted,  userId: state.userId,
                    completion: state.complition);
              } else if (state is SignWithGoogleErrorMessageState) {
                EasyLoading.dismiss();
                EasyLoading.showError(state.errorMessage);
              } else if (state is SignWithPlatFormLoadingState) {
                EasyLoading.show(status: 'loading...');
              }
              else{
                EasyLoading.dismiss();
              }
            },
            child: Padding(
              padding: EdgeInsets.all(AppSize.defaultSize! * 1.5),
              child: Column(
                children: [
                  SizedBox(
                    height: AppSize.defaultSize! * 8,
                  ),
                  SvgPicture.asset(AssetPath.logo,
                    width:  AppSize.defaultSize! * 5,
                    height:  AppSize.defaultSize! * 5,
                  )
                      .animate()
                      .fadeIn() // uses `Animate.defaultDuration`
                      .scale() // inherits duration from fadeIn
                      .move(delay: 300.ms, duration: 600.ms),
                  SizedBox(
                    height: AppSize.defaultSize! * 2,
                  ),
                  CustomText(
                    text: StringManager.letBeginTheJourney.tr(),
                    color: AppColors.blackColor,
                    fontSize: AppSize.defaultSize! * 1.8,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(
                    height: AppSize.defaultSize! * 3,
                  ),
                  CustomSignInButton(
                    text: StringManager.continueWithGoogle.tr(),
                    logo: SvgPicture.asset(AssetPath.google,
                      width:  AppSize.defaultSize! * 2.5,
                      height:  AppSize.defaultSize! * 2.5,
                    ),
                    onPressed: () {
                      BlocProvider.of<SignInWithPlatformBloc>(context)
                          .add(SignGoogleEvent());
                    },
                  ),
                  SizedBox(height: AppSize.defaultSize! * 2),
                  // LinkedInAuthCodeWidget(
                  //   redirectUrl: redirectUrl,
                  //   clientId: '7758y5q1hruhet',
                  //
                  //   onGetAuthCode:
                  //       (AuthorizationSucceededAction response) {
                  //     print('Auth code ${response.codeResponse.code}');
                  //     print('State: ${response.codeResponse.state}');
                  //   },
                  //   onError: (AuthorizationFailedAction e) {
                  //     print('Error: ${e.toString()}');
                  //   },
                  // ),
                  CustomSignInButton(
                    text: StringManager.continueWithLinkedin.tr(),
                    logo: SvgPicture.asset(AssetPath.linkedin2,

                      width:  AppSize.defaultSize! * 2.5,
                      height:  AppSize.defaultSize! * 2.5,),
                    onPressed: () {
                      // Navigator.pushNamed(context, Routes.personalInfo);
                      // BlocProvider.of<SignInWithPlatformBloc>(context)
                      //     .add(SignInWithFacebookEvent());
                    },
                  ),
                  SizedBox(height: AppSize.defaultSize! * 2),
                  // if(Platform.isIOS)
                  CustomSignInButton(
                    text: StringManager.continueWithApple.tr(),
                    logo: SvgPicture.asset(AssetPath.apple,
                      width:  AppSize.defaultSize! * 3,
                      height:  AppSize.defaultSize! *3,
                    ),
                    onPressed: () {
                      // Navigator.pushNamed(context, Routes.personalInfo);
                      // BlocProvider.of<SignInWithPlatformBloc>(context)
                      //     .add(SignInWithFacebookEvent());
                    },
                  ),
                  SizedBox(height: AppSize.defaultSize! * 4),
                  CustomTextField(
                    formKey: _formKey,
                    labelText: StringManager.email.tr(),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: AppSize.defaultSize! * 1.3),
                  CustomTextField(
                    labelText: StringManager.password.tr(),
                    obscureText: isVisible,
                    controller: passwordController,
                    maxLines: 1,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      child: Icon(
                        isVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.forgetPassword);
                      },
                      child: CustomText(
                        text: StringManager.forgetYourPassword.tr(),
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: AppSize.defaultSize! * 1.4,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppSize.defaultSize! * 2,
                  ),
                  MainButton(
                    text: StringManager.login.tr(),
                    onTap: () {
                      if (validation()) {
                        BlocProvider.of<LoginWithEmailAndPasswordBloc>(context)
                            .add(LoginWithEmailAndPasswordEvent(
                          email: emailController.text,
                          password: passwordController.text,
                        ));
                        // Navigator.pushNamed(context, Routes.academicInfo);
                      } else {
                        errorSnackBar(
                            context, StringManager.pleaseCompleteYourData.tr());
                      }
                    },
                  ),
                  SizedBox(
                    height: AppSize.defaultSize! * 4,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool validation() {
    if (emailController.text == '') {
      return false;
    } else if (passwordController.text == '') {
      return false;
    } else {
      return true;
    }
  }
}
