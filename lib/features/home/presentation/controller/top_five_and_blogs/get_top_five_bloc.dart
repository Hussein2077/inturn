import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/home/domain/use_case/get_blogs_uc.dart';
import 'package:inturn/features/home/domain/use_case/get_top_jobs.dart';
import 'package:inturn/features/home/presentation/controller/top_five_and_blogs/get_top_five_event.dart';
import 'package:inturn/features/home/presentation/controller/top_five_and_blogs/get_top_five_state.dart';

class GetTopFiveBloc extends Bloc<BaseGetTopFiveEvent, GetTopFiveState> {
  final GetTopFiveUseCase getTopFiveUseCase;
  final GetBlogsUseCase getBlogsUseCase;

  GetTopFiveBloc({
    required this.getTopFiveUseCase,
    required this.getBlogsUseCase,
  }) : super(GetTopFiveInitial()) {
    on<GetTopFiveEvent>((event, emit) async {
      emit(const GetTopFiveLoadingState());
      final result = await getTopFiveUseCase.call(event.type);
      result.fold(
          (l) => emit(GetTopFiveSuccessMessageState(topFiveModel: l)),
          (r) => emit(GetTopFiveErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
    on<GetBlogsEvent>((event, emit) async {
      emit(const GetBlogsLoadingState());
      final result = await getBlogsUseCase.call(const NoParameter());
      result.fold(
          (l) => emit(GetBlogsSuccessMessageState(topFiveModel: l)),
          (r) => emit(GetBlogsErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
