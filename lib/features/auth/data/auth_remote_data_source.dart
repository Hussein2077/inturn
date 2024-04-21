import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inturn/core/error/exception.dart';
import 'package:inturn/core/models/my_data_model.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/core/utils/constant_api.dart';
import 'package:inturn/core/utils/methods.dart';
import 'package:inturn/features/auth/domain/use_case/add_info_uc.dart';
import 'package:inturn/features/auth/domain/use_case/login_with_email_and_password_use_case.dart';
import 'package:inturn/features/auth/domain/use_case/sign_up_use_case.dart';

abstract class BaseRemotelyDataSource {
  Future<Map<String, dynamic>> loginWithEmailAndPassword(AuthModel authModel);
  Future<Map<String, dynamic>> signUpWithEmailAndPassword(
      SignUpModel signUpModel);
  Future<Map<String, dynamic>> sendCode(SignUpModel signUpModel);
  Future<Map<String, dynamic>> verifyCode(SignUpModel signUpModel);
  Future<Map<String, dynamic>> changePassword(SignUpModel signUpModel);
  Future<AuthWithGoogleModel> sigInWithGoogle();
  Future<Map<String, dynamic>> addPersonalInfo(AuthModel authModel);
  Future<Map<String, dynamic>> sendUniversityFacultyIds(String universityId, String facultyId);
  Future<Map<String, dynamic>> sendExperienceLevel(String typeID, String jobLevelId);
  // Future<Map<String, dynamic>> locationType(LocationTypeParams locationTypeParams);

}

