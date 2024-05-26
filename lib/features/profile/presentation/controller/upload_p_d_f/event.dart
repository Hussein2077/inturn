import 'package:equatable/equatable.dart';
import 'dart:io';

abstract class PdfUploadEvent extends Equatable {
  const PdfUploadEvent();
}

class UploadPdf extends PdfUploadEvent {
  final File file;

  const UploadPdf(this.file);

  @override
  List<Object> get props => [file];
}
