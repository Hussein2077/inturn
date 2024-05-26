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

  final String? UniversityId;
  final String? FacultyId;
  final String? Description;
  final String? JobLevelId;
  final String? GraduationStatusId;
  final String? JobLocationTypeId;
  final List<int>? MajorIds;
  final List<int>? SkillIds;
  final String? CountryId;
  final String? CityId;
  final File? image;
  EditPersonalInfoParams({
     required this.id,
     this.firstName,
     this.lastName,
     this.UniversityId,
     this.FacultyId,
     this.Description,
     this.JobLevelId,
     this.GraduationStatusId,
     this.JobLocationTypeId,
     this.MajorIds,
     this.SkillIds,
     this.CountryId,
     this.CityId,
    this.image
  });
}
