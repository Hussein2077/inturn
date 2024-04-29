import 'package:dartz/dartz.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/core/models/my_data_model.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/features/profile/data/data%20source/profile_remote_data_source.dart';
import 'package:inturn/features/profile/domain/repo/profile_base_repo.dart';

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

}
