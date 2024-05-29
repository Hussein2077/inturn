import 'package:equatable/equatable.dart';
import 'package:inturn/core/models/my_data_model.dart';
import 'package:inturn/features/auth/data/auth_remote_data_source.dart';


abstract class SignInWithPlatformState extends Equatable {
  const SignInWithPlatformState();

  @override
  List<Object> get props => [];
}

class SignInWithPlatformInitial extends SignInWithPlatformState {}

class SignWithPlatFormLoadingState extends SignInWithPlatformState{
  const SignWithPlatFormLoadingState();
}
class SignWithGoogleErrorMessageState extends SignInWithPlatformState{
  final String errorMessage ;

  const SignWithGoogleErrorMessageState({required this.errorMessage});


}
class SignWithGoogleSuccesMessageState extends SignInWithPlatformState{
  final AuthWithGoogleModel userData ;
  final bool isCompleted ;
  final int complition ;
  final String userId ;

  const SignWithGoogleSuccesMessageState({  required this.userId,  required this.userData , required this.isCompleted, required this.complition,});

}

class SignWithAppleErrorMessageState extends SignInWithPlatformState{
  final String errorMessage ;

  const SignWithAppleErrorMessageState({required this.errorMessage});


}
class SignWithAppleSuccesMessageState extends SignInWithPlatformState{
  final AuthWithAppleModel userData ;
  final bool isCompleted ;
  final int complition ;
  final String userId ;

  const SignWithAppleSuccesMessageState({  required this.userId,  required this.userData , required this.isCompleted, required this.complition,});

}
