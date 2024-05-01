import 'package:equatable/equatable.dart';

abstract class AddSkillsState extends Equatable {
  const AddSkillsState();

  @override
  List<Object> get props => [];
}
class AddSkillsInitial extends AddSkillsState {}
class AddSkillsLoadingState extends AddSkillsState {}

class AddSkillsSuccessState  extends AddSkillsState {
  final String message;

  const AddSkillsSuccessState ({required this.message});

  @override
  List<Object> get props => [message];
}

class AddSkillsErrorState  extends AddSkillsState {
  final String errorMessage;

  const AddSkillsErrorState ({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}