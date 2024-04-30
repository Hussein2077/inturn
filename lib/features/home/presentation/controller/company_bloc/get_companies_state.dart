import 'package:equatable/equatable.dart';
import 'package:inturn/features/home/data/model/company_model.dart';

abstract class GetCompaniesState extends Equatable {
  const GetCompaniesState();

  @override
  List<Object> get props => [];
}

class GetCompaniesInitial extends GetCompaniesState {}

class GetCompaniesLoadingState extends GetCompaniesState {
  const GetCompaniesLoadingState();
}

class GetCompaniesErrorMessageState extends GetCompaniesState {
  final String errorMessage;

  const GetCompaniesErrorMessageState({required this.errorMessage});
}

class GetCompaniesSuccessMessageState extends GetCompaniesState {
  final List<CompanyModel> jobModel;

  const GetCompaniesSuccessMessageState({required this.jobModel});
}
