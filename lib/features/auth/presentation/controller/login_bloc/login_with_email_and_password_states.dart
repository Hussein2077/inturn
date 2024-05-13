
import 'package:equatable/equatable.dart';

abstract class LoginWithEmailAndPasswordState extends Equatable {
  const LoginWithEmailAndPasswordState();

  @override
  List<Object> get props => [];
}

class LoginWithEmailAndPasswordInitial extends LoginWithEmailAndPasswordState {}
class LoginWithEmailAndPasswordLoadingState extends LoginWithEmailAndPasswordState{
  const LoginWithEmailAndPasswordLoadingState();
}
class LoginWithEmailAndPasswordErrorMessageState extends LoginWithEmailAndPasswordState{
  final String errorMessage ;

  const LoginWithEmailAndPasswordErrorMessageState({required this.errorMessage});


}

class LoginWithEmailAndPasswordSuccessMessageState extends LoginWithEmailAndPasswordState{
  final String successMessage ;
  final bool isCompleted ;
  final int completion ;
  final String userId ;
  const LoginWithEmailAndPasswordSuccessMessageState(  {required this.userId,required this.successMessage,required this.isCompleted, required this.completion});

}