import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/auth/domain/use_case/add_info_uc.dart';
import 'package:inturn/features/auth/presentation/controller/add_info_bloc/add_info_events.dart';
import 'package:inturn/features/auth/presentation/controller/add_info_bloc/add_info_states.dart';

class AddPersonalInfoBloc
    extends Bloc<AddPersonalInfoEvent, AddPersonalInfoState> {
  final AddPersonalInfoUseCase addPersonalInfoUseCase;
  final SendUniversityFacultyIdsUseCase sendUniversityFacultyIdsUseCase;
  final SendExperienceLevelUseCase sendExperienceLevelUseCase;

  AddPersonalInfoBloc(
      {required this.addPersonalInfoUseCase,
      required this.sendUniversityFacultyIdsUseCase,
      required this.sendExperienceLevelUseCase})
      : super(AddPersonalInfoInitial()) {
    on<AddPersonalInfoButtonPressedEvent>(addPersonalInfo);
    on<AddUniversityAndFacultiesEvent>(addUniversityAndFaculties);
    on<SendExperienceLevelEvent>(sendExperienceLevel);
  }

  addPersonalInfo(event, emit) async {
    emit(
      AddPersonalInfoLoadingState(),
    );
    final result = await addPersonalInfoUseCase.call(PersonalInfoParams(
        image: event.image,
        firstName: event.firstName,
        lastName: event.lastName));
    result.fold(
      (l) => emit(
        AddPersonalInfoSuccessState(
          message: l['message'].toString(),
        ),
      ),
      (r) => emit(
        AddPersonalInfoErrorState(
          errorMessage: DioHelper().getTypeOfFailure(r),

        ),
      ),
    );
  }

  addUniversityAndFaculties(event, emit) async {
    emit(
      AddUniversityLoadingState(),
    );
    final result = await sendUniversityFacultyIdsUseCase.call(
        SendUniversityFacultyIdsParams(
            universityId: event.universityId, facultyId: event.facultyId));
    result.fold(
      (l) => emit(
        AddUniversitySuccessState(
          message: StringManager.loginSuccessfully.tr(),
        ),
      ),
      (r) => emit(
        AddUniversityErrorState(
          errorMessage: DioHelper().getTypeOfFailure(r),
        ),
      ),
    );
  }

  sendExperienceLevel(event, emit) async {
    emit(
      AddExperienceLevelLoadingState(),
    );
    final result = await sendExperienceLevelUseCase.call(
        SendExperienceLevelParams(
            typeID: event.typeID, jobLevelId: event.jobLevelId));
    result.fold(
      (l) => emit(
        AddExperienceLevelSuccessState(
          message: StringManager.loginSuccessfully.tr(),
        ),
      ),
      (r) => emit(
        AddExperienceLevelErrorState(
          errorMessage: DioHelper().getTypeOfFailure(r),
        ),
      ),
    );
  }
}
