import 'package:equatable/equatable.dart';

abstract class AddPersonalInfoState extends Equatable {
  const AddPersonalInfoState();

  @override
  List<Object> get props => [];
}

class AddPersonalInfoInitial extends AddPersonalInfoState {}

class AddPersonalInfoLoadingState extends AddPersonalInfoState {}

class AddPersonalInfoSuccessState extends AddPersonalInfoState {
  final String message;

  const AddPersonalInfoSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

class AddPersonalInfoErrorState extends AddPersonalInfoState {
  final String errorMessage;

  const AddPersonalInfoErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
// university
class AddUniversityLoadingState extends AddPersonalInfoState {}

class AddUniversitySuccessState extends AddPersonalInfoState {
  final String message;

  const AddUniversitySuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

class AddUniversityErrorState extends AddPersonalInfoState {
  final String errorMessage;

  const AddUniversityErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
//experience level
class AddExperienceLevelLoadingState extends AddPersonalInfoState {}

class AddExperienceLevelSuccessState  extends AddPersonalInfoState {
  final String message;

  const AddExperienceLevelSuccessState ({required this.message});

  @override
  List<Object> get props => [message];
}

class AddExperienceLevelErrorState  extends AddPersonalInfoState {
  final String errorMessage;

  const AddExperienceLevelErrorState ({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}




