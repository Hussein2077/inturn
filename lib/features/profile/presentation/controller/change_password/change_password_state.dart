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

class ChangePasswordErrorState extends ChangePasswordState {
  final String errorMessage;

  const ChangePasswordErrorState({required this.errorMessage});
}

class ChangePasswordSuccessState extends ChangePasswordState {
  final String successMessage;

  const ChangePasswordSuccessState({required this.successMessage});
}