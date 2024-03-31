import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/internships/domain/use_case/intern_search_uc.dart';
import 'package:inturn/features/internships/presentation/controller/intern_search_bloc/get_internships_search_event.dart';
import 'package:inturn/features/internships/presentation/controller/intern_search_bloc/get_internships_search_state.dart';

class GetInternshipsBySearchBloc extends Bloc<BaseGetInternshipsBySearchEvent, GetInternshipsBySearchState> {
  GetInternshipsBySearchUseCase getInternshipsBySearchUseCase;

  GetInternshipsBySearchBloc({required this.getInternshipsBySearchUseCase}) : super(GetInternshipsBySearchInitial()) {
    on<GetInternshipsBySearchEvent>((event, emit) async {
      emit(const GetInternshipsBySearchLoadingState());
      final result = await getInternshipsBySearchUseCase.call(VacancySearch(
        area: event.area,
        text: event.text,
        skill: event.skill,
        type: event.type
      ));
      result.fold(
          (l) => emit(GetInternshipsBySearchSuccessMessageState(internModel: l)),
          (r) => emit(GetInternshipsBySearchErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
