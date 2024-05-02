import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:inturn/core/models/my_data_model.dart';
import 'package:inturn/core/models/profile_data_model.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/core/utils/constant_api.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/features/profile/domain/use_case/edit_profile_uc.dart';

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
      'UserId': parameter.id,
      'FirstName': parameter.firstName,
      'LastName': parameter.lastName,
      'UniversityId': parameter.UniversityId,
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

    try {
      final response = await Dio().post(
        ConstantApi.editProfileData(parameter.id),
        data: formData,
      );

      return "seccess";
    } on DioException catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "get my data");
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
