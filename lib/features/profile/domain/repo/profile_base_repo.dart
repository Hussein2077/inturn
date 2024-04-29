import 'package:dartz/dartz.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/core/models/my_data_model.dart';
import 'package:inturn/core/models/vacancey_model.dart';

abstract class BaseRepositoryProfile {
  Future<Either<MyDataModel, Failure>> getMyData( String id);
}
