import 'package:equatable/equatable.dart';
import 'package:inturn/core/utils/enums.dart';
import 'package:inturn/features/home/data/model/cities_model.dart';
import 'package:inturn/features/home/data/model/faculty_model.dart';
import 'package:inturn/features/home/data/model/university_model.dart';

class GetOptionsStates extends Equatable {
  final List<FacultyModel> getFaculty;
  final RequestState getFacultyRequest;
  final String getFacultyMessage;
  final List<UniversityModel> getUniversity;
  final RequestState getUniversityRequest;
  final String getUniversityMessage;
  final List<Country> getCities;
  final List<CityModel> getCities2;
  final RequestState getCitiesRequest;
  final String getCitiesMessage;

  const GetOptionsStates(
      {this.getFaculty = const [],
      this.getFacultyRequest = RequestState.loading,
      this.getFacultyMessage = "",
      this.getUniversity = const [],
      this.getUniversityRequest = RequestState.loading,
      this.getUniversityMessage = "",
      this.getCities = const [],
      this.getCities2 = const [],
      this.getCitiesRequest = RequestState.loading,
      this.getCitiesMessage = ""});

  GetOptionsStates copyWith({
    List<FacultyModel>? getFaculty,
    RequestState? getFacultyRequest,
    String? getFacultyMessage,
    List<UniversityModel>? getUniversity,
    RequestState? getUniversityRequest,
    String? getUniversityMessage,
    List<Country>? getCities,
    List<CityModel>? getCities2,
    RequestState? getCitiesRequest,
    String? getCitiesMessage,
  }) {
    return GetOptionsStates(
        getFaculty: getFaculty ?? this.getFaculty,
        getFacultyRequest: getFacultyRequest ?? this.getFacultyRequest,
        getFacultyMessage: getFacultyMessage ?? this.getFacultyMessage,
        getUniversity: getUniversity ?? this.getUniversity,
        getUniversityRequest: getUniversityRequest ?? this.getUniversityRequest,
        getUniversityMessage: getUniversityMessage ?? this.getUniversityMessage,
        getCities: getCities ?? this.getCities,
        getCities2: getCities2 ?? this.getCities2,
        getCitiesRequest: getCitiesRequest ?? this.getCitiesRequest,
        getCitiesMessage: getCitiesMessage ?? this.getUniversityMessage);

  }

  @override
  List<Object?> get props => [
        getFaculty,
        getFacultyMessage,
        getFacultyRequest,
        getUniversityMessage,
        getUniversityRequest,
        getUniversity,
        getCities,
        getCitiesRequest,
        getCitiesMessage,
        getCities2,
      ];
}
