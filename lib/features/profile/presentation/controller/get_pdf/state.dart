import 'package:equatable/equatable.dart';
import 'package:inturn/core/models/profile_data_model.dart';


abstract class GetPdfState  {
  const GetPdfState();


}

class GetPdfInitial extends GetPdfState {}

class GetPdfLoadingState extends GetPdfState{
  const GetPdfLoadingState();
}
class GetPdfErrorMessageState extends GetPdfState{
  final String errorMessage ;

  const GetPdfErrorMessageState({required this.errorMessage});


}

class GetPdfSuccessMessageState extends GetPdfState{
  final String filePath ;

  const GetPdfSuccessMessageState({ required this.filePath});

}