import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
import 'package:inturn/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseRemotelyDataSource {
  Future<Map<String, dynamic>> loginWithEmailAndPassword(AuthModel authModel);

  Future<Map<String, dynamic>> signUpWithEmailAndPassword(
      SignUpModel signUpModel);

  Future<Map<String, dynamic>> sendCode(SignUpModel signUpModel);

  Future<Map<String, dynamic>> verifyCode(SignUpModel signUpModel);

  Future<Map<String, dynamic>> changePassword(SignUpModel signUpModel);

  Future<AuthWithGoogleModel> sigInWithGoogle();

  //add info
  Future<Map<String, dynamic>> addPersonalInfo(PersonalInfoParams params);

  Future<dynamic> sendUniversityFacultyIds(
      String universityId, String facultyId);

  Future<dynamic> sendExperienceLevel(
      String typeID, String jobLevelId);
Future<dynamic> locationType(LocationTypeParams locationTypeParams);
Future<dynamic> majorOfFields(List<int> majorIds);
}

class AuthRemotelyDateSource extends BaseRemotelyDataSource {
  @override
  Future<Map<String, dynamic>> loginWithEmailAndPassword(
      AuthModel authModel) async {
    final body = {
      'email': authModel.email,
      "password": authModel.password,
      "socialID": authModel.socialID,
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
      Methods.instance.saveUserToken(authToken: jsonData['token']);
      Methods.instance.saveUserId(userId: jsonData['userId']);
      // log('${ MyApp. userId}jsonDatajsonDatajsonData');
      // MyApp. userId= jsonData['userId'];
      // log('${jsonData['userId']}jsonDatajsonDatajsonData');
      // log('${ MyApp. userId}after');
      return jsonData;
    } on DioException catch (e) {
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
      Methods.instance.saveUserId(userId: jsonData['userID']);

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
    } on DioException catch (e) {
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
    } on DioException catch (e) {
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
    } on DioException catch (e) {
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
    log('${userModel?.id}_googleSignIn');
    log('${userModel?.email}_googleSignIn');
    // final devicedata =
    // await DioHelper().initPlatformState(); // to get information device
    Map<String, String> headers = await DioHelper().header();

    if (userModel == null) {
      throw SiginGoogleException();
    } else {
      final body = {
        ConstantApi.email: userModel.email,
        "socicaID": userModel.id,
        "userRole": "User",
      };
      try {
        final response = await Dio().post(
          ConstantApi.login,
          data: body,
          options: Options(
            headers: headers,
          ),
        );

        Map<String, dynamic> resultData = response.data;

        MyDataModel userData = MyDataModel.fromMap(resultData);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.remove(StringManager.userIDKey);
        preferences.remove(StringManager.profileIDKey);
        Methods.instance.saveUserToken(authToken: resultData['token']);
        Methods.instance.saveUserId(userId: resultData['userID']);
        log('${resultData['userID']}resultData');
        log('${AuthWithGoogleModel}resultData');
        return AuthWithGoogleModel(apiUserData: userData, userData: userModel);
      } on DioException catch (e) {
        throw DioHelper.handleDioError(
            dioError: e, endpointName: "sigInWithGoogle");
      }
    }
  }

  @override
  Future<Map<String, dynamic>> addPersonalInfo(
      PersonalInfoParams params) async {
    log('${MyApp.userId} zazaaza');
    FormData formData = FormData.fromMap({
      'UserId': MyApp.userId,
      'FirstName': params.firstName,
      'LastName': params.lastName,
    });

    try {
      final response = await Dio().post(
        ConstantApi.addPersonalInfo(),
        data: formData,
      );

      Map<String, dynamic> jsonData = response.data as Map<String, dynamic>;
      log('${jsonData['userProfileId']} zazaaza');
      Methods.instance.saveProfileId(profileId: jsonData['userProfileId']);
      MyApp.userProfileId= jsonData['userProfileId'];
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
        ConstantApi.sendUniversityFacultyIds(MyApp.userId, MyApp.userProfileId),
        data: body,
      );
      return response.data;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "sendUniversityFacultyIds");
    }
  }

  @override
  Future<dynamic> sendExperienceLevel(
      String typeID, String jobLevelId) async {

    final body = {
      'graduationStatusId': typeID,
      'jobLevelId': jobLevelId,
      'userId': MyApp.userId,
      'userProfileId': MyApp.userProfileId,
    };

    try {
      final response = await Dio().post(
        ConstantApi.sendUniversityFacultyIds(  MyApp.userId, MyApp.userProfileId),
        data: body,
      );
      return response.data;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "sendExperienceLevel");
    }
  }
  @override
  Future<dynamic> locationType(
      LocationTypeParams locationTypeParams) async {
    log('${locationTypeParams.cityID}');
    log('${locationTypeParams.countryID}');
    log('${ locationTypeParams.locationTypeID} locationTypeParams.locationTypeID');
    final body = {
      'jobLocationTypeId': locationTypeParams.locationTypeID,
      'userId': MyApp.userId,
      'userProfileId': MyApp.userProfileId,
      'cityId': locationTypeParams.cityID,
      'countryId': locationTypeParams.countryID,
    };

    try {
      final response = await Dio().post(
        ConstantApi.sendLocationTypeIds( MyApp.userId , MyApp.userProfileId ),

        data: body,
      );
      return response.data;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "locationType");
    }
  }
  @override
  Future<dynamic> majorOfFields(List<int> majorIds) async {
log('${majorIds} majorIds');
    final body = {
      'majorIds': majorIds,
      'userId': MyApp.userId,
      'userProfileId': MyApp.userProfileId,
    };

    try {
      final response = await Dio().post(
        ConstantApi.sendMajorIds( MyApp.userId , MyApp.userProfileId ),

        data: body,
      );
      return response.data;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "locationType");
    }
  }
}

class AuthWithGoogleModel {
  final GoogleSignInAccount userData;

  final MyDataModel apiUserData;

  AuthWithGoogleModel({required this.apiUserData, required this.userData});
}
