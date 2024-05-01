import 'package:dartz/dartz.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/core/models/profile_data_model.dart';
import 'package:inturn/features/profile/domain/repo/profile_base_repo.dart';

class GetMyProfileDataUseCase  extends BaseUseCase<ProfileDataModel, String> {
  final BaseRepositoryProfile baseRepositoryProfile;

  GetMyProfileDataUseCase({required this.baseRepositoryProfile});

  @override
  Future<Either<ProfileDataModel, Failure>> call(String parameter) async {
    final result = await baseRepositoryProfile.getMyProfileData( parameter);
    return result;
  }
}
