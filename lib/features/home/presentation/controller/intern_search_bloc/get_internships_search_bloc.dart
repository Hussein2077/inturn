import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/home/domain/use_case/intern_search_uc.dart';
import 'package:inturn/features/home/presentation/controller/intern_search_bloc/get_internships_search_event.dart';
import 'package:inturn/features/home/presentation/controller/intern_search_bloc/get_internships_search_state.dart';

class GetInternshipsBySearchBloc extends Bloc<BaseGetInternshipsBySearchEvent, GetInternshipsBySearchState> {
  GetInternshipsBySearchUseCase getInternshipsBySearchUseCase;

  GetInternshipsBySearchBloc({required this.getInternshipsBySearchUseCase}) : super(GetInternshipsBySearchInitial()) {
    on<InitEvent>((event, emit){
      emit(GetInternshipsBySearchInitial());
    });
    on<GetInternshipsBySearchEvent>((event, emit) async {
      emit(const GetInternshipsBySearchLoadingState());
      final result = await getInternshipsBySearchUseCase.call(VacancySearch(
       title: event.title,
        cityId: event.cityId,
        countryId: event.countryId,
        companyId: event.companyId,
        vacancyLevelId: event.vacancyLevelId,
        userId: event.userId,
        areaId: event.areaId,
        vacancyWorkPlace: event.vacancyWorkPlace
      ));
      result.fold(
          (l) => emit(GetInternshipsBySearchSuccessMessageState(vacancyModel: l)),
          (r) => emit(GetInternshipsBySearchErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
