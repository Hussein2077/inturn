import 'package:inturn/core/models/vacancey_model.dart';

class ApplicationModel {
  int? newApplicationId;
  int? vacancyId;
  int? applicationStatusId;
  String? userId;
  DateTime? appliedDate;
  VacancyModel? vacancy;
  ApplicationStatus? applicationStatus;

  ApplicationModel({
    this.newApplicationId,
    this.vacancyId,
    this.applicationStatusId,
    this.userId,
    this.appliedDate,
    this.vacancy,
    this.applicationStatus,

  });

  factory ApplicationModel.fromJson(Map<String, dynamic> json) {
    return ApplicationModel(
      newApplicationId: json['newApplicationId'] ??0,
      vacancyId: json['vacancyId'] ??0,
      applicationStatusId: json['applicationStatusId'] ??0,
      userId: json['userId'] as String?,
      appliedDate: json['appliedDate'] != null ? DateTime.parse(json['appliedDate']) : null,
      vacancy: json['vacancy'] != null ? VacancyModel.fromJson(json['vacancy']) : null,
      applicationStatus: json['applicationStatus'] != null ? ApplicationStatus.fromJson(json['applicationStatus']) : null,

    );
  }
}
class ApplicationStatus {
  int? applicationStatusId;
  String? nameEn;
  String? nameAr;

  ApplicationStatus({
    this.applicationStatusId,
    this.nameEn,
    this.nameAr,
  });

  factory ApplicationStatus.fromJson(Map<String, dynamic> json) {
    return ApplicationStatus(
      applicationStatusId: json['applicationStatusId'] ??1,
      nameEn: json['nameEn'] as String?,
      nameAr: json['nameAr'] as String?,
    );
  }
}