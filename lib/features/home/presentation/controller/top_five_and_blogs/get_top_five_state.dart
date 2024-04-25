import 'package:equatable/equatable.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/features/home/data/model/major_model.dart';
import 'package:inturn/features/home/data/model/intern_model.dart';

abstract class GetTopFiveState extends Equatable {
  const GetTopFiveState();

  @override
  List<Object> get props => [];
}

class GetTopFiveInitial extends GetTopFiveState {}

class GetTopFiveLoadingState extends GetTopFiveState {
  const GetTopFiveLoadingState();
}

class GetTopFiveErrorMessageState extends GetTopFiveState {
  final String errorMessage;

  const GetTopFiveErrorMessageState({required this.errorMessage});
}

class GetTopFiveSuccessMessageState extends GetTopFiveState {
  final List<VacancyModel> topFiveModel;

  const GetTopFiveSuccessMessageState({required this.topFiveModel});
}

class GetMajorLoadingState extends GetTopFiveState {
  const GetMajorLoadingState();
}

class GetMajorErrorMessageState extends GetTopFiveState {
  final String errorMessage;

  const GetMajorErrorMessageState({required this.errorMessage});
}

class GetMajorSuccessMessageState extends GetTopFiveState {
  final List<MajorModel> topFiveModel;

  const GetMajorSuccessMessageState({required this.topFiveModel});
}
