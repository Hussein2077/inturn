import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/auth/domain/use_case/sign_up_use_case.dart';
import 'package:inturn/features/auth/presentation/controller/sign_up_bloc/sign_up_with_email_and_password_events.dart';
import 'package:inturn/features/auth/presentation/controller/sign_up_bloc/sign_up_with_email_and_password_states.dart';

class SignUpWithEmailAndPasswordBloc extends Bloc<
    BaseSignUpWithEmailAndPasswordEvent, SignUpWithEmailAndPasswordState> {
  SignUpWithEmailAndPasswordUseCase signUpWithEmailAndPasswordUseCase;

  SignUpWithEmailAndPasswordBloc(
      {required this.signUpWithEmailAndPasswordUseCase})
      : super(SignUpWithEmailAndPasswordInitial()) {
    on<SignUpWithEmailAndPasswordEvent>((event, emit) async {
      emit(const SignUpWithEmailAndPasswordLoadingState());
      final result = await signUpWithEmailAndPasswordUseCase.call(SignUpModel(
        password: event.password,
        phone: event.phone,
      code: event.otp
      ));
      result.fold(
          (l) => emit(SignUpWithEmailAndPasswordSuccessMessageState(
              isCompleted: l['isCompleted'],
              completion: l['complition'],
              userId: l['userId'],
              successMessage: StringManager.loginSuccessfully.tr())),
          (r) => emit(SignUpWithEmailAndPasswordErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
