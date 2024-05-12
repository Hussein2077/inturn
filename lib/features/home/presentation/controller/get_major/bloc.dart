import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/home/domain/use_case/get_blogs_uc.dart';
import 'package:inturn/features/home/presentation/controller/get_major/event.dart';
import 'package:inturn/features/home/presentation/controller/get_major/state.dart';

class GetMajorBloc extends Bloc<GetMajorEventBase, GetMajorsState> {
  final GetMajorUseCase getMajorUseCase;

  GetMajorBloc({
    required this.getMajorUseCase,
  }) : super(const GetMajorInitialState()) {
    on<InitEvent> ((event, emit) async {
      emit(const GetMajorInitialState());
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
