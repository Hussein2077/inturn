import 'package:dartz/dartz.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/core/models/my_data_model.dart';
import 'package:inturn/features/profile/domain/repo/profile_base_repo.dart';

class GetMyDataUseCase  extends BaseUseCase<MyDataModel, String> {
  final BaseRepositoryProfile baseRepositoryProfile;

  GetMyDataUseCase({required this.baseRepositoryProfile});

  @override
  Future<Either<MyDataModel, Failure>> call(String parameter) async {
    final result = await baseRepositoryProfile.getMyData( parameter);

    return result;
  }
}
class CompleteProfileUseCase  extends BaseUseCase<MyDataModel, String> {
  final BaseRepositoryProfile baseRepositoryProfile;

  CompleteProfileUseCase({required this.baseRepositoryProfile});

  @override
  Future<Either<MyDataModel, Failure>> call(String parameter) async {
    final result = await baseRepositoryProfile.completeProfile( parameter);

    return result;
  }
}
