import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/service/navigator_services.dart';
import 'package:inturn/core/service/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Methods {
//singleton class
  Methods._internal();

  static final   instance =   Methods._internal() ;

  factory  Methods() => instance ;
  Future<void> saveUserToken({String? authToken}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (authToken != null) {
      preferences.setString(StringManager.userTokenKey, authToken);
    } else {
      preferences.setString(StringManager.userTokenKey, authToken ?? "noToken");
    }

  }Future<void> saveUserId({int? userId}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    log('$userId hussssssssssssssssmmm');
    if (userId != null) {
      preferences.setInt(StringManager.userIDKey, userId);
    } else {
      preferences.setInt(StringManager.userIDKey, userId ?? 0);
    }

  }Future<void> saveProfileId({String? profileId}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    log('$profileId hussssssssssssssssmmm');
    if (profileId != null) {
      preferences.setString(StringManager.profileIDKey, profileId);
    } else {
      preferences.setString(StringManager.profileIDKey, profileId ?? '0');
    }

  }
  Future<String> returnUserToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String tokenPref =
        preferences.getString(StringManager.userTokenKey) ?? "noToken";
    return tokenPref;
  }
  Future<String> returnUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
     String tokenPref =
        preferences.getString(StringManager.userIDKey) ?? '0';
    return tokenPref;
  }  Future<int> returnProfileId () async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
     int tokenPref =
        preferences.getInt(StringManager.profileIDKey) ?? 0;
    return tokenPref;
  }
  navigateToAddInfo({required bool isComplete, required int completion }) {
    if (isComplete) {
      Navigator.pushNamedAndRemoveUntil(
          getIt<NavigationService>().navigatorKey.currentContext!,
          Routes.main,
              (route) => false);
    } else {
      if(completion == 0){
        Navigator.pushNamedAndRemoveUntil(
            getIt<NavigationService>().navigatorKey.currentContext!,
            Routes.personalInfo,
                (route) => false);
      }
      else if(completion == 30){
        Navigator.pushNamedAndRemoveUntil(
            getIt<NavigationService>().navigatorKey.currentContext!,
            Routes.academicInfo,
                (route) => false);
      }
      else if(completion == 45){
        Navigator.pushNamedAndRemoveUntil(
            getIt<NavigationService>().navigatorKey.currentContext!,
            Routes.experienceInfo,
                (route) => false);
      }
      else if(completion == 60){
        Navigator.pushNamedAndRemoveUntil(
            getIt<NavigationService>().navigatorKey.currentContext!,
            Routes.locationInfo,
                (route) => false);
      }
      else if(completion == 75){
        Navigator.pushNamedAndRemoveUntil(
            getIt<NavigationService>().navigatorKey.currentContext!,
            Routes.fieldInfo,
                (route) => false);
      }
      else if(completion == 90){
        Navigator.pushNamedAndRemoveUntil(
            getIt<NavigationService>().navigatorKey.currentContext!,
            Routes.skillsInfo,
                (route) => false);
      }


    }
  }


}