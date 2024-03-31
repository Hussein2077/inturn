import 'package:dartz/dartz.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/features/auth/data/auth_remote_data_source.dart';
import 'package:inturn/features/auth/domain/repo/base_repo.dart';

class SignInWithGoogleUC extends BaseUseCase<AuthWithGoogleModel,NoParameter>{

  BaseRepository baseRepository ;


  SignInWithGoogleUC({ required this.baseRepository});

  @override
  Future<Either<AuthWithGoogleModel, Failure>> call(NoParameter parameter) async{

    final result =  await baseRepository.signWithGoogle() ;

    return result ;
  }


}