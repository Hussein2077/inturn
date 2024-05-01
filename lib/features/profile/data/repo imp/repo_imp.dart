import 'package:dartz/dartz.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/core/models/my_data_model.dart';
import 'package:inturn/core/models/profile_data_model.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/features/profile/data/data%20source/profile_remote_data_source.dart';
import 'package:inturn/features/profile/domain/repo/profile_base_repo.dart';
import 'package:inturn/features/profile/domain/use_case/edit_profile_uc.dart';

class ProfileRepositoryImp extends BaseRepositoryProfile {
  final BaseRemotelyDataSourceProfile baseRemotelyDataSourceProfile;

  ProfileRepositoryImp({required this.baseRemotelyDataSourceProfile});

  @override
  Future<Either<MyDataModel, Failure>> getMyData( String id) async {
    try {
      final result = await baseRemotelyDataSourceProfile.getMyData(id);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> editProfileData(EditPersonalInfoParams parameter) async {
    try {
      final result = await baseRemotelyDataSourceProfile.editProfileData(parameter);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<ProfileDataModel, Failure>> getMyProfileData( String id) async {
    try {
      final result = await baseRemotelyDataSourceProfile.getMyProfileData(id);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

}
