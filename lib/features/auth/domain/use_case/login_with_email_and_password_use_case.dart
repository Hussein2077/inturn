import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/features/auth/domain/repo/base_repo.dart';

class LoginWithEmailAndPasswordUseCase
    extends BaseUseCase<Map<String, dynamic>, AuthModel> {
  BaseRepository baseRepository;

  LoginWithEmailAndPasswordUseCase({required this.baseRepository});

  @override
  Future<Either<Map<String, dynamic>, Failure>> call(
      AuthModel parameter) async {
    final result = await baseRepository.loginWithEmailAndPassword(parameter);

    return result;
  }
}

class AuthModel {
  final String? email;
  final int? userId;
  final String? firstName;
  final String? lastName;
  final File? image;
  final String? password;
  final String? universityId;
  final String? facultyId;
  final String? countryID;
  final String? cityID;
  final String? locationTypeID;

/*
    public string UserId { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public IFormFile ImageFile { get; set; }
    public int UniversityId { get; set; }
    public int FacultyId { get; set; }

    public int JobLevelId { get; set; }
    public int GraduationStatusId { get; set; }
    public int JobLocationTypeId { get; set; }

 */
  AuthModel(
      {this.email,
      this.password,
      this.firstName,
      this.lastName,
      this.image,
        this.userId,
      this.universityId,
      this.facultyId,
      this.countryID,
      this.cityID,
      this.locationTypeID});
}
