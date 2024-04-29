// add_personal_info_events.dart
import 'dart:io';

import 'package:equatable/equatable.dart';
 import 'package:inturn/features/auth/domain/use_case/login_with_email_and_password_use_case.dart';

abstract class AddPersonalInfoEvent extends Equatable {
  const AddPersonalInfoEvent();

  @override
  List<Object> get props => [];
}

class AddPersonalInfoButtonPressedEvent extends AddPersonalInfoEvent {
  final File image;
  final String firstName;
  final String lastName;

  const AddPersonalInfoButtonPressedEvent({required this.image, required this.firstName, required this.lastName});
  @override
  List<Object> get props => [image, firstName, lastName];
}
class AddUniversityAndFacultiesEvent extends AddPersonalInfoEvent {
  final String universityId;
  final String facultyId;

  const AddUniversityAndFacultiesEvent({required this.universityId, required this.facultyId});

  @override
  List<Object> get props => [universityId, facultyId];
}

class SendExperienceLevelEvent extends AddPersonalInfoEvent {
  final String typeID;
  final String jobLevelId;

  const SendExperienceLevelEvent({required this.typeID, required this.jobLevelId});

  @override
  List<Object> get props => [typeID, jobLevelId];
}

