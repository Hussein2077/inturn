import 'package:equatable/equatable.dart';
import 'package:inturn/core/models/vacancey_model.dart';

class SuggestedInCompanyState extends Equatable {
  const SuggestedInCompanyState();

  @override
  List<Object> get props => [];
}
class SuggestedInCompanyBySearchInitial extends SuggestedInCompanyState {}

class GetSuggestedInCompanyBySearchLoadingState extends SuggestedInCompanyState {
  const GetSuggestedInCompanyBySearchLoadingState();
}

class GetSuggestedInCompanyBySearchErrorMessageState
    extends SuggestedInCompanyState {
  final String errorMessage;

  const GetSuggestedInCompanyBySearchErrorMessageState({required this.errorMessage});
}

class GetSuggestedInCompanyBySearchSuccessMessageState
    extends SuggestedInCompanyState {
  final List<VacancyModel> vacancyModel;

  const GetSuggestedInCompanyBySearchSuccessMessageState({required this.vacancyModel});
}
