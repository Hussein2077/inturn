import 'package:equatable/equatable.dart';

abstract class BaseSignUpWithEmailAndPasswordEvent extends Equatable {
  const BaseSignUpWithEmailAndPasswordEvent();

  @override
  List<Object> get props => [];
}

class SignUpWithEmailAndPasswordEvent
    extends BaseSignUpWithEmailAndPasswordEvent {
  final String phone;
  final String email;
  final String password;
  final String confirmPassword;
  final String name;
  final String lastName;
  final String major;
  final String eduLevel;
  final String graduationYear;
  final String universityID;

  const SignUpWithEmailAndPasswordEvent( {
    required this.phone,
    required this.email,
    required this.password,
    required this.name,
    required this.lastName,
    required this.major,
    required this.eduLevel,
    required this.graduationYear,
    required this.universityID,
    required this.confirmPassword,
  });
}
