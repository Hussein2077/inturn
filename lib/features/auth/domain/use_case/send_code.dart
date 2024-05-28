import 'package:dartz/dartz.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/features/auth/domain/repo/base_repo.dart';
import 'package:inturn/features/auth/domain/use_case/sign_up_use_case.dart';
class SendCodeUseCase
    extends BaseUseCase<String, SignUpModel> {
  BaseRepository baseRepository;

  SendCodeUseCase({required this.baseRepository});

  @override
  Future<Either<String, Failure>> call(
      SignUpModel parameter) async {
    final result = await baseRepository.sendCode(parameter);

    return result;
  }
}