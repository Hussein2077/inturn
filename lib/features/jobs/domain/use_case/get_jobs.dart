import 'package:dartz/dartz.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/features/jobs/domain/repo/jobs_base_repo.dart';

class GetJobsUseCase extends BaseUseCase<List<VacancyModel>,VacancySearch>{
  final BaseRepositoryJobs baseRepositoryJobs;

  GetJobsUseCase({required this.baseRepositoryJobs});

  @override
  Future<Either<List<VacancyModel>, Failure>> call(VacancySearch parameter) async {
    final result = await baseRepositoryJobs.getJobs(parameter);

    return result;
  }
}
