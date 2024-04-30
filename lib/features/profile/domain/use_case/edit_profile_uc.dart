import 'package:dartz/dartz.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/features/profile/domain/repo/profile_base_repo.dart';

class EditPersonalInfoUseCase
    extends BaseUseCase<String, EditPersonalInfoParams> {
  BaseRepositoryProfile baseRepositoryProfile;
  EditPersonalInfoUseCase({required this.baseRepositoryProfile});
  @override
  Future<Either<String, Failure>> call(
      EditPersonalInfoParams parameter) async {
    final result = await baseRepositoryProfile.editProfileData(parameter);
    return result;
  }
}

class EditPersonalInfoParams {
  final String id;
  final String firstName;
  final String lastName;
  var image;
  final String UniversityId;
  final String FacultyId;
  final String Description;
  final String JobLevelId;
  final String GraduationStatusId;
  final String JobLocationTypeId;
  final List<dynamic> MajorIds;
  final List<dynamic> SkillIds;
  final String CountryId;
  final String CityId;

  EditPersonalInfoParams({required this.id,required this.firstName,required this.lastName, required this.UniversityId, required this.FacultyId, required this.Description, required this.JobLevelId, required this.GraduationStatusId, required this.JobLocationTypeId, required this.MajorIds, required this.SkillIds, required this.CountryId, required this.CityId,});
}