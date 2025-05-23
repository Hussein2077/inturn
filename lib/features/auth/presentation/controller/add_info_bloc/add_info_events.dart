import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class AddPersonalInfoEvent extends Equatable {
  const AddPersonalInfoEvent();

  @override
  List<Object> get props => [];
}

class AddPersonalInfoButtonPressedEvent extends AddPersonalInfoEvent {
  final File image;
  final String firstName;
  final String lastName;
  final String userID;

  const AddPersonalInfoButtonPressedEvent({required this.image, required this.firstName, required this.lastName, required this.userID});
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
class SendLocationEvent extends AddPersonalInfoEvent {
  final String countryID;
  final String cityID;
  final String locationTypeID;

  const SendLocationEvent({required this.countryID, required this.cityID, required this.locationTypeID});

  @override
  List<Object> get props => [countryID, cityID, locationTypeID];
}
class SendMajorIdEvent extends AddPersonalInfoEvent {
final List <int> majorIds;

  const SendMajorIdEvent({required this.majorIds});

  @override
  List<Object> get props => [majorIds];
}


