import 'package:dartz/dartz.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/features/home/data/model/application_model.dart';
import 'package:inturn/features/home/data/model/area_model.dart';
import 'package:inturn/features/home/data/model/company_model.dart';
import 'package:inturn/features/home/data/model/major_model.dart';
import 'package:inturn/features/home/data/model/cities_model.dart';
import 'package:inturn/features/home/data/model/intern_model.dart';
import 'package:inturn/features/home/data/model/faculty_model.dart';
import 'package:inturn/features/home/data/model/matched_model.dart';
import 'package:inturn/features/home/data/model/skill_model.dart';
import 'package:inturn/features/home/data/model/university_model.dart';

abstract class BaseRepositoryHome {
  Future<Either<List<MatchedVacancyWrapper>, Failure>> getMatchedJobs(String userId);

  Future<Either<List<VacancyModel>, Failure>> getJobDetails(int id);

  Future<Either<List<Country>, Failure>> getCities();

  Future<Either<List<FacultyModel>, Failure>> getFaculty(int id);
  Future<Either<List<AreaModel>, Failure>> getAreas (int cityId );

  Future<Either<List<UniversityModel>, Failure>> getUniversity();

  Future<Either<List<MajorModel>, Failure>> getMajor();

  Future<Either<List<SkillModel>, Failure>> getSkill();

  Future<Either<List<ApplicationModel>, Failure>> getMyApplications(String userId);

  Future<Either<List<CompanyModel>, Failure>> getCompanies();
  Future<Either<List<VacancyModel>, Failure>> getInternshipsBySearch(VacancySearch vacancySearch);


  Future<Either<dynamic, Failure>> apply(VacancyApply vacancyApply);
}
