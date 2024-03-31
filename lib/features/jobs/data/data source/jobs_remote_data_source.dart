import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:inturn/core/models/my_data_model.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/core/utils/constant_api.dart';
import 'package:inturn/core/models/vacancey_model.dart';

abstract class BaseRemotelyDataSourceJobs {
  Future<List<VacancyModel>> getJobs(VacancySearch vacancySearch);
  Future<dynamic> apply(VacancyApply vacancyApply);
}

class JobsRemotelyDateSource extends BaseRemotelyDataSourceJobs {
  @override
  Future<List<VacancyModel>> getJobs(VacancySearch vacancySearch) async {
    final body = {
      'text': vacancySearch.text,
      'skill': vacancySearch.skill,
      'area': vacancySearch.area,
    };
    try {

      final response = vacancySearch.type==1? await Dio().get(
        ConstantApi.getJobs,
      ): await Dio().get(
        ConstantApi.getJobs,
        data: body,
      );

      List<VacancyModel> jsonData = List<VacancyModel>.from(
          (response.data as List)
              .map((e) => VacancyModel.fromJson(e)));
      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "getJobs");
    }
  }

  @override
  Future apply(VacancyApply vacancyApply) async{
    final body = {
      'jobid ': vacancyApply.vacancyID,
      'id ': vacancyApply.userID,
    };
    try {

      final response =  await Dio().post(
        ConstantApi.apply,
        data: body
      );
   dynamic jsonData = response.data;
    return jsonData;
    } on DioException catch (e) {
    throw DioHelper.handleDioError(dioError: e, endpointName: "getJobs");
    }
  }
}
