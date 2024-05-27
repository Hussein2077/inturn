import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:inturn/core/error/failure.dart';
import 'package:inturn/core/models/my_data_model.dart';
import 'package:inturn/core/models/profile_data_model.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/features/profile/domain/use_case/edit_profile_uc.dart';
import 'package:inturn/features/profile/domain/use_case/upload_pdf.dart';

abstract class BaseRepositoryProfile {
  Future<Either<MyDataModel, Failure>> getMyData( String id);
  Future<Either<MyDataModel, Failure>> completeProfile( String id);
  Future<Either<String, Failure>> editProfileData(EditPersonalInfoParams parameter);
  Future<Either<ProfileDataModel, Failure>> getMyProfileData( String id);
  Future<Either<String, Failure>> uploadPdf(UploadPDFParams uploadPDFParams);
  Future<Either<String, Failure>> getPdf();
}
