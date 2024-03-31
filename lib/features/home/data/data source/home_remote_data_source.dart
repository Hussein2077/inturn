import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/core/utils/constant_api.dart';
import 'package:inturn/features/home/data/model/blog_model.dart';
import 'package:inturn/features/home/data/model/cities_model.dart';
import 'package:inturn/features/home/data/model/major_model.dart';
import 'package:inturn/features/home/data/model/university_model.dart';

abstract class BaseRemotelyDataSourceHome{
  Future<List<VacancyModel>> getTopFive(int type);
  Future<List<CitiesModel>> getCities();
  Future<List<MajorModel>> getMajor();
  Future<List<UniversityModel>> getUniversity();
  Future<List<BlogModel>> getBlogs();
}

class HomeRemotelyDateSource extends BaseRemotelyDataSourceHome {
  @override
  Future<List<VacancyModel>> getTopFive(int type) async {
    try {
      final response = await Dio().get(
        ConstantApi.myData,
      );
      List<VacancyModel> jsonData = List<VacancyModel>.from(
          (response.data as List).map((e) => VacancyModel.fromJson(e)));
      return jsonData;

    } on DioException catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "get Internships");
    }
  }
  @override
  Future<List<CitiesModel>> getCities() async {
    try {
      final response = await Dio().get(
        ConstantApi.provinces,
      );
      List<CitiesModel> jsonData = List<CitiesModel>.from(
          (response.data as List).map((e) => CitiesModel.fromJson(e)));
      return jsonData;

    } on DioException catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "get getCities");
    }
  }
  @override
  Future<List<MajorModel>> getMajor() async {
    try {
      final response = await Dio().get(
        ConstantApi.majors,
      );
      List<MajorModel> jsonData = List<MajorModel>.from(
          (response.data as List).map((e) => MajorModel.fromJson(e)));
      return jsonData;

    } on DioException catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "getMajor");
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
      log('${jsonData}ssssssssssssssssss');

      return jsonData;

    } on DioException catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "getUniversity");
    }
  }
  @override
  Future<List<BlogModel>> getBlogs() async {
    try {
      final response = await Dio().get(
        ConstantApi.blogs,
      );
      List<BlogModel> jsonData = List<BlogModel>.from(
          (response.data as List).map((e) => BlogModel.fromJson(e)));
      return jsonData;

    } on DioException catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "getUniversity");
    }
  }
}
