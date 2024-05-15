import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/core/service/navigator_services.dart';
import 'package:inturn/core/service/service_locator.dart';
import 'package:inturn/core/utils/methods.dart';
import 'package:inturn/core/widgets/loading_widget.dart';
import 'package:inturn/features/auth/presentation/add_info_flow/acdemic_info.dart';
import 'package:inturn/features/auth/presentation/add_info_flow/exprince_info.dart';
import 'package:inturn/features/auth/presentation/add_info_flow/fields_of_work.dart';
import 'package:inturn/features/auth/presentation/add_info_flow/location_info.dart';
import 'package:inturn/features/auth/presentation/add_info_flow/personal_info.dart';
import 'package:inturn/features/auth/presentation/add_info_flow/skills.dart';
import 'package:inturn/features/auth/presentation/add_info_flow/thanks.dart';
import 'package:inturn/features/auth/presentation/forget%20password/change_password.dart';
import 'package:inturn/features/auth/presentation/forget%20password/forget_password.dart';
import 'package:inturn/features/auth/presentation/forget%20password/send_otp_code.dart';
import 'package:inturn/features/auth/presentation/login_screen.dart';
import 'package:inturn/features/auth/presentation/signup/sign_up.dart';
import 'package:inturn/features/home/presentation/componants/filters_screen.dart';
import 'package:inturn/features/home/presentation/componants/job_details.dart';
import 'package:inturn/features/home/presentation/componants/search_screen.dart';
import 'package:inturn/features/main_screen.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_data/get_my_data_bloc.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_data/get_my_data_event.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_data/get_my_data_state.dart';
import 'package:inturn/features/profile/presentation/profile_screen.dart';
import 'package:inturn/main.dart';

class Routes {
  static const String login = "/login";
  static const String main = "/main";
  static const String signUp = "/signUp";
  static const String forgetPassword = "/forgetPassword";
  static const String sendOTPCode = "/sendOTPCode";
  static const String changePassword = "/changePassword";
  static const String personalInfo = "/personalInfo";
  static const String academicInfo = "/academicInfo";
  static const String experienceInfo = "/experienceInfo";
  static const String fieldInfo = "/fieldInfo";
  static const String locationInfo = "/locationInfo";
  static const String skillsInfo = "/skillsInfo";
  static const String skills = "/skills";
  static const String thanks = "/thanks";
  static const String searchScreen = "/SearchScreen";
  static const String filtersScreen = "/FiltersScreen";

  // static const String jobDetails = "/JobDetailsScreen";

////////////////////////////////

  static const String profile = "/profile";
  static const String blogComplete = "/BlogComplete";
  static const String cvBuilderScreen = "/CVBuilderScreen";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.main:
        String? userId;
        log("userIdbefffoof: $userId");

        userId = MyApp.userId;
        log("userId: $userId");
        BlocProvider.of<GetMyDataBloc>(
                getIt<NavigationService>().navigatorKey.currentContext!)
            .add(GetMyDataEvent(userId ?? MyApp.userId));
        if (MyApp.fromLogin) {
          return PageRouteBuilder(
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) =>
                  MainScreen(
                    userID: userId ?? MyApp.userId,
                  ),
              transitionsBuilder: customAnimate);
        }
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) {
              // return const MainScreen();
              return BlocBuilder<GetMyDataBloc, GetMyDataState>(
                  builder: (context, state) {
                if (state is GetMyDataLoadingState) {
                  return const Center(child: LoadingWidget());
                }
                if (state is GetMyDataSuccessMessageState) {
                  if (state.myDataModel.isCompleted!) {
                    return MainScreen(
                      userID: userId ?? MyApp.userId,
                    );
                  } else {
                    return getScreenFromCompletion(
                        state.myDataModel.complition ?? 0,
                        userId ?? MyApp.userId);
                  }
                }
                if (state is GetMyDataErrorMessageState) {
                  return MainScreen(
                    userID: userId ?? MyApp.userId,
                  );
                }
                return MainScreen(
                  userID: userId ?? MyApp.userId,
                );
              });
            },
            transitionsBuilder: customAnimate);
      case Routes.login:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const LoginScreen(),
            transitionsBuilder: customAnimate);

      case Routes.signUp:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const SignUpScreen(),
            transitionsBuilder: customAnimate);
      case Routes.personalInfo:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                PersonalInfo(),
            transitionsBuilder: customAnimate);
      case Routes.academicInfo:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const AcademicInfo(),
            transitionsBuilder: customAnimate);
      case Routes.experienceInfo:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const ExperienceInfo(),
            transitionsBuilder: customAnimate);
      case Routes.locationInfo:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const LocationInfo(),
            transitionsBuilder: customAnimate);
      case Routes.fieldInfo:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const FieldsInfo(),
            transitionsBuilder: customAnimate);
      case Routes.skillsInfo:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const SkillInfo(),
            transitionsBuilder: customAnimate);
      case Routes.thanks:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const ThanksScreen(),
            transitionsBuilder: customAnimate);
      // case Routes.jobDetails:
      // return PageRouteBuilder(
      //     pageBuilder: (context, animation, secondaryAnimation) =>
      //         const JobDetailsScreen(),
      //     transitionsBuilder: customAnimate);
////////////////////////////////////
      case Routes.forgetPassword:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const ForgetPassword(),
            transitionsBuilder: customAnimate);
      case Routes.sendOTPCode:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const SendOTPCode(),
            transitionsBuilder: customAnimate);
      case Routes.changePassword:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const ChangePassword(),
            transitionsBuilder: customAnimate);
      case Routes.profile:
        String userId = settings.arguments as String;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              ProfileScreen(
            userId: userId,
          ),
          transitionsBuilder: customAnimate,
          settings: settings,
        );

      case Routes.searchScreen:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) =>
                SearchScreen(),
            transitionsBuilder: customAnimate);

      case Routes.filtersScreen:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) =>
                const FiltersScreen(),
            transitionsBuilder: customAnimate);
    }
    return unDefinedRoute(
        getIt<NavigationService>().navigatorKey.currentContext!);
  }

  static Route<dynamic> unDefinedRoute(BuildContext context) {
    return MaterialPageRoute(
      builder: (context) => WillPopScope(
        onWillPop: () async {
          bool leaveApp = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Confirm Exit'),
              content: const Text('Are you sure you want to leave the app?'),
              actions: [
                TextButton(
                  onPressed: () {
                    // Stay in the app
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.main, (route) => false,
                        arguments: MyApp.userId);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    // Leave the app
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Exit'),
                ),
              ],
            ),
          );

          // Return whether to leave the app or not
          return leaveApp ?? false;
        },
        child: Container(), // Replace with your app's content
      ),
    );
  }
}

Widget customAnimate(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  // var begin = Offset(1.0, 0.0);
  // var end = Offset.zero;
  // var curve = Curves.decelerate;
  //
  // var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  return FadeTransition(
    opacity: animation,
    child: child,
  );
}

Widget getScreenFromCompletion(int completion, String userId) {
  switch (completion) {
    case 20:
      return const PersonalInfo();
    case 30:
      return const AcademicInfo();
    case 45:
      return const ExperienceInfo();
    case 60:
      return const LocationInfo();
    case 75:
      return const FieldsInfo();
    case 90:
      return const SkillInfo();
    default:
      return MainScreen(
        userID: userId,
      );
  }
}
