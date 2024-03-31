import 'package:equatable/equatable.dart';

import 'package:inturn/core/models/vacancey_model.dart';


abstract class GetInternshipsBySearchState extends Equatable {
  const GetInternshipsBySearchState();

  @override
  List<Object> get props => [];
}

class GetInternshipsBySearchInitial extends GetInternshipsBySearchState {}
class GetInternshipsBySearchLoadingState extends GetInternshipsBySearchState{
  const GetInternshipsBySearchLoadingState();
}
class GetInternshipsBySearchErrorMessageState extends GetInternshipsBySearchState{
  final String errorMessage ;

  const GetInternshipsBySearchErrorMessageState({required this.errorMessage});


}

class GetInternshipsBySearchSuccessMessageState extends GetInternshipsBySearchState{
  final List<VacancyModel> internModel ;

  const GetInternshipsBySearchSuccessMessageState({ required this.internModel});

}