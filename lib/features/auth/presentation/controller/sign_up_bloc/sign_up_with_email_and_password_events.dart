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
final String otp;

  const SignUpWithEmailAndPasswordEvent(  {
    required this.phone,
    required this.password,
    required this.otp,
  });
}
