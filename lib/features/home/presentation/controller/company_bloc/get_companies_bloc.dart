import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/home/domain/use_case/companies_uc.dart';
import 'package:inturn/features/home/presentation/controller/company_bloc/get_companies_event.dart';
import 'package:inturn/features/home/presentation/controller/company_bloc/get_companies_state.dart';

class GetCompaniesBloc extends Bloc<BaseGetCompaniesEvent, GetCompaniesState> {
  GetCompaniesUseCase getCompaniesUseCase;

  GetCompaniesBloc({required this.getCompaniesUseCase}) : super(GetCompaniesInitial()) {
    on<GetCompaniesEvent>((event, emit) async {
      emit(const GetCompaniesLoadingState());
      final result = await getCompaniesUseCase.call(const NoParameter());
      result.fold(
          (l) => emit(GetCompaniesSuccessMessageState(jobModel: l)),
          (r) => emit(GetCompaniesErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
