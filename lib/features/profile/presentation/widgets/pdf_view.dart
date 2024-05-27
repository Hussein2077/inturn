import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/widgets/loading_widget.dart';

class PdfView extends StatelessWidget {
  const PdfView({super.key, required this.document});
final PDFDocument  document;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  PDFViewer(
        document:  document,
       progressIndicator: const LoadingWidget(),
        lazyLoad: false,
        zoomSteps: 1,
        numberPickerConfirmWidget: const Text(
        "Confirm",
    ),    ));
  }
}
