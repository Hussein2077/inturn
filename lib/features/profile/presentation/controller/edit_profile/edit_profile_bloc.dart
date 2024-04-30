import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/profile/domain/use_case/edit_profile_uc.dart';
import 'package:inturn/features/profile/presentation/controller/edit_profile/edit_profile_event.dart';
import 'package:inturn/features/profile/presentation/controller/edit_profile/edit_profile_state.dart';

class EditProfileBloc extends Bloc<BaseEditProfileEvent, EditProfileState> {
  EditPersonalInfoUseCase editPersonalInfoUseCase;

  EditProfileBloc({required this.editPersonalInfoUseCase}) : super(EditProfileInitial()) {

    on<EditProfileEvent>((event, emit) async {
      emit(EditProfileLoadingState());
      final result = await editPersonalInfoUseCase.call(event.data);
      result.fold(
              (l) => emit(EditProfileSuccessMessageState(success: l)),
              (r) => emit(EditProfileErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
