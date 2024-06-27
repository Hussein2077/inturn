import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:inturn/core/models/my_data_model.dart';
import 'package:inturn/core/models/profile_data_model.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/core/utils/constant_api.dart';
import 'package:inturn/features/profile/domain/use_case/change_password_uc.dart';
import 'package:inturn/features/profile/domain/use_case/edit_profile_uc.dart';
import 'package:inturn/features/profile/domain/use_case/upload_pdf.dart';
import 'package:inturn/main.dart';
import 'package:http_parser/http_parser.dart';

abstract class BaseRemotelyDataSourceProfile {
  Future<MyDataModel> getMyData();

  Future<MyDataModel> completeProfile();

  Future<String> editProfileData(EditPersonalInfoParams parameter);

  Future<ProfileDataModel> getMyProfileData(String id);

  Future<String> uploadPdf(UploadPDFParams uploadPDFParams);

  Future<String> getPdf();

  Future<Map<String, dynamic>> changePassword(ChangePasswordModel changePasswordModel);
}

class ProfileRemotelyDateSource extends BaseRemotelyDataSourceProfile {
  @override
  Future<MyDataModel> getMyData() async {
     final Options options = await DioHelper().options();

    try {
      final response = await Dio().post(
         options: options,
        ConstantApi.myData,

      );

      MyDataModel jsonData = MyDataModel.fromMap(response.data);
      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "get my data");
    }
  }



  @override
  Future<MyDataModel> completeProfile() async {
     final Options options = await DioHelper().options();
    try {
      final response = await Dio().post(
         options: options,
        ConstantApi.complete,
      );

      MyDataModel jsonData = MyDataModel.fromMap(response.data);
      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "completeProfile");
    }
  }

  @override
  Future<String> editProfileData(EditPersonalInfoParams parameter) async {
     final Options options = await DioHelper().options();
    late FormData formData;
    if (parameter.image == null) {
      formData = FormData.fromMap({
        'UserId': MyApp.userId,
        'FirstName': parameter.firstName,
        'LastName': parameter.lastName,
        'UniversityId':
            parameter.UniversityId == '0' ? null : parameter.UniversityId,
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
    } else {
      formData = FormData.fromMap({
        'UserId': MyApp.userId,
        'FirstName': parameter.firstName,
        'LastName': parameter.lastName,
        'UniversityId':
            parameter.UniversityId == '0' ? null : parameter.UniversityId,
        'FacultyId': parameter.FacultyId,
        'Description': parameter.Description,
        'JobLevelId': parameter.JobLevelId,
        'GraduationStatusId': parameter.GraduationStatusId,
        'JobLocationTypeId': parameter.JobLocationTypeId,
        'MajorIds': parameter.MajorIds,
        'SkillIds': parameter.SkillIds,
        'CountryId': parameter.CountryId,
        'CityId': parameter.CityId,
        'ImageFile': await MultipartFile.fromFile(parameter.image!.path,
            filename: parameter.image?.path.split('/').last.toString(),
            contentType: MediaType("image", "jpeg")),
      });
    }

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
         options: options,
        ConstantApi.editProfileData(),
        data: formData,
      );

      return 'success';
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "editProfileData");
    }
  }

  @override
  Future<ProfileDataModel> getMyProfileData(String id) async {
     final Options options = await DioHelper().options();
    try {
      final response = await Dio().get(
         options: options,
        ConstantApi.getMyData(id),
      );

      ProfileDataModel jsonData = ProfileDataModel.fromJson(response.data);
      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "getMyProfileData");
    }
  }

  @override
  Future<String> uploadPdf(UploadPDFParams uploadPDFParams) async {
     final Options options = await DioHelper().options();
    try {
      FormData formData = FormData.fromMap({
        "CVFile": await MultipartFile.fromFile(
          uploadPDFParams.file.path,
          filename: uploadPDFParams.file.path.split('/').last.toString(),
        ),
        "UserId": MyApp.userId
      });
      final response = uploadPDFParams.type == 2
           ? await Dio().post(
          options: options,
          ConstantApi.updatePdf, data: formData)
           : await Dio().post(
          options: options,
          ConstantApi.uploadPdf, data: formData);
      return 'Upload Success';
    } on DioException catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "uploadPdf");
    }
  }
  @override
  Future<String> getPdf() async {
     final Options options = await DioHelper().options();
    try {
      final response = await Dio().get(
         options: options,
        ConstantApi.getCV(MyApp.userId),
      );

      Map<String, dynamic> jsonData = response.data;
      return jsonData["fileName"];
    } on DioException catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "getPdf");
    }
  }


  @override
  Future<Map<String, dynamic>> changePassword(ChangePasswordModel signUpModel) async {
     final Options options = await DioHelper().options();
    final body = {
      'newPassword' : signUpModel.newPassword,
      'currentPassword': signUpModel.oldPassword,
      'userId': signUpModel.id,
    };

    try {
      final response = await Dio().post(
         options: options,
        ConstantApi.changePassword,
        data: body,
      );

      Map<String, dynamic> jsonData = response.data;

      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "changePassword");
    }
  }
}
