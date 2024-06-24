import 'package:equatable/equatable.dart';

abstract class BaseSignUpWithEmailAndPasswordEvent extends Equatable {
  const BaseSignUpWithEmailAndPasswordEvent();

  @override
  List<Object> get props => [];
}

class SignUpWithEmailAndPasswordEvent
    extends BaseSignUpWithEmailAndPasswordEvent {
  final String phone;
  final String password;


  const SignUpWithEmailAndPasswordEvent( {
    required this.phone,
    required this.password,

  });
}
