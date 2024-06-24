import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:inturn/core/error/exception.dart';
import 'package:inturn/core/models/my_data_model.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/core/utils/constant_api.dart';
import 'package:inturn/core/utils/methods.dart';
import 'package:inturn/features/auth/domain/use_case/add_info_uc.dart';
import 'package:inturn/features/auth/domain/use_case/login_with_email_and_password_use_case.dart';
import 'package:inturn/features/auth/domain/use_case/sign_up_use_case.dart';
import 'package:inturn/features/auth/presentation/add_info_flow/location_info.dart';
import 'package:inturn/features/profile/domain/use_case/change_password_uc.dart';
import 'package:inturn/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
abstract class BaseRemotelyDataSource {
  Future<Map<String, dynamic>> loginWithEmailAndPassword(AuthModel authModel);

  Future<Map<String, dynamic>> signUpWithEmailAndPassword(
      SignUpModel signUpModel);

  Future<String> sendCode(SignUpModel signUpModel);

  Future<Map<String, dynamic>> verifyCode(SignUpModel signUpModel);

  Future<Map<String, dynamic>> resetPassword(SignUpModel signUpModel);


  //add info
  Future<Map<String, dynamic>> addPersonalInfo(PersonalInfoParams params);

  Future<dynamic> sendUniversityFacultyIds(
      String universityId, String facultyId);

  Future<dynamic> sendExperienceLevel(String typeID, String jobLevelId);

  Future<dynamic> locationType(LocationTypeParams locationTypeParams);

  Future<dynamic> majorOfFields(List<int> majorIds);

  Future<dynamic> sendSkills(List<int> skillIds);
}