class AuthRemotelyDateSource extends BaseRemotelyDataSource {
  @override
  Future<Map<String, dynamic>> loginWithEmailAndPassword(
      AuthModel authModel) async {
    log('${authModel.email}vvvvv');
    log('${authModel.password}vvvvv');
    final body = {
      ConstantApi.email: authModel.email,

      ConstantApi.password: authModel.password,
    };

    try {
      final response = await Dio().post(
        ConstantApi.login,
        data: body,
      );
      Map<String, dynamic> jsonData = response.data;
      Methods.instance.saveUserToken(authToken: jsonData['token']);
      log('${jsonData}sssssssss');

      return jsonData;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "loginWithEmailAndPassword");
    }
  }

  @override
  Future<Map<String, dynamic>> signUpWithEmailAndPassword(
      SignUpModel signUpModel) async {
    final body = {
      ConstantApi.email: signUpModel.email,
      ConstantApi.password: signUpModel.password,
      'firstName': signUpModel.name,
      'lastName': signUpModel.lastName,
      'phonenumber': signUpModel.phone,
      'confirmPassword': signUpModel.password,
      'educationLevel': signUpModel.phone,
      'graduationYear': signUpModel.phone,
      'majorID': signUpModel.phone,
      'universityID': signUpModel.phone,
    };

    try {
      final response = await Dio().post(
        ConstantApi.signUp,
        data: body,
      );
      Map<String, dynamic> jsonData = response.data;
      Methods.instance.saveUserToken(authToken: jsonData['token']);
      log('${jsonData['token']}hhhhhhhhhhhh${jsonData}');
      if (jsonData['token'] == null) {
        DioException? e;
        throw DioHelper.handleDioError(
            dioError: e, endpointName: "signUpWithEmailAndPassword");
      } else {
        return jsonData;
      }
    } on DioError catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "signUpWithEmailAndPassword");
    }
  }

  @override
  Future<Map<String, dynamic>> changePassword(SignUpModel signUpModel) async {
    final body = {
      ConstantApi.password: signUpModel.password,
    };

    try {
      final response = await Dio().post(
        ConstantApi.login,
        data: body,
      );

      Map<String, dynamic> jsonData = response.data;

      return jsonData;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "changePassword");
    }
  }

  @override
  Future<Map<String, dynamic>> sendCode(SignUpModel signUpModel) async {
    final body = {
      ConstantApi.email: signUpModel.email,
    };

    try {
      final response = await Dio().post(
        ConstantApi.sendCode,
        data: body,
      );

      Map<String, dynamic> jsonData = response.data;

      return jsonData;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "changePassword");
    }
  }

  @override
  Future<Map<String, dynamic>> verifyCode(SignUpModel signUpModel) async {
    final body = {
      ConstantApi.email: signUpModel.email,
      'verification_code': signUpModel.code,
    };

    try {
      final response = await Dio().post(
        ConstantApi.verifyCode,
        data: body,
      );

      Map<String, dynamic> jsonData = response.data;

      return jsonData;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "verifyCode");
    }
  }

  @override
  Future<AuthWithGoogleModel> sigInWithGoogle() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _googleSignIn = GoogleSignIn(scopes: ['email']);
    Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
    // // ignore: unused_element
    // Future logout() => _googleSignIn.disconnect();
    final userModel = await login();
    log('${ userModel?.id}_googleSignIn');
    log('${ userModel?.email}_googleSignIn');
    // final devicedata =
    // await DioHelper().initPlatformState(); // to get information device
    Map<String, String> headers = await DioHelper().header();


    if (userModel == null) {
      throw SiginGoogleException();
    } else {
      final body = {
        ConstantApi.email: userModel.email,
        "googleID": userModel.id,
      };
      try {
        final response = await Dio().post(
          ConstantApi.googleRegister,
          data: body,
          options: Options(
            headers: headers,
          ),
        );

        Map<String, dynamic> resultData = response.data;

        MyDataModel userData = MyDataModel.fromMap(resultData);

        Methods.instance.saveUserToken(authToken: resultData['token']);
        log('${resultData}resultData');
        log('${AuthWithGoogleModel}resultData');
        return AuthWithGoogleModel(apiUserData: userData, userData: userModel);
      } on DioError catch (e) {
        throw DioHelper.handleDioError(
            dioError: e, endpointName: "sigInWithGoogle");
      }
    }
  }
  @override
  Future<Map<String, dynamic>> addPersonalInfo(AuthModel authModel) async {
    final body = {
      'first_name': authModel.firstName,
      'last_name': authModel.lastName,
      'email': authModel.email,
      'image': await MultipartFile.fromFile(authModel.image!.path.toString(), filename: 'image.jpg'),
      'university_id': authModel.universityId,
      'faculty_id': authModel.facultyId,
      'role': 'user',
      // 'job_level_id': authModel.jobLevelId,
      // 'experience_level_id': authModel.experienceLevelId,
      // 'university_name': authModel.universityName,
      // 'faculty_name': authModel.facultyName,
      // 'job_level_name': authModel.jobLevelName,
      // 'experience_level_name': authModel.experienceLevelName,
    };

    try {
      final response = await Dio().post(
        // ConstantApi.addPersonalInfo,
        ConstantApi.login,
        data: FormData.fromMap(body),
      );
      Map<String, dynamic> jsonData = response.data;
      // Additional processing if needed
      return jsonData;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "addPersonalInfo");
    }
  }
  @override
  Future<Map<String, dynamic>> sendUniversityFacultyIds(String universityId, String facultyId) async {
    final body = {
      'UniversityID': universityId,
      'FacultyID': facultyId,
    };

    try {
      final response = await Dio().post(
        // ConstantApi.sendUniversityFacultyIds,
        '',
        data: body,
      );
      return response.data;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "sendUniversityFacultyIds");
    }
  }

  @override
  Future<Map<String, dynamic>> sendExperienceLevel(String typeID, String jobLevelId)async {
    final body = {
      'typeID': typeID,
      'jobLevelId': jobLevelId,
    };

    try {
      final response = await Dio().post(
        // ConstantApi.sendUniversityFacultyIds,
        '',
        data: body,
      );
      return response.data;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "sendExperienceLevel");
    };
  }
}

class AuthWithGoogleModel {
  final GoogleSignInAccount userData;

  final MyDataModel apiUserData;

  AuthWithGoogleModel({required this.apiUserData, required this.userData});
}
