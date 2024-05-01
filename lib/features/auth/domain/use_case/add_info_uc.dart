import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/features/auth/domain/repo/base_repo.dart';
import 'package:inturn/features/auth/domain/use_case/login_with_email_and_password_use_case.dart';

class AddPersonalInfoUseCase
    extends BaseUseCase<Map<String, dynamic>, PersonalInfoParams> {
  BaseRepository baseRepository;

  AddPersonalInfoUseCase({required this.baseRepository});

  @override
  Future<Either<Map<String, dynamic>, Failure>> call(
      PersonalInfoParams parameter) async {
    final result = await baseRepository.addPersonalInfo(parameter);
    return result;
  }
}

class SendUniversityFacultyIdsUseCase
    extends BaseUseCase<dynamic, SendUniversityFacultyIdsParams> {
  BaseRepository baseRepository;

  SendUniversityFacultyIdsUseCase({required this.baseRepository});

  @override
  Future<Either<dynamic, Failure>> call(
      SendUniversityFacultyIdsParams params) async {
    final result = await baseRepository.sendUniversityFacultyIds(
        params.universityId, params.facultyId);
    return result;
  }
}

class SendExperienceLevelUseCase
    extends BaseUseCase<dynamic, SendExperienceLevelParams> {
  BaseRepository baseRepository;

  SendExperienceLevelUseCase({required this.baseRepository});

  @override
  Future<Either<dynamic, Failure>> call(
      SendExperienceLevelParams parameter) async {
    final result = await baseRepository.sendExperienceLevel(
        parameter.typeID, parameter.jobLevelId);
    return result;
  }
}

class SendLocationTypeUseCase extends BaseUseCase<dynamic, LocationTypeParams> {
  BaseRepository baseRepository;

  SendLocationTypeUseCase({required this.baseRepository});

  @override
  Future<Either<dynamic, Failure>> call(LocationTypeParams parameter) async {
    final result = await baseRepository.locationType(parameter);
    return result;
  }
}
class SendMajorIDUseCase extends BaseUseCase<dynamic, List<int>> {
  BaseRepository baseRepository;

  SendMajorIDUseCase({required this.baseRepository});

  @override
  Future<Either<dynamic, Failure>> call(  List<int> parameter) async {
    final result = await baseRepository.majorOfFields( parameter);
    return result;
  }
}class SendSkillsIDUseCase extends BaseUseCase<dynamic, List<int>> {
  BaseRepository baseRepository;

  SendSkillsIDUseCase({required this.baseRepository});

  @override
  Future<Either<dynamic, Failure>> call(  List<int> parameter) async {
    final result = await baseRepository.sendSkills( parameter);
    return result;
  }
}

class SendUniversityFacultyIdsParams {
  final String universityId;
  final String facultyId;

  SendUniversityFacultyIdsParams(
      {required this.universityId, required this.facultyId});
}

class SendExperienceLevelParams {
  final String typeID;
  final String jobLevelId;

  SendExperienceLevelParams({required this.typeID, required this.jobLevelId});
}

class LocationTypeParams {
  final String countryID;
  final String cityID;
  final String locationTypeID;

  LocationTypeParams(
      {required this.cityID,
      required this.countryID,
      required this.locationTypeID});
}

class PersonalInfoParams {
  final File image;
  final String firstName;
  final String lastName;

  PersonalInfoParams(
      {required this.image, required this.firstName, required this.lastName});
}
