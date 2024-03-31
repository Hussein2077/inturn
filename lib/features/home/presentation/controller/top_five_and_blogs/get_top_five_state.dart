import 'package:equatable/equatable.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/features/home/data/model/blog_model.dart';
import 'package:inturn/features/home/data/model/intern_model.dart';

abstract class GetTopFiveState extends Equatable {
  const GetTopFiveState();

  @override
  List<Object> get props => [];
}

class GetTopFiveInitial extends GetTopFiveState {}
class GetTopFiveLoadingState extends GetTopFiveState{
  const GetTopFiveLoadingState();
}
class GetTopFiveErrorMessageState extends GetTopFiveState{
  final String errorMessage ;

  const GetTopFiveErrorMessageState({required this.errorMessage});


}
class GetTopFiveSuccessMessageState extends GetTopFiveState{
  final List<VacancyModel> topFiveModel ;

  const GetTopFiveSuccessMessageState({ required this.topFiveModel});

}

class GetBlogsLoadingState extends GetTopFiveState{
  const GetBlogsLoadingState();
}
class GetBlogsErrorMessageState extends GetTopFiveState{
  final String errorMessage ;

  const GetBlogsErrorMessageState({required this.errorMessage});


}
class GetBlogsSuccessMessageState extends GetTopFiveState{
  final List<BlogModel> topFiveModel ;

  const GetBlogsSuccessMessageState({ required this.topFiveModel});

}