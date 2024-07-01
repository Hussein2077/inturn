import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/models/profile_data_model.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/service/navigator_services.dart';
import 'package:inturn/core/service/service_locator.dart';
import 'package:inturn/features/home/data/model/major_model.dart';
import 'package:inturn/features/home/data/model/skill_model.dart';
import 'package:inturn/main.dart';
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

  }
  Future<void> saveUserId({String? userId}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    log('$userId hussssssssssssssssmmm');
    if (userId != null) {
      preferences.setString(StringManager.userIDKey, userId);
    } else {
      preferences.setString(StringManager.userIDKey, userId ?? '0');
    }

  }Future<void>
  saveProfileId({int? profileId}) async {
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
  navigateToAddInfo({required bool isComplete, required int completion,required String userId }) {
    MyApp.userId=userId;
    MyApp.userId=userId;
    log('$completion _navigateToAddInfo');
    if (isComplete) {

      Navigator.pushNamedAndRemoveUntil(
          getIt<NavigationService>().navigatorKey.currentContext!,
          Routes.main,arguments: userId,
              (route) => false);
    } else {
      if(completion == 20){
        Navigator.pushNamedAndRemoveUntil(
            getIt<NavigationService>().navigatorKey.currentContext!,
            Routes.personalInfo,
                arguments: userId,
                (route) => false);
      }
      else if(completion == 30){
        Navigator.pushNamedAndRemoveUntil(
            getIt<NavigationService>().navigatorKey.currentContext!,
            Routes.experienceInfo,
                (route) => false);
      }
      else if(completion == 45){
        bool? isStudent;
        Future.delayed(Duration.zero, () async{
          isStudent = await Methods.instance.returnIfStudent();
          log('${isStudent}cvcvcv');
        });
        Navigator.pushNamedAndRemoveUntil(
            getIt<NavigationService>().navigatorKey.currentContext!,
            Routes.academicInfo,
                arguments: isStudent,
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
      else{
        MyApp.fromLogin = true;
        Navigator.pushNamedAndRemoveUntil(
            getIt<NavigationService>().navigatorKey.currentContext!,
            Routes.main,arguments: userId,
                (route) => false);
      }


    }
  }
  List<T> combineLists<T>(List<T> list1, List<T> list2) {
    Set<T> resultSet = {};
    resultSet.addAll(list1);
    resultSet.addAll(list2);
    return resultSet.toList();
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
  List<CommonType> castLists(List<SkillModel> list1, List<UserSkill> list2) {
    List<CommonType> result = [];

    result.addAll(list1.map((model) => CommonType(model.skillNameEn??"", model.skillId??0)));
    result.addAll(list2.map((model) => CommonType(model.skill?.skillNameEn??"", model.skill?.skillId??0)));

    return result;
  }

  Future<void> saveLocalazitaon({required String language}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("languagne", language);
  }

  Future<String> getlocalization() async {
    final String defaultLocale = Platform.localeName;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String language =
        preferences.getString("languagne") ?? defaultLocale.substring(0, 2);

    return language;
  }

  saveIfStudent({bool ? isStudent}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (isStudent != null) {
      preferences.setBool(StringManager.ifStudent, isStudent );
    } else {
      preferences.setBool(StringManager.profileIDKey, isStudent ?? false);
    }

  }
  Future<bool> returnIfStudent() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    bool ifStudent =
        preferences.getBool(StringManager.ifStudent) ?? true;
    return ifStudent;
  }

}
class CommonType extends Equatable{
  final String nameEn;
  final int id;

  const CommonType(this.nameEn, this.id);

  @override
  List<Object> get props => [nameEn, id];
}

