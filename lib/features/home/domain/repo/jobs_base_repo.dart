import 'package:dartz/dartz.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/features/home/data/model/major_model.dart';
import 'package:inturn/features/home/data/model/cities_model.dart';
import 'package:inturn/features/home/data/model/intern_model.dart';
import 'package:inturn/features/home/data/model/faculty_model.dart';
import 'package:inturn/features/home/data/model/university_model.dart';

abstract class BaseRepositoryHome {
  Future<Either<List<VacancyModel>, Failure>> getTopFive(int type);
  Future<Either<List<Country>, Failure>> getCities();
  Future<Either<List<FacultyModel>, Failure>> getFaculty(int id);
  Future<Either<List<UniversityModel>, Failure>> getUniversity();
  Future<Either<List<MajorModel>, Failure>> getMajor();
}
