import 'package:equatable/equatable.dart';
import 'package:inturn/core/models/profile_data_model.dart';


abstract class GetMyProfileDataState extends Equatable {
  const GetMyProfileDataState();

  @override
  List<Object> get props => [];
}

class GetMyProfileDataInitial extends GetMyProfileDataState {}

class GetMyProfileDataLoadingState extends GetMyProfileDataState{
  const GetMyProfileDataLoadingState();
}
class GetMyProfileDataErrorMessageState extends GetMyProfileDataState{
  final String errorMessage ;

  const GetMyProfileDataErrorMessageState({required this.errorMessage});


}

class GetMyProfileDataSuccessMessageState extends GetMyProfileDataState{
  final ProfileDataModel profileDataModel ;

  const GetMyProfileDataSuccessMessageState({ required this.profileDataModel});

}