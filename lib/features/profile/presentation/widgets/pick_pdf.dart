import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/features/profile/presentation/controller/upload_p_d_f/bloc.dart';
import 'package:inturn/features/profile/presentation/controller/upload_p_d_f/event.dart';
import 'package:inturn/features/profile/presentation/controller/upload_p_d_f/state.dart';

class PdfUploadForm extends StatefulWidget {
  const PdfUploadForm({super.key});

  @override
  State<PdfUploadForm> createState() => _PdfUploadFormState();
}

class _PdfUploadFormState extends State<PdfUploadForm> {
  FilePickerResult? result;
  @override
  Widget build(BuildContext context) {
    return BlocListener<PdfUploadBloc, PdfUploadState>(
      listener: (context, state) {
        if (state is PdfUploading) {
          EasyLoading.show();
        } else if (state is PdfUploadSuccess) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess(state.message);
        } else if (state is PdfUploadFailure) {
          EasyLoading.dismiss();
          EasyLoading.showError(state.error);
        }
      },
      child: MainButton(
        text:result == null ? StringManager.uploadCV.tr() : result!.files.single.name ,
        textColor: Colors.black,
        color: AppColors.lightGreyColor,
        fontWeight: FontWeight.bold,
        onTap: () async {
         result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['pdf'],
          );
          if (mounted) {
            if (result != null) {
              File file = File(result!.files.single.path!);
              BlocProvider.of<PdfUploadBloc>(context).add(UploadPdf(file));
            }
          }
          setState(() {
          });
        },
      ),
    );
  }
}
