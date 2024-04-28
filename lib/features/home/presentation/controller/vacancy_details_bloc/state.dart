import 'package:equatable/equatable.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/features/home/data/model/major_model.dart';
import 'package:inturn/features/home/data/model/intern_model.dart';

abstract class GetVacancyDetailsState extends Equatable {
  const GetVacancyDetailsState();

  @override
  List<Object> get props => [];
}

class GetVacancyDetailsInitial extends GetVacancyDetailsState {}

class GetVacancyDetailsLoadingState extends GetVacancyDetailsState {
  const GetVacancyDetailsLoadingState();
}

class GetVacancyDetailsErrorMessageState extends GetVacancyDetailsState {
  final String errorMessage;

  const GetVacancyDetailsErrorMessageState({required this.errorMessage});
}

class GetVacancyDetailsSuccessMessageState extends GetVacancyDetailsState {
  final List<VacancyModel> topFiveModel;

  const GetVacancyDetailsSuccessMessageState({required this.topFiveModel});
}
