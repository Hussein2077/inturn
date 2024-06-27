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
  final SendLocationTypeUseCase sendLocationTypeUseCase;
  final SendMajorIDUseCase sendMajorIDUseCase;
  final SendSkillsIDUseCase sendSkillsIDUseCase;

  AddPersonalInfoBloc(
      {required this.addPersonalInfoUseCase,
      required this.sendUniversityFacultyIdsUseCase,
      required this.sendLocationTypeUseCase,
      required this.sendMajorIDUseCase,
      required this.sendSkillsIDUseCase,
      required this.sendExperienceLevelUseCase})
      : super(AddPersonalInfoInitial()) {
    on<AddPersonalInfoButtonPressedEvent>(addPersonalInfo);
    on<AddUniversityAndFacultiesEvent>(addUniversityAndFaculties);
    on<SendExperienceLevelEvent>(sendExperienceLevel);
    on<SendLocationEvent>(sendLocationTypeLevel);
    on<SendMajorIdEvent>(sendMajorIdLevel);
  }

  addPersonalInfo(event, emit) async {
    emit(
      AddPersonalInfoLoadingState(),
    );
    final result = await addPersonalInfoUseCase.call(PersonalInfoParams(
        image: event.image,
        userId: event.userID,
        firstName: event.firstName,
        address:  event.address,
        email:  event.email,
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

  sendLocationTypeLevel(event, emit) async {
    emit(
      AddLocationTypeLoadingState(),
    );
    final result = await sendLocationTypeUseCase.call(LocationTypeParams(
      cityID: event.cityID,
      countryID: event.countryID,
      locationTypeID: event.locationTypeID,
    ));
    result.fold(
      (l) => emit(
        AddLocationTypeSuccessState(
          message: StringManager.loginSuccessfully.tr(),
        ),
      ),
      (r) => emit(
        AddLocationTypeErrorState(
          errorMessage: DioHelper().getTypeOfFailure(r),
        ),
      ),
    );
  }

  sendMajorIdLevel(event, emit) async {
    emit(
      AddMajorIdLoadingState(),
    );
    final result = await sendMajorIDUseCase.call(event.majorIds);
    result.fold(
      (l) => emit(
        AddMajorIdSuccessState(
          message: StringManager.loginSuccessfully.tr(),
        ),
      ),
      (r) => emit(
        AddMajorIdErrorState(
          errorMessage: DioHelper().getTypeOfFailure(r),
        ),
      ),
    );
  }

}
