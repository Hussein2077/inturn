import 'package:equatable/equatable.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoadingState extends ResetPasswordState {
  const ResetPasswordLoadingState();
}

class ResetPasswordErrorMessageState extends ResetPasswordState {
  final String errorMessage;

  const ResetPasswordErrorMessageState({required this.errorMessage});
}

class ResetPasswordSuccessMessageState extends ResetPasswordState {
  final String successMessage;

  const ResetPasswordSuccessMessageState({required this.successMessage});
}

class SendCodeLoadingState extends ResetPasswordState {
  const SendCodeLoadingState();
}

class SendCodeErrorMessageState extends ResetPasswordState {
  final String errorMessage;

  const SendCodeErrorMessageState({required this.errorMessage});
}

class SendCodeSuccessMessageState extends ResetPasswordState {
  final String successMessage;

  const SendCodeSuccessMessageState({required this.successMessage});
}
class SendCodeForForgetLoadingState extends ResetPasswordState {
  const SendCodeForForgetLoadingState();
}

class SendCodeForForgetErrorMessageState extends ResetPasswordState {
  final String errorMessage;

  const SendCodeForForgetErrorMessageState({required this.errorMessage});
}

class SendCodeForForgetSuccessMessageState extends ResetPasswordState {
  final String successMessage;

  const SendCodeForForgetSuccessMessageState({required this.successMessage});
}

class VerifyCodeLoadingState extends ResetPasswordState {
  const VerifyCodeLoadingState();
}

class VerifyCodeErrorMessageState extends ResetPasswordState {
  final String errorMessage;

  const VerifyCodeErrorMessageState({required this.errorMessage});
}

class VerifyCodeSuccessMessageState extends ResetPasswordState {
  final String successMessage;
final String? guid;
  const VerifyCodeSuccessMessageState({required this.successMessage,this.guid, });
}
class VerifyCodeSignUpLoadingState extends ResetPasswordState {
  const VerifyCodeSignUpLoadingState();
}

class VerifyCodeSignUpErrorMessageState extends ResetPasswordState {
  final String errorMessage;

  const VerifyCodeSignUpErrorMessageState({required this.errorMessage});
}

class VerifyCodeSignUpSuccessMessageState extends ResetPasswordState {
  final String successMessage;

  const VerifyCodeSignUpSuccessMessageState({required this.successMessage});
}
