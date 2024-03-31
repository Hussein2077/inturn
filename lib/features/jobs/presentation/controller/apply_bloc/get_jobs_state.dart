import 'package:equatable/equatable.dart';
import 'package:inturn/core/models/vacancey_model.dart';


abstract class ApplyState extends Equatable {
  const ApplyState();

  @override
  List<Object> get props => [];
}

class ApplyInitial extends ApplyState {}
class ApplyLoadingState extends ApplyState{
  const ApplyLoadingState();
}
class ApplyErrorMessageState extends ApplyState{
  final String errorMessage ;

  const ApplyErrorMessageState({required this.errorMessage});


}

class ApplySuccessMessageState extends ApplyState{
  final String successMessage ;

  const ApplySuccessMessageState({ required this.successMessage});

}