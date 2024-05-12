import 'package:equatable/equatable.dart';
import 'package:inturn/features/home/data/model/major_model.dart';

abstract class GetMajorsState extends Equatable {
  const GetMajorsState();

  @override
  List<Object> get props => [];
}

class GetMajorInitialState extends GetMajorsState {
  const GetMajorInitialState();
}

class GetMajorLoadingState extends GetMajorsState {
  const GetMajorLoadingState();
}

class GetMajorErrorMessageState extends GetMajorsState {
  final String errorMessage;

  const GetMajorErrorMessageState({required this.errorMessage});
}

class GetMajorSuccessMessageState extends GetMajorsState {
  final List<MajorModel> topFiveModel;

  const GetMajorSuccessMessageState({required this.topFiveModel});
}
