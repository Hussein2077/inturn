import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/base_use_case/base_use_case.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/profile/domain/use_case/get_pdf_uc.dart';
import 'package:inturn/features/profile/presentation/controller/get_pdf/event.dart';
import 'package:inturn/features/profile/presentation/controller/get_pdf/state.dart';

class GetPdfBloc extends Bloc<BaseGetPdfEvent, GetPdfState> {
  GetPDFUseCase getPDFUseCase;

  GetPdfBloc({required this.getPDFUseCase}) : super(GetPdfInitial()) {

    on<GetPdfEvent>((event, emit) async {
      log('111111111111111');
      emit(  GetPdfLoadingState());
      final result = await getPDFUseCase.call(const NoParameter());
      log('assssssssssssss');
      result.fold(
              (l) => emit(GetPdfSuccessMessageState(filePath: l)),
              (r) => emit(GetPdfErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });

  }
}
