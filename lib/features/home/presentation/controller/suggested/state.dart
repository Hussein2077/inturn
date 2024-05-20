import 'package:equatable/equatable.dart';
import 'package:inturn/core/models/vacancey_model.dart';

class SuggestedState extends Equatable {
  const SuggestedState();

  @override
  List<Object> get props => [];
}
class SuggestedBySearchInitial extends SuggestedState {}

class GetSuggestedBySearchLoadingState extends SuggestedState {
  const GetSuggestedBySearchLoadingState();
}

class GetSuggestedBySearchErrorMessageState
    extends SuggestedState {
  final String errorMessage;

  const GetSuggestedBySearchErrorMessageState({required this.errorMessage});
}

class GetSuggestedBySearchSuccessMessageState
    extends SuggestedState {
  final List<VacancyModel> vacancyModel;

  const GetSuggestedBySearchSuccessMessageState({required this.vacancyModel});
}
