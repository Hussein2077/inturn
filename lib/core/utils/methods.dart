import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/service/navigator_services.dart';
import 'package:inturn/core/service/service_locator.dart';
import 'package:inturn/features/home/data/model/major_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Methods {
//singleton class
  Methods._internal();

  static final   instance =   Methods._internal() ;

  factory  Methods() => instance ;
  Future<void> saveUserToken({String? authToken}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    log('$authToken hussssssssssssssssmmm');
    if (authToken != null) {
      preferences.setString(StringManager.userTokenKey, authToken);
    } else {
      preferences.setString(StringManager.userTokenKey, authToken ?? "noToken");
    }

  }Future<void> saveUserId({String? userId}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    log('$userId hussssssssssssssssmmm');
    if (userId != null) {
      preferences.setString(StringManager.userIDKey, userId);
    } else {
      preferences.setString(StringManager.userIDKey, userId ?? '0');
    }

  }Future<void> saveProfileId({int? profileId}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    log('$profileId hussssssssssssssssmmm');
    if (profileId != null) {
      preferences.setInt(StringManager.profileIDKey, profileId);
    } else {
      preferences.setInt(StringManager.profileIDKey, profileId ?? 0);
    }

  }
  Future<String> returnUserToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String tokenPref =
        preferences.getString(StringManager.userTokenKey) ?? "noToken";
    log('$tokenPref dhjeyjeyjeyjye');
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

  List<int> findCommonItems(List<Position> list1, List<Position> list2) {
    List<int> commonItems = [];

    for (var item1 in list1) {
      for(var item2 in list2) {
        if (item1.majorId == item2.majorId) {
          commonItems.add(list1.indexOf(item1));
        }
      }
    }

    return commonItems;
  }

}