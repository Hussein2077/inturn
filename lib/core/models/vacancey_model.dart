import 'package:inturn/features/home/data/model/company_model.dart';

class VacancyModel {
  final int? vacancyId;
  final int? vacancyLevelId;
  final String? title;
  final String? responsibilities;
  final String? requirements;
  final String? description;
  final DateTime? deadline;
  final int? companyId;
  final CompanyModel? company;
  final int? majorId;
  final int? countryId;
  final String? cityName;

  VacancyModel({
     this.vacancyId,
     this.vacancyLevelId,
     this.title,
     this.responsibilities,
     this.requirements,
    this.deadline,
      this.companyId,
    this.description,
    this.company,
    this.majorId,
    this.countryId,
    this.cityName,
  });

  factory VacancyModel.fromJson(Map<String, dynamic> json) {
    return VacancyModel(
      vacancyId: json['vacancyId'] ?? 0,
      vacancyLevelId: json['vacancyLevelId'] ?? 0,
      title: json['title'] ?? 'Unknown title',
      responsibilities: json['responsbilities'] ?? 'No responsibilities listed',
      requirements: json['requirements'] ?? 'No requirements listed',
      description: json['description'] ?? 'No description',
      deadline: json['deadline'] != null ? DateTime.parse(json['deadline']) : null,
      companyId: json['companyId'] ?? 0,
      company: json['company'] != null ? CompanyModel.fromJson(json['company']) : null,
      majorId: json['majorId'] as int?,
      countryId: json['countryId'] as int?,
      cityName:
      json['city'] == null
          ? 'Unknown city'
          : json['country'] == null
          ? 'Unknown city'
          : (json['city']['cityNameEn'] +
          ',' +
          json['country']['countryNameEn'] ??
          'Unknown city'),

    );
  }
}

class VacancySearch {
  final String? title;
  final int? companyId;
  final int? cityId;
  final int? countryId;
  final int? vacancyLevelId;
  final String? userId;
  VacancySearch({
    this.title,
    this.companyId,
    this.cityId,
    this.countryId,
    this.vacancyLevelId,
    this.userId,
  });
}class VacancyApply{
  final int vacancyID;
  final String userID;


  VacancyApply({
    required this.vacancyID,
    required this.userID,
  });
}