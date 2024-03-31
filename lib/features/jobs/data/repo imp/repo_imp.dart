import 'package:dartz/dartz.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/jobs/data/data%20source/jobs_remote_data_source.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/features/jobs/domain/repo/jobs_base_repo.dart';

class JobsRepositoryImp extends BaseRepositoryJobs {
  final BaseRemotelyDataSourceJobs baseRemotelyDataSourceJobs;

  JobsRepositoryImp({required this.baseRemotelyDataSourceJobs});

  @override
  Future<Either<List<VacancyModel>, Failure>> getJobs(VacancySearch vacancySearch) async {
    try {
      final result = await baseRemotelyDataSourceJobs.getJobs(vacancySearch);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }
  @override

  Future<Either<dynamic, Failure>> apply(VacancyApply vacancyApply) async {
    try {
      final result = await baseRemotelyDataSourceJobs.apply(vacancyApply);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }
}
