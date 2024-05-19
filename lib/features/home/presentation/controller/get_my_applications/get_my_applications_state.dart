import 'package:equatable/equatable.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/features/home/data/model/application_model.dart';

abstract class GetMyApplicationsState extends Equatable {
  const GetMyApplicationsState();

  @override
  List<Object> get props => [];
}

class GetMyApplicationsInitial extends GetMyApplicationsState {}

class GetMyApplicationsLoadingState extends GetMyApplicationsState {
  const GetMyApplicationsLoadingState();
}

class GetMyApplicationsErrorMessageState extends GetMyApplicationsState {
  final String errorMessage;

  const GetMyApplicationsErrorMessageState({required this.errorMessage});
}

class GetMyApplicationsSuccessMessageState extends GetMyApplicationsState {
  final List<ApplicationModel> jobModel;

  const GetMyApplicationsSuccessMessageState({required this.jobModel});
}
