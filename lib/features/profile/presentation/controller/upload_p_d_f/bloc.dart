import 'package:bloc/bloc.dart';
import 'package:inturn/core/utils/api_helper.dart';
import 'package:inturn/features/profile/domain/use_case/upload_pdf.dart';
import 'package:inturn/features/profile/presentation/controller/upload_p_d_f/event.dart';
import 'package:inturn/features/profile/presentation/controller/upload_p_d_f/state.dart';

class PdfUploadBloc extends Bloc<PdfUploadEvent, PdfUploadState> {
  final UploadPDFUseCase uploadPdfUseCase;

  PdfUploadBloc(this.uploadPdfUseCase) : super(PdfUploadInitial()) {
    on<UploadPdf>((event, emit) async {
      emit(PdfUploading());
      final result = await uploadPdfUseCase.call(event.file);
      result.fold((l) => emit(PdfUploadSuccess(l)),
          (r) => emit(PdfUploadFailure(DioHelper().getTypeOfFailure(r))));
    });
  }
}
