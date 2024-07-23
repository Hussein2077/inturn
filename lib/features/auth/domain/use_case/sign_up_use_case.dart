import 'package:dartz/dartz.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/core/models/my_data_model.dart';
import 'package:inturn/core/resource_manager/themes/enums.dart';
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
  final String? password;
  final String? code;
  final PhoneOrEmail? phoneOrEmailType ;
final bool? fromForgotForValidate;
  const SignUpModel( {
    this.phone,
    this.code,
    this.password,
    this.phoneOrEmailType,
    this.fromForgotForValidate
  });
}
