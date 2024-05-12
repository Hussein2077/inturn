import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:inturn/core/models/my_data_model.dart';
import 'package:inturn/core/models/profile_data_model.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/core/utils/constant_api.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/features/profile/domain/use_case/edit_profile_uc.dart';
import 'package:inturn/main.dart';

abstract class BaseRemotelyDataSourceProfile {
  Future<MyDataModel> getMyData(String id);
  Future<MyDataModel> completeProfile(String id);

  Future<String> editProfileData(EditPersonalInfoParams parameter);

  Future<ProfileDataModel> getMyProfileData(String id);
}

class ProfileRemotelyDateSource extends BaseRemotelyDataSourceProfile {
  @override
  Future<MyDataModel> getMyData(String id) async {
    try {
      final response = await Dio().post(
        ConstantApi.myData(id),
      );

      MyDataModel jsonData = MyDataModel.fromMap(response.data);
      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "get my data");
    }
  }
  @override
  Future<MyDataModel>  completeProfile(  String id) async {
    try {
      final response = await Dio().post(
        ConstantApi.complete(id),
      );

      MyDataModel jsonData = MyDataModel.fromMap(response.data);
      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "completeProfile");
    }
  }

  @override
  Future<String> editProfileData(EditPersonalInfoParams parameter) async {
    FormData formData = FormData.fromMap({
      'UserId': MyApp.userId,
      'FirstName': parameter.firstName,
      'LastName': parameter.lastName,
      'UniversityId': parameter.UniversityId=='0'?null:parameter.UniversityId,
      'FacultyId': parameter.FacultyId,
      'Description': parameter.Description,
      'JobLevelId': parameter.JobLevelId,
      'GraduationStatusId': parameter.GraduationStatusId,
      'JobLocationTypeId': parameter.JobLocationTypeId,
      'MajorIds': parameter.MajorIds,
      'SkillIds': parameter.SkillIds,
      'CountryId': parameter.CountryId,
      'CityId': parameter.CityId,
    });

    log('${parameter.firstName} firstname');

    log('${parameter.lastName} lastname');

    log('${parameter.UniversityId} UniversityId');

    log('${parameter.FacultyId} FacultyId');

    log('${parameter.Description} Description');

    log('${parameter.JobLevelId} JobLevelId');

    log('${parameter.GraduationStatusId} GraduationStatusId');

    log('${parameter.JobLocationTypeId} JobLocationTypeId');

    log('${parameter.MajorIds} MajorIds');

    log('${parameter.SkillIds} SkillIds');

    log('${parameter.CountryId} CountryId');

    log('${parameter.CityId} CityId');

    log('${MyApp.userId} userId');


    try {
      final response = await Dio().post(
        ConstantApi.editProfileData( ),
        data: formData,
      );

      return 'success';
    } on DioException catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "editProfileData");
    }
  }

  @override
  Future<ProfileDataModel> getMyProfileData(String id) async {
    try {
      final response = await Dio().get(
        ConstantApi.getMyData(id),
      );

      ProfileDataModel jsonData = ProfileDataModel.fromJson(response.data);
      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "getMyProfileData");
    }
  }
}
