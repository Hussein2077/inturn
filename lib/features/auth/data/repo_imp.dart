import 'package:dartz/dartz.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/core/models/my_data_model.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/auth/data/auth_remote_data_source.dart';
import 'package:inturn/features/auth/domain/repo/base_repo.dart';
import 'package:inturn/features/auth/domain/use_case/add_info_uc.dart';
import 'package:inturn/features/auth/domain/use_case/login_with_email_and_password_use_case.dart';
import 'package:inturn/features/auth/domain/use_case/sign_up_use_case.dart';

class RepositoryImp extends BaseRepository {
  final BaseRemotelyDataSource baseRemotelyDataSource;

  RepositoryImp({required this.baseRemotelyDataSource});
  @override
  Future<Either<AuthWithGoogleModel, Failure>> signWithGoogle() async {
    try {
      final result = await baseRemotelyDataSource.sigInWithGoogle();
      return Left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }
  @override
  Future<Either<Map<String, dynamic>, Failure>> loginWithEmailAndPassword(AuthModel authModel) async {
    try {
      final result =
          await baseRemotelyDataSource.loginWithEmailAndPassword(authModel);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<Map<String, dynamic>, Failure>> signUpWithEmailAndPassword(SignUpModel signUpModel) async{
    try {
      final result =
          await baseRemotelyDataSource.signUpWithEmailAndPassword(signUpModel);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<Map<String, dynamic>, Failure>> changePassword(SignUpModel signUpModel) async{
    try {
      final result =
      await baseRemotelyDataSource.changePassword(signUpModel);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<Map<String , dynamic>, Failure>> addPersonalInfo(PersonalInfoParams params) async {
    try {
      final result = await baseRemotelyDataSource.addPersonalInfo(params);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }
  @override
  Future<Either<Map<String, dynamic>, Failure>> sendCode(SignUpModel signUpModel)async{
    try {
      final result =
      await baseRemotelyDataSource.sendCode(signUpModel);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<Map<String, dynamic>, Failure>> verifyCode(SignUpModel signUpModel) async{
    try {
      final result =
      await baseRemotelyDataSource.verifyCode(signUpModel);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<Map<String, dynamic>, Failure>> sendUniversityFacultyIds(String universityId, String facultyId) async {
    try {
      final result = await baseRemotelyDataSource.sendUniversityFacultyIds(universityId, facultyId);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }  @override
  Future<Either<Map<String, dynamic>, Failure>> sendExperienceLevel(String typeID, String jobLevelId) async {
    try {
      final result = await baseRemotelyDataSource.sendExperienceLevel(typeID, jobLevelId);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }
}
