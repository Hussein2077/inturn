import 'package:dartz/dartz.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/features/profile/domain/repo/profile_base_repo.dart';

class ChangePasswordUseCase extends BaseUseCase<String, ChangePasswordModel> {
  BaseRepositoryProfile baseRepository;

  ChangePasswordUseCase({required this.baseRepository});

  @override
  Future<Either<String, Failure>> call(ChangePasswordModel parameter) async {
    final result = await baseRepository.changePassword(parameter);

    return result;
  }
}


class ChangePasswordModel {
  final String? id;
  final String? oldPassword;
  final String? newPassword;

  const ChangePasswordModel({
    this.id,
    this.oldPassword,
    this.newPassword,
  });
}