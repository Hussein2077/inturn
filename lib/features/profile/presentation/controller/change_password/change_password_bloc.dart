import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/profile/domain/use_case/change_password_uc.dart';
import 'package:inturn/features/profile/presentation/controller/change_password/change_password_event.dart';
import 'package:inturn/features/profile/presentation/controller/change_password/change_password_state.dart';

class ChangePasswordFlowBloc extends Bloc<BaseChangePasswordBaseEvent, ChangePasswordState> {
  ChangePasswordUseCase changePasswordUseCase;


  ChangePasswordFlowBloc(
      {required this.changePasswordUseCase})
      : super(ChangePasswordInitial()) {

    on<ChangePasswordEvent>((event, emit) async {
      emit(const ChangePasswordLoadingState());
      final result = await changePasswordUseCase.call(ChangePasswordModel(
          oldPassword: event.oldPassword, newPassword: event.newPassword, id: event.id));
      result.fold(
              (l) => emit(
                  ChangePasswordSuccessState(successMessage: l['message'])),
              (r) => emit(ChangePasswordErrorState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
