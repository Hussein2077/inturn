import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/auth/domain/use_case/add_info_uc.dart';
import 'package:inturn/features/auth/presentation/controller/add_skill/event.dart';
import 'package:inturn/features/auth/presentation/controller/add_skill/state.dart';

class AddSkillsBloc
    extends Bloc<AddSkillsEvent, AddSkillsState> {
  final SendSkillsIDUseCase sendSkillsIDUseCase;

  AddSkillsBloc(
      {
        required this.sendSkillsIDUseCase,
       })
      : super(AddSkillsInitial()) {

    on<SendSkillsIdEvent>(sendSkillsIdLevel);
  }



  sendSkillsIdLevel(event, emit) async {
    emit(
      AddSkillsLoadingState(),
    );
    final result = await sendSkillsIDUseCase.call(event.skills);
    result.fold(
          (l) => emit(
        AddSkillsSuccessState(
          message: StringManager.loginSuccessfully.tr(),
        ),
      ),
          (r) => emit(
        AddSkillsErrorState(
          errorMessage: DioHelper().getTypeOfFailure(r),
        ),
      ),
    );
  }
}
