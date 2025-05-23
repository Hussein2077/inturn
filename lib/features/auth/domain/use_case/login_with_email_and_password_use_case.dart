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
  final String email;
  final String? password;
  final String? socialID;

  AuthModel({
    required this.email,
    this.password,
    this.socialID,
  });
}
