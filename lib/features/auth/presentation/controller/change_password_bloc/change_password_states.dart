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

class VerifyCodeLoadingState extends ResetPasswordState {
  const VerifyCodeLoadingState();
}

class VerifyCodeErrorMessageState extends ResetPasswordState {
  final String errorMessage;

  const VerifyCodeErrorMessageState({required this.errorMessage});
}

class VerifyCodeSuccessMessageState extends ResetPasswordState {
  final String successMessage;

  const VerifyCodeSuccessMessageState({required this.successMessage});
}
