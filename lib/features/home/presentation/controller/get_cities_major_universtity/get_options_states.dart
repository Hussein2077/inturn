import 'package:equatable/equatable.dart';
import 'package:inturn/core/utils/enums.dart';
import 'package:inturn/features/home/data/model/cities_model.dart';
import 'package:inturn/features/home/data/model/major_model.dart';
import 'package:inturn/features/home/data/model/university_model.dart';

class GetOptionsStates extends Equatable {
  final List<MajorModel> getMajor;
  final RequestState getMajorRequest;
  final String getMajorMessage;
  final List<UniversityModel> getUniversity;
  final RequestState getUniversityRequest;
  final String getUniversityMessage;
  final List<CitiesModel> getCities;
  final RequestState getCitiesRequest;
  final String getCitiesMessage;

  const GetOptionsStates(
      {this.getMajor = const [],
      this.getMajorRequest = RequestState.loading,
      this.getMajorMessage = "",
      this.getUniversity = const [],
      this.getUniversityRequest = RequestState.loading,
      this.getUniversityMessage = "",
      this.getCities = const [],
      this.getCitiesRequest = RequestState.loading,
      this.getCitiesMessage = ""});

  GetOptionsStates copyWith({
    List<MajorModel>? getMajor,
    RequestState? getMajorRequest,
    String? getMajorMessage,
    List<UniversityModel>? getUniversity,
    RequestState? getUniversityRequest,
    String? getUniversityMessage,
    List<CitiesModel>? getCities,
    RequestState? getCitiesRequest,
    String? getCitiesMessage,
  }) {
    return GetOptionsStates(
        getMajor: getMajor ?? this.getMajor,
        getMajorRequest: getMajorRequest ?? this.getMajorRequest,
        getMajorMessage: getMajorMessage ?? this.getMajorMessage,
        getUniversity: getUniversity ?? this.getUniversity,
        getUniversityRequest: getUniversityRequest ?? this.getUniversityRequest,
        getUniversityMessage: getUniversityMessage ?? this.getUniversityMessage,
        getCities: getCities ?? this.getCities,
        getCitiesRequest: getCitiesRequest ?? this.getCitiesRequest,
        getCitiesMessage: getCitiesMessage ?? this.getUniversityMessage);
  }

  @override
  List<Object?> get props => [
        getMajor,
        getMajorMessage,
        getMajorRequest,
        getUniversityMessage,
        getUniversityRequest,
        getUniversity,
        getCities,
        getCitiesRequest,
        getCitiesMessage
      ];
}
