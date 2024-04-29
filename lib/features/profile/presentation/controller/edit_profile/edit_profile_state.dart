import 'package:inturn/core/models/my_data_model.dart';


abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoadingState extends EditProfileState{}

class EditProfileErrorMessageState extends EditProfileState{
  final String errorMessage ;
  EditProfileErrorMessageState({required this.errorMessage});
}

class EditProfileSuccessMessageState extends EditProfileState{
  final String success ;
  EditProfileSuccessMessageState({required this.success});
}