class AuthRemotelyDateSource extends BaseRemotelyDataSource {
  @override
  Future<Map<String, dynamic>> loginWithEmailAndPassword(
      AuthModel authModel) async {
    final body = {
      'phonenumber': authModel.phone,
      "password": authModel.password,
      "userRole": "User",
    };

    try {
      final response = await Dio().post(
        ConstantApi.login,
        data: body,
      );
      Map<String, dynamic> jsonData = response.data;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.remove(StringManager.userIDKey);
      preferences.remove(StringManager.profileIDKey);
      await Methods.instance.saveUserToken(authToken: jsonData['token']);
      await  Methods.instance.saveUserId(userId: jsonData['userId']);
      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "loginWithEmailAndPassword");
    }
  }



  @override
  Future<Map<String, dynamic>> addPersonalInfo(
      PersonalInfoParams params) async {
    log('${params.userId}_addPersonalInfo');
    log('${params.firstName}_addPersonalInfo');
    log('${params.lastName}_addPersonalInfo');
    log('${params.image.path}_addPersonalInfo');

    // File file = params.image;
    // String fileName = file.path.split('/').last;
   //  var formData = FormData.fromMap({
   //                  'img': await MultipartFile.fromFile(params.image.path,
   //                      filename:params.image.path.split('/').last.toString(),
   //                      contentType: MediaType("image", "jpeg")),
   // });

    FormData formData = FormData.fromMap({
      'UserId': params.userId,
      'FirstName': params.firstName,
      'LastName': params.lastName,
      'ImageFile':
      await MultipartFile.fromFile(params.image.path,
          filename:params.image.path.split('/').last.toString(),
          contentType: MediaType("image", "jpeg")),
    });

    try {
      final response = await Dio().post(
        ConstantApi.addPersonalInfo(),
        data: formData,
      );

      Map<String, dynamic> jsonData = response.data as Map<String, dynamic>;
      Methods.instance.saveProfileId(profileId: jsonData['userProfileId']);

      MyApp.userProfileId = jsonData['userProfileId'];
      // Additional processing if needed
      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "addPersonalInfo");
    }
  }

  @override
  Future<dynamic> sendUniversityFacultyIds(
      String universityId, String facultyId) async {
    final body = {
      'userId': MyApp.userId,
      'userProfileId': MyApp.userProfileId,
      'UniversityID': universityId,
      'FacultyID': facultyId,
    };

    try {
      final response = await Dio().post(
        ConstantApi.sendUniversityFacultyIds(MyApp.userId,),
        data: body,
      );
      return response.data;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "sendUniversityFacultyIds");
    }
  }

  @override
  Future<dynamic> sendExperienceLevel(String typeID, String jobLevelId) async {
    final body = {
      'graduationStatusId': typeID,
      'jobLevelId': jobLevelId,
      'userId': MyApp.userId,
      'userProfileId': MyApp.userProfileId,
    };

    try {
      final response = await Dio().post(
        ConstantApi.sendExperienceLevel(MyApp.userId, ),
        data: body,
      );
      return response.data;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "sendExperienceLevel");
    }
  }

  @override
  Future<dynamic> locationType(LocationTypeParams locationTypeParams) async {

    final body = {
      'jobLocationTypeId': locationTypeParams.locationTypeID,
      'userId': MyApp.userId,
      'userProfileId': MyApp.userProfileId,
      'cityId': locationTypeParams.cityID,
      'countryId': locationTypeParams.countryID,
    };

    try {
      final response = await Dio().post(
        ConstantApi.sendLocationTypeIds(MyApp.userId,),
        data: body,
      );
      return response.data;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "locationType");
    }
  }

  @override
  Future<dynamic> majorOfFields(List<int> majorIds) async {
    final body = {
      'majorIds': majorIds,
      'userId': MyApp.userId,
      'userProfileId': MyApp.userProfileId,
    };

    try {
      final response = await Dio().post(
        ConstantApi.sendMajorIds(MyApp.userId,),
        data: body,
      );
      return response.data;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "majorOfFields");
    }
  }

  @override
  Future<dynamic> sendSkills(List<int> skillIds) async {
    final body = {
      'skillIds': skillIds,
      'userId': MyApp.userId,
      'userProfileId': MyApp.userProfileId,
    };

    try {
      final response = await Dio().post(
        ConstantApi.sendSkills(MyApp.userId,),
        data: body,
      );
      return response.data;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "sendSkills");
    }
  }
  @override
  Future<Map<String, dynamic>> signUpWithEmailAndPassword(
      SignUpModel signUpModel) async {
    final body = {
      ConstantApi.password: signUpModel.password,
      'phonenumber': signUpModel.phone,
    };

    try {
      final response = await Dio().post(
        ConstantApi.signUp,
        data: body,
      );
      Map<String, dynamic> jsonData = response.data;
      await Methods.instance.saveUserToken(authToken: jsonData['token']);
      if (jsonData['token'] == null) {
        DioException? e;
        throw DioHelper.handleDioError(
            dioError: e, endpointName: "signUpWithEmailAndPassword");
      } else {
        return jsonData;
      }
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "signUpWithEmailAndPassword");
    }
  }

  @override
  Future<Map<String, dynamic>> resetPassword(SignUpModel signUpModel) async {
    final body = {
      'newPassword' : signUpModel.password,
      'email': signUpModel.phone,
      'otp': signUpModel.code,
    };

    try {
      final response = await Dio().post(
        ConstantApi.resetPassword,
        data: body,
      );

      Map<String, dynamic> jsonData = response.data;

      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "changePassword");
    }
  }


  @override
  Future<String> sendCode(SignUpModel signUpModel) async {
    final body = {
      'email': signUpModel.phone,
    };

    try {
      final response = await Dio().post(
        ConstantApi.sendCode,
        data: body,
      );

      String jsonData = response.data;

      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "sendCode");
    }
  }

  @override
  Future<Map<String, dynamic>> verifyCode(SignUpModel signUpModel) async {
    final body = {
      'email': signUpModel.phone,
      'otp': signUpModel.code,
    };

    try {
      final response = await Dio().post(
        ConstantApi.verifyCode,
        data: body,
      );

      Map<String, dynamic> jsonData = response.data;

      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "verifyCode");
    }
  }

}

