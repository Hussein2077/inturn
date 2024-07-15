import 'package:equatable/equatable.dart';

abstract class BaseLoginWithEmailAndPasswordEvent extends Equatable {
  const BaseLoginWithEmailAndPasswordEvent();

  @override
  List<Object> get props => [];
}

class LoginWithEmailAndPasswordEvent
    extends BaseLoginWithEmailAndPasswordEvent {
  final String email;

  final String password;

  const LoginWithEmailAndPasswordEvent(
      {required this.email, required this.password});
}

class DeleteAccountEvent extends BaseLoginWithEmailAndPasswordEvent {}
