import 'package:dartz/dartz.dart';
import 'package:inturn/core/error/failure.dart';

import 'package:inturn/features/internships/domain/repo/jobs_base_repo.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/features/jobs/domain/repo/jobs_base_repo.dart';

class GetInternshipsUseCase {
  final BaseRepositoryInternships baseRepositoryInternships;

  GetInternshipsUseCase({required this.baseRepositoryInternships});

  Future<Either<List<VacancyModel>, Failure>> getInternships() async {
    final result = await baseRepositoryInternships.getInternships();

    return result;
  }
}
