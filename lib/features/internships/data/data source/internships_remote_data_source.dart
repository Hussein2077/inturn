import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:inturn/core/models/my_data_model.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/core/utils/constant_api.dart';

import 'package:inturn/core/models/vacancey_model.dart';

abstract class BaseRemotelyDataSourceInternships {
  Future<List<VacancyModel>> getInternships();

  Future<List<VacancyModel>> getInternshipsBySearch(
      VacancySearch vacancySearch);
}

class InternshipsRemotelyDateSource extends BaseRemotelyDataSourceInternships {
  @override
  Future<List<VacancyModel>> getInternships() async {
    Options options = await DioHelper().options();

    try {
      final response = await Dio().get(
        ConstantApi.getGetInternships,
        options: options,
      );
      List<VacancyModel>    jsonData = List<VacancyModel>.from(
          (response.data as List).map((e) => VacancyModel.fromJson(e)));
      log('$jsonData dddddddddd');
      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "get Internships");
    }
  }

  @override
  Future<List<VacancyModel>> getInternshipsBySearch(
      VacancySearch vacancySearch) async {
    Options options = await DioHelper().options();

    final body = {
      'text': vacancySearch.text,
      'skill': vacancySearch.skill,
      'area': vacancySearch.area,
    };
    try {
      final response = vacancySearch.type == 1
          ? await Dio().get(ConstantApi.getGetInternships,
              //1 =  normal
              // 2 with search
              options: options)
          : await Dio().get(ConstantApi.getGetInternshipsBySearch,
              data: body,
              //1 =  normal
              // 2 with search
              options: options);
      List<VacancyModel> jsonData = List<VacancyModel>.from(
          (response.data as List).map((e) => VacancyModel.fromJson(e)));
      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "get Internships by search");
    }
  }
}
