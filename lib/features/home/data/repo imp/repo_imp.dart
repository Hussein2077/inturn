import 'package:dartz/dartz.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/home/data/data%20source/home_remote_data_source.dart';
import 'package:inturn/features/home/data/model/blog_model.dart';
import 'package:inturn/features/home/data/model/cities_model.dart';
import 'package:inturn/features/home/data/model/intern_model.dart';
import 'package:inturn/features/home/data/model/major_model.dart';
import 'package:inturn/features/home/data/model/university_model.dart';
import 'package:inturn/features/home/domain/repo/jobs_base_repo.dart';

class HomeRepositoryImp extends BaseRepositoryHome {
  final BaseRemotelyDataSourceHome baseRemotelyDataSourceHome;

  HomeRepositoryImp({required this.baseRemotelyDataSourceHome});

  @override
  Future<Either<List<VacancyModel>, Failure>> getTopFive(int type) async {
    try {
      final result = await baseRemotelyDataSourceHome.getTopFive(type);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<List<CitiesModel>, Failure>> getCities() async {
    try {
      final result = await baseRemotelyDataSourceHome.getCities();
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
  Future<Either<List<BlogModel>, Failure>> getBlogs() async {
    try {
      final result = await baseRemotelyDataSourceHome.getBlogs();
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }
}
