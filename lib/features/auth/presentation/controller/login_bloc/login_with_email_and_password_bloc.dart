import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/auth/domain/use_case/login_with_email_and_password_use_case.dart';
import 'package:inturn/features/auth/presentation/controller/login_bloc/login_with_email_and_password_events.dart';
import 'package:inturn/features/auth/presentation/controller/login_bloc/login_with_email_and_password_states.dart';

class LoginWithEmailAndPasswordBloc extends Bloc<
    BaseLoginWithEmailAndPasswordEvent, LoginWithEmailAndPasswordState> {
  LoginWithEmailAndPasswordUseCase loginWithEmailAndPasswordUseCase;
  LoginWithEmailAndPasswordBloc(
      {required this.loginWithEmailAndPasswordUseCase})
      : super(LoginWithEmailAndPasswordInitial()) {
    on<LoginWithEmailAndPasswordEvent>((event, emit) async {
      emit(
        const LoginWithEmailAndPasswordLoadingState(),
      );
      final result = await loginWithEmailAndPasswordUseCase
          .call(AuthModel(email: event.email, password: event.password));
      result.fold(
        (l) => emit(
          LoginWithEmailAndPasswordSuccessMessageState(
            successMessage: StringManager.loginSuccessfully.tr(), isCompleted: l['isCompleted'],
          ),
        ),
        (r) => emit(
          LoginWithEmailAndPasswordErrorMessageState(
            errorMessage: DioHelper().getTypeOfFailure(r),
          ),
        ),
      );
    });
  }
}
