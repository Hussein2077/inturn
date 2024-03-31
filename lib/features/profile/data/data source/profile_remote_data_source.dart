import 'package:dio/dio.dart';
import 'package:inturn/core/models/my_data_model.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/core/utils/constant_api.dart';
import 'package:inturn/core/models/vacancey_model.dart';

abstract class BaseRemotelyDataSourceProfile {
  Future<MyDataModel> getMyData();
  Future<List<VacancyModel>> getMyApplications(String type);

}

class ProfileRemotelyDateSource extends BaseRemotelyDataSourceProfile {
  @override
  Future<MyDataModel> getMyData() async {
    try {
      final response = await Dio().get(
        ConstantApi.myData,
      );
      MyDataModel jsonData = response.data;
      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "get my data");
    }
  }
  @override
  Future<List<VacancyModel>> getMyApplications(String type) async {
    try {
      final response = await Dio().get(
        ConstantApi.myApplications,
      );
      List<VacancyModel> jsonData = List<VacancyModel>.from(
          (response.data as List)
              .map((e) => VacancyModel.fromJson(e)));
      return jsonData;
    } on DioException catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "getMyApplications");
    }
  }
}
