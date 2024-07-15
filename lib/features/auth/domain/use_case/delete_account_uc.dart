import 'package:dartz/dartz.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/features/auth/domain/repo/base_repo.dart';

class DeleteAccountUseCase {
  BaseRepository baseRepository;

  DeleteAccountUseCase({required this.baseRepository});

  Future<Either<String, Failure>> deleteAccount() async {
    final result = await baseRepository.deleteAccount();

    return result;
  }
}
