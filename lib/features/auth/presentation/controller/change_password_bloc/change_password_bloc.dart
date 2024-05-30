import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/auth/domain/use_case/change_password.dart';
import 'package:inturn/features/auth/domain/use_case/send_code.dart';
import 'package:inturn/features/auth/domain/use_case/sign_up_use_case.dart';
import 'package:inturn/features/auth/domain/use_case/verify_code.dart';
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_events.dart';
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_states.dart';

class ResetPasswordFlowBloc
    extends Bloc<BaseChangePasswordEvent, ResetPasswordState> {
  ResetPasswordUseCase resetPasswordUseCase;
  VerifyCodeUseCase verifyCodeUseCase;
  SendCodeUseCase sendCodeUseCase;

  ResetPasswordFlowBloc(
      {required this.resetPasswordUseCase,
      required this.sendCodeUseCase,
      required this.verifyCodeUseCase})
      : super(ResetPasswordInitial()) {
    on<ResetPasswordEvent>((event, emit) async {
      emit(const ResetPasswordLoadingState());
      final result = await resetPasswordUseCase.call(SignUpModel(
          password: event.password, email: event.email, code: event.code));
      result.fold(
          (l) => emit(
              ResetPasswordSuccessMessageState(successMessage: l['message'])),
          (r) => emit(ResetPasswordErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
    on<SendCodeEvent>((event, emit) async {
      emit(const SendCodeLoadingState());
      final result =
          await sendCodeUseCase.call(SignUpModel(email: event.email));
      result.fold(
          (l) => emit(SendCodeSuccessMessageState(successMessage: l)),
          (r) => emit(SendCodeErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
    on<VerifyCodeEvent>((event, emit) async {
      emit(const VerifyCodeLoadingState());
      final result = await verifyCodeUseCase
          .call(SignUpModel(code: event.code, email: event.email));
      result.fold(
          (l) =>
              emit(VerifyCodeSuccessMessageState(successMessage: l['message'])),
          (r) => emit(VerifyCodeErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
