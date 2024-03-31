import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/jobs/domain/use_case/get_jobs.dart';
import 'package:inturn/features/jobs/presentation/controller/get_jobs/get_jobs_event.dart';
import 'package:inturn/features/jobs/presentation/controller/get_jobs/get_jobs_state.dart';

class GetJobsBloc extends Bloc<BaseGetJobsEvent, GetJobsState> {
  GetJobsUseCase getJobsUseCase;

  GetJobsBloc({required this.getJobsUseCase}) : super(GetJobsInitial()) {
    on<GetJobsEvent>((event, emit) async {
      emit(const GetJobsLoadingState());
      final result = await getJobsUseCase.call(VacancySearch(
        type: event.type,
        text: event.text,
        skill: event.skill,
        area: event.area,
      ));
      result.fold(
          (l) => emit(GetJobsSuccessMessageState(jobModel: l)),
          (r) => emit(GetJobsErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
