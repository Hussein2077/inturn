import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/home/domain/use_case/get_blogs_uc.dart';
import 'package:inturn/features/home/domain/use_case/get_top_jobs.dart';
import 'package:inturn/features/home/presentation/controller/top_five_and_blogs/get_top_five_event.dart';
import 'package:inturn/features/home/presentation/controller/top_five_and_blogs/get_top_five_state.dart';

class HomeBloc extends Bloc<BaseGeMatchedVacancyEvent, HomeState> {
  final GetMatchedJobsCase getMatchedJobsCase;
  final GetMajorUseCase getMajorUseCase;

  HomeBloc({
    required this.getMatchedJobsCase,
    required this.getMajorUseCase,
  }) : super(GetMatchedVacancyInitial()) {
    on<GeMatchedVacancyEvent >((event, emit) async {
      emit(const GetMatchedVacancyLoadingState());
      final result = await getMatchedJobsCase.call(const NoParameter());
      result.fold(
          (l) => emit(GetMatchedVacancySuccessMessageState(vacancyModel: l)),
          (r) => emit(GetMatchedVacancyErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
    on<GetMajorEvent>((event, emit) async {
      emit(const GetMajorLoadingState());
      final result = await getMajorUseCase.call(const NoParameter());
      result.fold(
          (l) => emit(GetMajorSuccessMessageState(topFiveModel: l)),
          (r) => emit(GetMajorErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
