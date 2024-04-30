import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/core/utils/enums.dart';
import 'package:inturn/features/home/domain/use_case/get_cities.dart';
import 'package:inturn/features/home/domain/use_case/get_major_uc.dart';
import 'package:inturn/features/home/domain/use_case/get_university_uc.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_events.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_states.dart';

class OptionsBloc extends Bloc<OptionsEvent, GetOptionsStates> {
  final GetCitiesUseCase getCitiesUseCase;

  final GetFacultyUseCase getFacultyUseCase;

  final GetUniversityUseCase getUniversityUseCase;
  final GetSkillsUseCase getSkillUseCase;

  OptionsBloc(
      {required this.getUniversityUseCase,
      required this.getFacultyUseCase,
      required this.getSkillUseCase,
      required this.getCitiesUseCase})
      : super(const GetOptionsStates()) {
    on<GetFacultyEvent>(getFaculty);
    on<GetUniversityEvent>(getUniversity);
    on<GetCitiesEvent>(getCities);
    on<GetSkillsEvent>(getSkills);
  }

  FutureOr<void> getFaculty(
      GetFacultyEvent event, Emitter<GetOptionsStates> emit) async {
    final result = await getFacultyUseCase.call(event.id);
    result.fold(
        (l) => emit(
            state.copyWith(getFaculty: l, getFacultyRequest: RequestState.loaded)),
        (r) => emit(state.copyWith(
            getFacultyRequest: RequestState.error,
            getFacultyMessage: DioHelper().getTypeOfFailure(r))));
  }

  FutureOr<void> getUniversity(
      GetUniversityEvent event, Emitter<GetOptionsStates> emit) async {
    final result = await getUniversityUseCase.call(const NoParameter());
    result.fold(
        (l) => emit(state.copyWith(
            getUniversity: l, getUniversityRequest: RequestState.loaded)),
        (r) => emit(state.copyWith(
            getUniversityRequest: RequestState.error,
            getUniversityMessage: DioHelper().getTypeOfFailure(r))));
  }

  FutureOr<void> getCities(
      GetCitiesEvent event, Emitter<GetOptionsStates> emit) async {
    final result = await getCitiesUseCase.call(const NoParameter());
    result.fold(
        (l) => emit(state.copyWith(
            getCities: l, getCitiesRequest: RequestState.loaded)),
        (r) => emit(state.copyWith(
            getCitiesRequest: RequestState.error,
            getCitiesMessage: DioHelper().getTypeOfFailure(r))));
  }  FutureOr<void> getSkills(
      GetSkillsEvent event, Emitter<GetOptionsStates> emit) async {
    final result = await getSkillUseCase.call(const NoParameter());
    result.fold(
        (l) => emit(state.copyWith(
            getSkills: l, getSkillsRequest: RequestState.loaded)),
        (r) => emit(state.copyWith(
            getSkillsRequest: RequestState.error,
            getSkillsMessage: DioHelper().getTypeOfFailure(r))));
  }
}
