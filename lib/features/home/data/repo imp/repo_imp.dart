import 'package:dartz/dartz.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/home/data/data%20source/home_remote_data_source.dart';
import 'package:inturn/features/home/data/model/application_model.dart';
import 'package:inturn/features/home/data/model/area_model.dart';
import 'package:inturn/features/home/data/model/company_model.dart';
import 'package:inturn/features/home/data/model/major_model.dart';
import 'package:inturn/features/home/data/model/cities_model.dart';
import 'package:inturn/features/home/data/model/faculty_model.dart';
import 'package:inturn/features/home/data/model/matched_model.dart';
import 'package:inturn/features/home/data/model/skill_model.dart';
import 'package:inturn/features/home/data/model/university_model.dart';
import 'package:inturn/features/home/domain/repo/jobs_base_repo.dart';

class HomeRepositoryImp extends BaseRepositoryHome {
  final BaseRemotelyDataSourceHome baseRemotelyDataSourceHome;

  HomeRepositoryImp({required this.baseRemotelyDataSourceHome});

  @override
  Future<Either<List<MatchedVacancyWrapper>, Failure>> getMatchedJobs(String userId) async {
    try {
      final result = await baseRemotelyDataSourceHome.getMatchedJobs(userId);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<List<Country>, Failure>> getCities() async {
    try {
      final result = await baseRemotelyDataSourceHome.getCities();
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<List<FacultyModel>, Failure>> getFaculty(int id) async {
    try {
      final result = await baseRemotelyDataSourceHome.getFaculty(  id);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }  @override
  Future<Either<List<AreaModel>, Failure>> getAreas(int cityId) async {
    try {
      final result = await baseRemotelyDataSourceHome.getAreas(  cityId);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<List<UniversityModel>, Failure>> getUniversity() async {
    try {
      final result = await baseRemotelyDataSourceHome.getUniversity();
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }
  @override
  Future<Either<List<MajorModel>, Failure>> getMajor() async {
    try {
      final result = await baseRemotelyDataSourceHome.getMajor();
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }  @override
  Future<Either<List<SkillModel>, Failure>> getSkill() async {
    try {
      final result = await baseRemotelyDataSourceHome.getSkill();
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<List<VacancyModel>, Failure>> getJobDetails(int id) async {
    try {
      final result = await baseRemotelyDataSourceHome.getJobDetails(id);
      return Left(result);
    }
    on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }
  @override
  Future<Either<List<ApplicationModel>, Failure>> getMyApplications(String userId) async {
    try {
      final result = await baseRemotelyDataSourceHome.getMyApplications(userId );
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }  @override
  Future<Either<List<CompanyModel>, Failure>> getCompanies() async {
    try {
      final result = await baseRemotelyDataSourceHome.getCompanies();
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }
  @override

  Future<Either<dynamic, Failure>> apply(VacancyApply vacancyApply) async {
    try {
      final result = await baseRemotelyDataSourceHome.apply(vacancyApply);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }
  @override
  Future<Either<List<MatchedVacancyWrapper>, Failure>> getInternshipsBySearch(VacancySearch vacancySearch) async {
    try {
      final result = await baseRemotelyDataSourceHome.getInternshipsBySearch(vacancySearch);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }
}
