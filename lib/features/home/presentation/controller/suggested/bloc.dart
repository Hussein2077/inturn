
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/home/domain/use_case/intern_search_uc.dart';
import 'package:inturn/features/home/presentation/controller/suggested/event.dart';
import 'package:inturn/features/home/presentation/controller/suggested/state.dart';

class SuggestedJobsBloc extends Bloc<SuggestedEvent, SuggestedState> {
  GetInternshipsBySearchUseCase getInternshipsBySearchUseCase;

  SuggestedJobsBloc({required this.getInternshipsBySearchUseCase}) : super(SuggestedBySearchInitial()) {
   on<GetSuggestedBySearchEvent>((event, emit) async {
      emit(const GetSuggestedBySearchLoadingState());
      final result = await getInternshipsBySearchUseCase.call(VacancySearch(
          companyId: event.companyId,
          userId: event.userId
      ));
      result.fold(
              (l) => emit(GetSuggestedBySearchSuccessMessageState(vacancyModel: l)),
              (r) => emit(GetSuggestedBySearchErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
