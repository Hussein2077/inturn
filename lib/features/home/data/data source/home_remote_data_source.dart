import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/core/utils/constant_api.dart';
import 'package:inturn/features/home/data/model/application_model.dart';
import 'package:inturn/features/home/data/model/area_model.dart';
import 'package:inturn/features/home/data/model/company_model.dart';
import 'package:inturn/features/home/data/model/major_model.dart';
import 'package:inturn/features/home/data/model/cities_model.dart';
import 'package:inturn/features/home/data/model/faculty_model.dart';
import 'package:inturn/features/home/data/model/matched_model.dart';
import 'package:inturn/features/home/data/model/skill_model.dart';
import 'package:inturn/features/home/data/model/university_model.dart';
import 'package:inturn/main.dart';

abstract class BaseRemotelyDataSourceHome {
  Future<List<MatchedVacancyWrapper>> getMatchedJobs(String userId);

  Future<List<VacancyModel>> getJobDetails(int id);

  Future<List<Country>> getCities();
  Future<List<AreaModel>> getAreas(int cityId);

  Future<List<FacultyModel>> getFaculty(int id);

  Future<List<UniversityModel>> getUniversity();

  Future<List<MajorModel>> getMajor();

  Future<List<SkillModel>> getSkill();

  Future<List<ApplicationModel>> getMyApplications(String userId);

  Future<List<CompanyModel>> getCompanies();

  Future<dynamic> apply(VacancyApply vacancyApply);

  Future<List<VacancyModel>> getInternshipsBySearch(
      VacancySearch vacancySearch);
}

class HomeRemotelyDateSource extends BaseRemotelyDataSourceHome {
  @override
  Future<List<MatchedVacancyWrapper>> getMatchedJobs(String userId) async {
    try {
      final response = await Dio().get(
        ConstantApi.getVacancy(userId),
      );
      List<MatchedVacancyWrapper> jsonData = List<MatchedVacancyWrapper>.from(
          (response.data as List)
              .map((e) => MatchedVacancyWrapper.fromJson(e)));
      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "getMatchedJobs");
    }
  }

  @override
  Future<List<VacancyModel>> getJobDetails(int id) async {
    try {
      final response = await Dio().get(
        ConstantApi.vacancyDetails(id),
      );
      List<VacancyModel> jsonData = List<VacancyModel>.from(
          (response.data as List).map((e) => VacancyModel.fromJson(e)));
      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "getJobDetails");
    }
  }

  @override
  Future<List<Country>> getCities() async {
    try {
      final response = await Dio().get(
        ConstantApi.provinces,
      );
      List<Country> jsonData = List<Country>.from(
          (response.data as List).map((e) => Country.fromJson(e)));

      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "get getCities");
    }
  }

  @override
  Future<List<FacultyModel>> getFaculty(int id) async {
    try {
      final response = await Dio().get(
        ConstantApi.faculty(id),
      );
      List<FacultyModel> jsonData = List<FacultyModel>.from(
          (response.data as List).map((e) => FacultyModel.fromJson(e)));
      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "getFaculty");
    }
  }  @override
  Future<List<AreaModel>> getAreas(int cityId) async {
    try {
      final response = await Dio().get(
        ConstantApi.getAreas(cityId),
      );
      List<AreaModel> jsonData = List<AreaModel>.from(
          (response.data as List).map((e) => AreaModel.fromJson(e)));
      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "getAreas");
    }
  }

  @override
  Future<List<UniversityModel>> getUniversity() async {
    try {
      final response = await Dio().get(
        ConstantApi.universities,
      );
      List<UniversityModel> jsonData = List<UniversityModel>.from(
          (response.data as List).map((e) => UniversityModel.fromJson(e)));

      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "getUniversity");
    }
  }

  @override
  Future<List<MajorModel>> getMajor() async {
    try {
      final response = await Dio().get(
        ConstantApi.getMajorsByCategory,
      );
      List<MajorModel> jsonData = List<MajorModel>.from(
          (response.data as List).map((e) => MajorModel.fromJson(e)));
      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "getMajor");
    }
  }

  @override
  Future<List<SkillModel>> getSkill() async {
    try {
      final response = await Dio().get(
        ConstantApi.getSkill,
      );
      List<SkillModel> jsonData = List<SkillModel>.from(
          (response.data as List).map((e) => SkillModel.fromJson(e)));
      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "getSkill");
    }
  }

  @override
  Future<List<ApplicationModel>> getMyApplications(String userId ) async {
    try {
      final response = await Dio().get(
        ConstantApi.myApplications(userId),
      );
      List<ApplicationModel> jsonData = List<ApplicationModel>.from(
          (response.data as List).map((e) => ApplicationModel.fromJson(e)));
      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "getMyApplications");
    }
  }

  @override
  Future<List<CompanyModel>> getCompanies() async {
    try {
      final response = await Dio().get(
        ConstantApi.getCompanies,
      );
      List<CompanyModel> jsonData = List<CompanyModel>.from(
          (response.data as List).map((e) => CompanyModel.fromJson(e)));
      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "getCompanies");
    }
  }

  @override
  Future apply(VacancyApply vacancyApply) async {
    log('${vacancyApply.userID}ehehhet ${vacancyApply.vacancyID}');
    final body = {
      // 'vacancyId ': vacancyApply.vacancyID,
      // 'userId ': vacancyApply.userID,
    };
    try {
      final response = await Dio().post(
          ConstantApi.apply(vacancyApply.userID, vacancyApply.vacancyID),
          data: body);
      dynamic jsonData = response.data;
      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "apply");
    }
  }

  @override
  Future<List<VacancyModel>> getInternshipsBySearch(
      VacancySearch vacancySearch) async {
    log('${vacancySearch.vacancyWorkPlace}slfbnlbnwlnw');
    log('${vacancySearch.countryId}ehehhet\n ${vacancySearch.cityId}\n${vacancySearch.vacancyLevelId}\n${vacancySearch.companyId}\n${vacancySearch.title}\n${vacancySearch.userId}');
    final body = {
      'cityId': vacancySearch.cityId,
      'countryId': vacancySearch.countryId,
      'vacancyLevelId': vacancySearch.vacancyLevelId,
      'vacancyWorkPlace': vacancySearch.vacancyWorkPlace??0,
      'companyId': vacancySearch.companyId,
      'title': vacancySearch.title,
      'userId': vacancySearch.userId,
    };
    try {
      final response = await Dio().post(
        ConstantApi.getGetInternshipsBySearch,
        data: body,
      );
      List<VacancyModel> jsonData = List<VacancyModel>.from(
          (response.data as List).map((e) => VacancyModel.fromJson(e)));

      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "get Internships by search");
    }
  }

}
