import 'package:dartz/dartz.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/core/models/my_data_model.dart';
import 'package:inturn/features/auth/domain/repo/base_repo.dart';

class SignUpWithEmailAndPasswordUseCase
    extends BaseUseCase<Map<String, dynamic>, SignUpModel> {
  BaseRepository baseRepository;

  SignUpWithEmailAndPasswordUseCase({required this.baseRepository});

  @override
  Future<Either<Map<String, dynamic>, Failure>> call(
      SignUpModel parameter) async {
    final result = await baseRepository.signUpWithEmailAndPassword(parameter);

    return result;
  }
}

class SignUpModel {
  final String? phone;
  final String? email;
  final String? password;
  final String? confirmPassword;
  final String? name;
  final String? lastName;
  final String? major;
  final String? eduLevel;
  final String? graduationYear;
  final String? universityID;
  final String? code;

  const SignUpModel({
    this.phone,
    this.email,
    this.password,
    this.name,
    this.lastName,
    this.major,
    this.eduLevel,
    this.graduationYear,
    this.universityID,
    this.code,
    this.confirmPassword,
  });
}
