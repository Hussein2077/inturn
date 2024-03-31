import 'package:equatable/equatable.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoadingState extends ChangePasswordState {
  const ChangePasswordLoadingState();
}

class ChangePasswordErrorMessageState extends ChangePasswordState {
  final String errorMessage;

  const ChangePasswordErrorMessageState({required this.errorMessage});
}

class ChangePasswordSuccessMessageState extends ChangePasswordState {
  final String successMessage;

  const ChangePasswordSuccessMessageState({required this.successMessage});
}

class SendCodeLoadingState extends ChangePasswordState {
  const SendCodeLoadingState();
}

class SendCodeErrorMessageState extends ChangePasswordState {
  final String errorMessage;

  const SendCodeErrorMessageState({required this.errorMessage});
}

class SendCodeSuccessMessageState extends ChangePasswordState {
  final String successMessage;

  const SendCodeSuccessMessageState({required this.successMessage});
}

class VerifyCodeLoadingState extends ChangePasswordState {
  const VerifyCodeLoadingState();
}

class VerifyCodeErrorMessageState extends ChangePasswordState {
  final String errorMessage;

  const VerifyCodeErrorMessageState({required this.errorMessage});
}

class VerifyCodeSuccessMessageState extends ChangePasswordState {
  final String successMessage;

  const VerifyCodeSuccessMessageState({required this.successMessage});
}
