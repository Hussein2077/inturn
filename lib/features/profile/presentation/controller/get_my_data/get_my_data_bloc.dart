import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/profile/domain/use_case/get_my_data_uc.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_data/get_my_data_event.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_data/get_my_data_state.dart';

class GetMyDataBloc extends Bloc<BaseGetMyDataEvent, GetMyDataState> {
  GetMyDataUseCase getMyDataUseCase;
  CompleteProfileUseCase completeProfileUseCase;

  GetMyDataBloc({required this.getMyDataUseCase, required this.completeProfileUseCase}) : super(GetMyDataInitial()) {
    on<GetMyDataEvent>((event, emit) async {
      emit(const GetMyDataLoadingState());
      final result = await getMyDataUseCase.call(event.userID);
      result.fold(
          (l) => emit(GetMyDataSuccessMessageState(myDataModel: l)),
          (r) => emit(GetMyDataErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
    on<CompleteProfileEvent>((event, emit) async {
      emit(const CompleteProfileLoadingState());
      final result = await completeProfileUseCase.call(event.userID);
      result.fold(
          (l) => emit(CompleteProfileSuccessMessageState(myDataModel: l)),
          (r) => emit(CompleteProfileErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });

  }
}
