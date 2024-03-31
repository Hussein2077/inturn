import 'package:dartz/dartz.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/core/models/vacancey_model.dart';

abstract class BaseRepositoryJobs {
  Future<Either<List<VacancyModel>, Failure>> getJobs(VacancySearch vacancySearch);
  Future<Either<dynamic, Failure>> apply(VacancyApply vacancyApply);
}
