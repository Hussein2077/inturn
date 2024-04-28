import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/home/domain/use_case/vacancy_details_uc.dart';
import 'package:inturn/features/home/presentation/controller/vacancy_details_bloc/event.dart';
import 'package:inturn/features/home/presentation/controller/vacancy_details_bloc/state.dart';

class VacancyBloc extends Bloc<BaseGetVacancyDetailsEvent, GetVacancyDetailsState> {
  final GetVacancyDetailsUseCase getVacancyDetailsUseCase;

  VacancyBloc({
    required this.getVacancyDetailsUseCase,
  }) : super(GetVacancyDetailsInitial()) {
    on<GetVacancyDetailsEvent>((event, emit) async {
      emit(const GetVacancyDetailsLoadingState());
      final result = await getVacancyDetailsUseCase.call( event.id);
      result.fold(
              (l) => emit(GetVacancyDetailsSuccessMessageState(topFiveModel: l)),
              (r) => emit(GetVacancyDetailsErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });

  }
}
