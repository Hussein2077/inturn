import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/home/domain/use_case/apply_use_case.dart';
import 'package:inturn/features/home/presentation/controller/apply_bloc/get_jobs_event.dart';
import 'package:inturn/features/home/presentation/controller/apply_bloc/get_jobs_state.dart';

class ApplyBloc extends Bloc<BaseApplyEvent, ApplyState> {
  ApplyUseCase applyUseCase;

  ApplyBloc({required this.applyUseCase}) : super(ApplyInitial()) {
    on<ApplyEvent>((event, emit) async {
      emit(const ApplyLoadingState());
      final result = await applyUseCase.call(VacancyApply(vacancyID: event.vacancyID, userID: event.userID,

      ));
      result.fold(
          (l) => emit(const ApplySuccessMessageState(successMessage: 'Apply Success')),
          (r) => emit(ApplyErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
