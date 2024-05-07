import 'package:dartz/dartz.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/features/home/domain/repo/jobs_base_repo.dart';

import '../../../../core/error/failure.dart';

class ApplyUseCase extends BaseUseCase<dynamic,VacancyApply>{
  final BaseRepositoryHome baseRepositoryJobs;

  ApplyUseCase({required this.baseRepositoryJobs});

  @override
  Future<Either<dynamic, Failure>> call(VacancyApply parameter) async {
    final result = await baseRepositoryJobs.apply(parameter);

    return result;
  }
}
