import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/home/domain/use_case/intern_search_uc.dart';
import 'package:inturn/features/home/domain/use_case/my_applications_us.dart';
import 'package:inturn/features/home/presentation/controller/get_my_applications/get_my_applications_event.dart';
import 'package:inturn/features/home/presentation/controller/get_my_applications/get_my_applications_state.dart';

class GetMyApplicationsBloc extends Bloc<BaseGetMyApplicationsEvent, GetMyApplicationsState> {
  GetInternshipsBySearchUseCase getMyApplicationsUseCase;

  GetMyApplicationsBloc({required this.getMyApplicationsUseCase}) : super(GetMyApplicationsInitial()) {
    on<GetMyApplicationsEvent>((event, emit) async {
      emit(const GetMyApplicationsLoadingState());
      final result = await getMyApplicationsUseCase.call(VacancySearch(
          userId: event.userId
      ));
      result.fold(
          (l) => emit(GetMyApplicationsSuccessMessageState(jobModel: l)),
          (r) => emit(GetMyApplicationsErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
