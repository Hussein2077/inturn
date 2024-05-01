import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/profile/domain/use_case/get_profile_data_uc.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_profile_data/get_my_profile_data_event.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_profile_data/get_my_profile_data_state.dart';

class GetMyProfileDataBloc extends Bloc<BaseGetMyProfileDataEvent, GetMyProfileDataState> {
  GetMyProfileDataUseCase getMyProfileDataUseCase;

  GetMyProfileDataBloc({required this.getMyProfileDataUseCase}) : super(GetMyProfileDataInitial()) {

    on<GetMyProfileDataEvent>((event, emit) async {
      emit(const GetMyProfileDataLoadingState());
      final result = await getMyProfileDataUseCase.call(event.userID);
      result.fold(
              (l) => emit(GetMyProfileDataSuccessMessageState(profileDataModel: l)),
              (r) => emit(GetMyProfileDataErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });

  }
}
