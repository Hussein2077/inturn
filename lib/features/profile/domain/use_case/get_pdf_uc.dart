import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/features/profile/domain/repo/profile_base_repo.dart';

class GetPDFUseCase extends BaseUseCase<String, NoParameter> {
  BaseRepositoryProfile baseRepositoryProfile;
  GetPDFUseCase({required this.baseRepositoryProfile});

  @override
  Future<Either<String, Failure>> call(   NoParameter parameter) async {
    final result = await baseRepositoryProfile.getPdf();
    return result;
  }
}
