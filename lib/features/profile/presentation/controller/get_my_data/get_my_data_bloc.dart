import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/profile/domain/use_case/get_my_data_uc.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_data/get_my_data_event.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_data/get_my_data_state.dart';

class GetMyDataBloc extends Bloc<BaseGetMyDataEvent, GetMyDataState> {
  GetMyDataUseCase getMyDataUseCase;

  GetMyDataBloc({required this.getMyDataUseCase}) : super(GetMyDataInitial()) {
    on<GetMyDataEvent>((event, emit) async {
      emit(const GetMyDataLoadingState());
      final result = await getMyDataUseCase.getMyData();
      result.fold(
          (l) => emit(GetMyDataSuccessMessageState(myDataModel: l)),
          (r) => emit(GetMyDataErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
