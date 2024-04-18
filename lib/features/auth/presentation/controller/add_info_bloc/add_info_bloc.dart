import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/auth/domain/use_case/add_info_uc.dart';
import 'package:inturn/features/auth/presentation/controller/add_info_bloc/add_info_events.dart';
import 'package:inturn/features/auth/presentation/controller/add_info_bloc/add_info_states.dart';

class AddPersonalInfoBloc extends Bloc<AddPersonalInfoEvent, AddPersonalInfoState> {
  final AddPersonalInfoUseCase addPersonalInfoUseCase;

  AddPersonalInfoBloc(
      {required this.addPersonalInfoUseCase})
      : super(AddPersonalInfoInitial()) {
    on<AddPersonalInfoButtonPressedEvent>((event, emit) async {
      emit(
          AddPersonalInfoLoadingState(),
      );
      final result = await addPersonalInfoUseCase
          .call(event.authModel);
      result.fold(
            (l) => emit(
              AddPersonalInfoSuccessState(
            message: StringManager.loginSuccessfully.tr(),
          ),
        ),
            (r) => emit(
              AddPersonalInfoErrorState(
            errorMessage: DioHelper().getTypeOfFailure(r),
          ),
        ),
      );
    });
  }
}
