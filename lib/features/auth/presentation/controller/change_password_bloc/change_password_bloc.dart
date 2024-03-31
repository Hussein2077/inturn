import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/auth/domain/use_case/change_password.dart';
import 'package:inturn/features/auth/domain/use_case/send_code.dart';
import 'package:inturn/features/auth/domain/use_case/sign_up_use_case.dart';
import 'package:inturn/features/auth/domain/use_case/verify_code.dart';
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_events.dart';
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_states.dart';

class ChangePasswordBloc
    extends Bloc<BaseChangePasswordEvent, ChangePasswordState> {
  ChangePasswordUseCase changePasswordUseCase;
  VerifyCodeUseCase verifyCodeUseCase;
  SendCodeUseCase sendCodeUseCase;

  ChangePasswordBloc(
      {required this.changePasswordUseCase,
      required this.sendCodeUseCase,
      required this.verifyCodeUseCase})
      : super(ChangePasswordInitial()) {
    on<ChangePasswordEvent>((event, emit) async {
      emit(const ChangePasswordLoadingState());
      final result = await changePasswordUseCase
          .call(SignUpModel(password: event.password));
      result.fold(
          (l) => emit(  ChangePasswordSuccessMessageState(
              successMessage: l['message'])),
          (r) => emit(ChangePasswordErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
    on<SendCodeEvent>((event, emit) async {
      emit(const SendCodeLoadingState());
      final result = await sendCodeUseCase
          .call(SignUpModel(email: event.email));
      result.fold(
          (l) => emit(  SendCodeSuccessMessageState(
              successMessage: l['message'])),
          (r) => emit(SendCodeErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
    on<VerifyCodeEvent>((event, emit) async {
      emit(const VerifyCodeLoadingState());
      final result = await verifyCodeUseCase
          .call(SignUpModel(code: event.code,email: event.email));
      result.fold(
          (l) => emit(  VerifyCodeSuccessMessageState(
              successMessage: l['message'])),
          (r) => emit(VerifyCodeErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
