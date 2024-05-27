import 'package:equatable/equatable.dart';
import 'dart:io';

abstract class PdfUploadEvent extends Equatable {
  const PdfUploadEvent();
}

class UploadPdf extends PdfUploadEvent {
  final File file;
  final int type;
  const UploadPdf({  required this.file, this.type = 1});

  @override
  List<Object> get props => [file];
}
