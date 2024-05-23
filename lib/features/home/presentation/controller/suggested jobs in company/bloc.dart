
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/home/domain/use_case/intern_search_uc.dart';
import 'package:inturn/features/home/presentation/controller/suggested%20jobs%20in%20company/event.dart';
import 'package:inturn/features/home/presentation/controller/suggested%20jobs%20in%20company/state.dart';

class SuggestedJobsInCompanyBloc extends Bloc<SuggestedInCompanyEvent, SuggestedInCompanyState> {
  GetInternshipsBySearchUseCase getInternshipsBySearchUseCase;

  SuggestedJobsInCompanyBloc({required this.getInternshipsBySearchUseCase}) : super(SuggestedInCompanyBySearchInitial()) {
   on<GetSuggestedInCompanyBySearchEvent>((event, emit) async {
      emit(const GetSuggestedInCompanyBySearchLoadingState());
      final result = await getInternshipsBySearchUseCase.call(VacancySearch(
          companyId: event.companyId,
          userId: event.userId
      ));
      result.fold(
              (l) => emit(GetSuggestedInCompanyBySearchSuccessMessageState(vacancyModel: l)),
              (r) => emit(GetSuggestedInCompanyBySearchErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
