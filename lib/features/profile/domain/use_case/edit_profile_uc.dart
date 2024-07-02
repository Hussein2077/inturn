import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/features/profile/domain/repo/profile_base_repo.dart';

class EditPersonalInfoUseCase
    extends BaseUseCase<String, EditPersonalInfoParams> {
  BaseRepositoryProfile baseRepositoryProfile;

  EditPersonalInfoUseCase({required this.baseRepositoryProfile});

  @override
  Future<Either<String, Failure>> call(EditPersonalInfoParams parameter) async {
    final result = await baseRepositoryProfile.editProfileData(parameter);
    return result;
  }
}

class EditPersonalInfoParams {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? universityId;
  final String? facultyId;
  final String? description;
  final String? jobLevelId;
  final String? graduationStatusId;
  final String? jobLocationTypeId;
  final List<int>? majorIds;
  final List<int>? skillIds;
  final String? countryId;
  final String? cityId;
  final File? image;
  final String? address;
  final String? graduationDate;
  final String? academicYear;

  EditPersonalInfoParams({
    required this.id,
    this.firstName,
    this.lastName,
    this.universityId,
    this.facultyId,
    this.description,
    this.jobLevelId,
    this.graduationStatusId,
    this.jobLocationTypeId,
    this.majorIds,
    this.skillIds,
    this.countryId,
    this.cityId,
    this.image,
    this.address,
    this.graduationDate,
    this.academicYear,
  });
}