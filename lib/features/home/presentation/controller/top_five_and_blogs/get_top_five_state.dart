import 'package:equatable/equatable.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/features/home/data/model/major_model.dart';
import 'package:inturn/features/home/data/model/intern_model.dart';
import 'package:inturn/features/home/data/model/matched_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class GetMatchedVacancyInitial extends HomeState {}

class GetMatchedVacancyLoadingState extends HomeState {
  const GetMatchedVacancyLoadingState();
}

class GetMatchedVacancyErrorMessageState extends HomeState {
  final String errorMessage;

  const GetMatchedVacancyErrorMessageState({required this.errorMessage});
}

class GetMatchedVacancySuccessMessageState extends HomeState {
  final List<MatchedVacancyWrapper> vacancyModel;

  const GetMatchedVacancySuccessMessageState({required this.vacancyModel});
}

