import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/features/profile/domain/repo/profile_base_repo.dart';

class UploadPDFUseCase extends BaseUseCase<String, File> {
  BaseRepositoryProfile baseRepositoryProfile;
  UploadPDFUseCase({required this.baseRepositoryProfile});

  @override
  Future<Either<String, Failure>> call(File parameter) async {
    final result = await baseRepositoryProfile.uploadPdf(parameter);
    return result;
  }
}
