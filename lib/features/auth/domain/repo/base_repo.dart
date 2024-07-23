  import 'package:dartz/dartz.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/core/models/my_data_model.dart';
import 'package:inturn/features/auth/data/auth_remote_data_source.dart';
import 'package:inturn/features/auth/domain/use_case/add_info_uc.dart';
import 'package:inturn/features/auth/domain/use_case/login_with_email_and_password_use_case.dart';
import 'package:inturn/features/auth/domain/use_case/sign_up_use_case.dart';

abstract class BaseRepository {
  Future<Either<Map<String, dynamic>, Failure>> loginWithEmailAndPassword(
      AuthModel authModel);
  Future<Either<Map<String, dynamic>, Failure>> signUpWithEmailAndPassword(
      SignUpModel signUpModel);
  Future<Either<Map<String, dynamic>, Failure>> resetPassword(
      SignUpModel signUpModel);
  Future<Either<String, Failure>> sendCode(
      SignUpModel signUpModel);
  Future<Either<String, Failure>> sendCodeForForgot(
      SignUpModel signUpModel);
  Future<Either<Map<String, dynamic>, Failure>> verifyCode(
      SignUpModel signUpModel);
  Future<Either< dynamic, Failure>> verifyCodeSignUp(
      SignUpModel signUpModel);

  Future<Either<Map<String, dynamic>, Failure>> addPersonalInfo(PersonalInfoParams params);
  Future<Either<dynamic, Failure>> sendUniversityFacultyIds( SendUniversityFacultyIdsParams universityFacultyIdsParams);
  Future<Either<dynamic, Failure>> sendExperienceLevel(String typeID, String jobLevelId);
  Future<Either<dynamic, Failure>> locationType(LocationTypeParams locationTypeParams);
  Future<Either<dynamic, Failure>> majorOfFields(List<int> majorIds);
  Future<Either<dynamic, Failure>> sendSkills(List<int> skillIds);
  Future<Either<String, Failure>> deleteAccount ( );
}
