import 'package:dartz/dartz.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/core/models/vacancey_model.dart';


abstract class BaseRepositoryInternships {
  Future<Either<List<VacancyModel>, Failure>> getInternships();
  Future<Either<List<VacancyModel>, Failure>> getInternshipsBySearch(VacancySearch vacancySearch);
}
