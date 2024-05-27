import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:inturn/core/models/my_data_model.dart';
import 'package:inturn/core/models/profile_data_model.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/core/utils/constant_api.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/features/profile/domain/use_case/edit_profile_uc.dart';
import 'package:inturn/features/profile/domain/use_case/upload_pdf.dart';
import 'package:inturn/main.dart';
import 'package:http_parser/http_parser.dart';

abstract class BaseRemotelyDataSourceProfile {
  Future<MyDataModel> getMyData(String id);

  Future<MyDataModel> completeProfile(String id);

  Future<String> editProfileData(EditPersonalInfoParams parameter);

  Future<ProfileDataModel> getMyProfileData(String id);

  Future<String> uploadPdf(UploadPDFParams uploadPDFParams);

  Future<String> getPdf();
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
  Future<String> getPdf() async {
    log('gfgfresponse.data');
    try {
      final response = await Dio().get(
        ConstantApi.getCV(MyApp.userId),
      );

      Map<String, dynamic> jsonData = response.data;

      return jsonData["fileName"];
    } on DioException catch (e) {
      log('${e}ssssssssssssssssssssssffffffsss');
      throw DioHelper.handleDioError(dioError: e, endpointName: "getPdf");
    }
  }

  @override
  Future<MyDataModel> completeProfile(String id) async {
    try {
      final response = await Dio().post(
        ConstantApi.complete(id),
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

  @override
  Future<String> uploadPdf(UploadPDFParams uploadPDFParams) async {
    try {
      FormData formData = FormData.fromMap({
        "CVFile": await MultipartFile.fromFile(
          uploadPDFParams.file.path,
          filename: uploadPDFParams.file.path.split('/').last.toString(),
        ),
        "UserId": MyApp.userId
      });
      final response = uploadPDFParams.type == 1
          ? await Dio().post(ConstantApi.uploadPdf, data: formData)
          : await Dio().post(ConstantApi.updatePdf, data: formData);

      return 'Upload Success';
    } on DioException catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "uploadPdf");
    }
  }
}
