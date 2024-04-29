import 'package:dartz/dartz.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/core/models/my_data_model.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/features/profile/domain/use_case/edit_profile_uc.dart';

abstract class BaseRepositoryProfile {
  Future<Either<MyDataModel, Failure>> getMyData( String id);
  Future<Either<String, Failure>> editProfileData(EditPersonalInfoParams parameter);
}
