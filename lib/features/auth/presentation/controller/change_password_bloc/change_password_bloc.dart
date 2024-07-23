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
  VerifyCodeSignUpUseCase verifyCodeSignUpUseCase;
  SendCodeUseCase sendCodeUseCase;
  SendCodeForForgotUseCase  sendCodeForForgotUseCase;

  ResetPasswordFlowBloc(
      {required this.resetPasswordUseCase,
      required this.sendCodeUseCase,
      required this.verifyCodeUseCase,
        required this.verifyCodeSignUpUseCase,
        required this.sendCodeForForgotUseCase
      })
      : super(ResetPasswordInitial()) {
    on<ResetPasswordEvent>((event, emit) async {
      emit(const ResetPasswordLoadingState());
      final result = await resetPasswordUseCase.call(SignUpModel(
          password: event.password, phone: event.email, code: event.code,phoneOrEmailType: event.phoneOrEmailType));
      result.fold(
          (l) => emit(
              ResetPasswordSuccessMessageState(successMessage: l['message'])),
          (r) => emit(ResetPasswordErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
    on<SendCodeEvent>((event, emit) async {
      emit(const SendCodeLoadingState());
      final result =
          await sendCodeUseCase.call(SignUpModel(phone: event.phoneOrEmail,phoneOrEmailType: event.phoneOrEmailType));
      result.fold(
          (l) => emit(SendCodeSuccessMessageState(successMessage: l)),
          (r) => emit(SendCodeErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
    on<SendCodeForForgotEvent>((event, emit) async {
      emit(const SendCodeForForgetLoadingState());
      final result =
          await sendCodeForForgotUseCase.call(SignUpModel(phone: event.phoneOrEmail,phoneOrEmailType: event.phoneOrEmailType));
      result.fold(
          (l) => emit(SendCodeForForgetSuccessMessageState(successMessage: l)),
          (r) => emit(SendCodeForForgetErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
    on<VerifyCodeEvent>((event, emit) async {
      emit(const VerifyCodeLoadingState());
      final result = await verifyCodeUseCase
          .call(SignUpModel(code: event.code, phone: event.email,phoneOrEmailType: event.phoneOrEmailType,fromForgotForValidate: event.fromForgot));
      result.fold(
          (l) =>
              emit(VerifyCodeSuccessMessageState(successMessage: l['message'])),
          (r) => emit(VerifyCodeErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
    on<VerifyCodeSignUpEvent>((event, emit) async {
      emit(const VerifyCodeSignUpLoadingState());
      final result = await verifyCodeSignUpUseCase
          .call(SignUpModel(code: event.code, phone: event.phone));
      result.fold(
          (l) =>
              emit(VerifyCodeSignUpSuccessMessageState(successMessage: l)),
          (r) => emit(VerifyCodeSignUpErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
