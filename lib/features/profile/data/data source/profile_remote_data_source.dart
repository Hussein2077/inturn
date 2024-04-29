import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:inturn/core/models/my_data_model.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/core/utils/constant_api.dart';
import 'package:inturn/core/models/vacancey_model.dart';

abstract class BaseRemotelyDataSourceProfile {
  Future<MyDataModel> getMyData(String id);

}

class ProfileRemotelyDateSource extends BaseRemotelyDataSourceProfile {
  @override
  Future<MyDataModel> getMyData(  String id) async {
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

}
