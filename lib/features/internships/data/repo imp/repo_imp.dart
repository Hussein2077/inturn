import 'package:dartz/dartz.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/internships/data/data%20source/internships_remote_data_source.dart';

import 'package:inturn/features/internships/domain/repo/jobs_base_repo.dart';
import 'package:inturn/features/jobs/data/data%20source/jobs_remote_data_source.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/features/jobs/domain/repo/jobs_base_repo.dart';

class InternshipsRepositoryImp extends BaseRepositoryInternships {
  final BaseRemotelyDataSourceInternships baseRemotelyDataSourceInternships;

  InternshipsRepositoryImp({required this.baseRemotelyDataSourceInternships});

  @override
  Future<Either<List<VacancyModel>, Failure>> getInternships() async {
    try {
      final result = await baseRemotelyDataSourceInternships.getInternships();
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }
  @override
  Future<Either<List<VacancyModel>, Failure>> getInternshipsBySearch(VacancySearch vacancySearch) async {
    try {
      final result = await baseRemotelyDataSourceInternships.getInternshipsBySearch(vacancySearch);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }
}
