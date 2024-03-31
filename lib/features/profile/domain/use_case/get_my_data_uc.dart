import 'package:dartz/dartz.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/core/models/my_data_model.dart';
import 'package:inturn/features/profile/domain/repo/profile_base_repo.dart';

class GetMyDataUseCase {
  final BaseRepositoryProfile baseRepositoryProfile;

  GetMyDataUseCase({required this.baseRepositoryProfile});

  Future<Either<MyDataModel, Failure>> getMyData() async {
    final result = await baseRepositoryProfile.getMyData();

    return result;
  }
}
