
import 'package:equatable/equatable.dart';

abstract class SignUpWithEmailAndPasswordState extends Equatable {
  const SignUpWithEmailAndPasswordState();

  @override
  List<Object> get props => [];
}

class SignUpWithEmailAndPasswordInitial extends SignUpWithEmailAndPasswordState {}
class SignUpWithEmailAndPasswordLoadingState extends SignUpWithEmailAndPasswordState{
  const SignUpWithEmailAndPasswordLoadingState();
}
class SignUpWithEmailAndPasswordErrorMessageState extends SignUpWithEmailAndPasswordState{
  final String errorMessage ;

  const SignUpWithEmailAndPasswordErrorMessageState({required this.errorMessage});


}

class SignUpWithEmailAndPasswordSuccessMessageState extends SignUpWithEmailAndPasswordState{
  final String successMessage ;

  const SignUpWithEmailAndPasswordSuccessMessageState({ required this.successMessage});

}