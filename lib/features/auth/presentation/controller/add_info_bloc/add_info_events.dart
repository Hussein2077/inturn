// add_personal_info_events.dart
import 'package:equatable/equatable.dart';
 import 'package:inturn/features/auth/domain/use_case/login_with_email_and_password_use_case.dart';

abstract class AddPersonalInfoEvent extends Equatable {
  const AddPersonalInfoEvent();

  @override
  List<Object> get props => [];
}

class AddPersonalInfoButtonPressedEvent extends AddPersonalInfoEvent {
  final AuthModel authModel;

  const AddPersonalInfoButtonPressedEvent({required this.authModel});

  @override
  List<Object> get props => [authModel];
}

