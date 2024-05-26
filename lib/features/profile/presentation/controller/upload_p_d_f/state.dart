
import 'package:equatable/equatable.dart';

abstract class PdfUploadState extends Equatable {
  const PdfUploadState();

  @override
  List<Object> get props => [];
}

class PdfUploadInitial extends PdfUploadState {}

class PdfUploading extends PdfUploadState {}

class PdfUploadSuccess extends PdfUploadState {
  final String message;
  const PdfUploadSuccess( this.message);
}

class PdfUploadFailure extends PdfUploadState {
  final String error;

  const PdfUploadFailure(this.error);

  @override
  List<Object> get props => [error];
}
