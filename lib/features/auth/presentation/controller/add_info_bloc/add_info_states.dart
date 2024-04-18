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
