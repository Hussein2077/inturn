import 'package:flutter/material.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/core/widgets/vacancy_details.dart';
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
import 'package:inturn/features/home/presentation/componants/job_details.dart';
import 'package:inturn/features/main_screen.dart';
import 'package:inturn/features/profile/presentation/componants/contact_us/contact_us.dart';
import 'package:inturn/features/profile/presentation/componants/my_applications.dart';
import 'package:inturn/features/profile/presentation/profile_screen.dart';

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
  static const String jobDetails = "/JobDetailsScreen";

////////////////////////////////

  static const String profile = "/profile";
  static const String myApplications = "/myApplications";
  static const String contactUs = "/contactUs";
  static const String blogComplete = "/BlogComplete";
  static const String vacancyDetails = "/VacancyDetails";
  static const String cvBuilderScreen = "/CVBuilderScreen";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.main:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const MainScreen(),
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
                const PersonalInfo(),
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
        case Routes.jobDetails:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const JobDetailsScreen(),
            transitionsBuilder: customAnimate);
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
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const ProfileScreen(),
            transitionsBuilder: customAnimate);
      case Routes.myApplications:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const MyApplications(),
            transitionsBuilder: customAnimate);
      case Routes.contactUs:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const ContactUS(),
            transitionsBuilder: customAnimate);
      case Routes.vacancyDetails:
        VacancyModel vacancyModel = settings.arguments as VacancyModel;

        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) =>
                VacancyDetails(
                  vacancyModel: vacancyModel,
                ),
            transitionsBuilder: customAnimate);
    }
    return unDefinedRoute();
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(builder: (context) => const Scaffold());
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
