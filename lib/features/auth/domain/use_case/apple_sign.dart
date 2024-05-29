import 'package:dartz/dartz.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/features/auth/data/auth_remote_data_source.dart';
import 'package:inturn/features/auth/domain/repo/base_repo.dart';

class SignInWithAppleUC extends BaseUseCase<AuthWithAppleModel,NoParameter>{

  BaseRepository baseRepository ;


  SignInWithAppleUC({ required this.baseRepository});

  @override
  Future<Either<AuthWithAppleModel, Failure>> call(NoParameter parameter) async{

    final result =  await baseRepository.sigInWithApple() ;

    return result ;
  }


}