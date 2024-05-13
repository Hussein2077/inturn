import 'package:dartz/dartz.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/features/home/data/model/intern_model.dart';
import 'package:inturn/features/home/data/model/matched_model.dart';
import 'package:inturn/features/home/domain/repo/jobs_base_repo.dart';

class GetMatchedJobsCase extends BaseUseCase<List<MatchedVacancyWrapper>, String> {
  final BaseRepositoryHome baseRepositoryHome;

  GetMatchedJobsCase({required this.baseRepositoryHome});

  @override
  Future<Either<List<MatchedVacancyWrapper>, Failure>> call( String parameter) async {
    final result = await baseRepositoryHome.getMatchedJobs(parameter);

    return result;
  }
}
