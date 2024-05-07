import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/features/home/data/model/company_model.dart';

class MatchedVacancyWrapper {
  final MatchedVacancy matchedVacancy;
  final String matchmakingPercentage;

  MatchedVacancyWrapper({
    required this.matchedVacancy,
    required this.matchmakingPercentage,
  });

  factory MatchedVacancyWrapper.fromJson(Map<String, dynamic> json) {
    return MatchedVacancyWrapper(
      matchedVacancy: MatchedVacancy.fromJson(json['matchedVacancy']),
      matchmakingPercentage: json['matchmakingPercentage'] ?? "0.00",
    );
  }
}

class MatchedVacancy {
  final int vacancyId;
  final int vacancyLevelId;
  final String title;
  final String responsibilities;
  final String requirements;
  final DateTime? deadline;
  final int companyId;
  final List<VacancySkill>?
      vacancySkills; // You can define a more specific type here if needed.
  final int? majorId;
  final CompanyModel? company;
  final String? cityName;
  final DateTime? creationDate;
  final DateTime? lastModificationTime;
  final int? creatorUserId;
  final int lastModificationUserId;
  final int deleteStatusId;

  MatchedVacancy({
    required this.vacancyId,
    required this.vacancyLevelId,
    required this.title,
    required this.responsibilities,
    required this.requirements,
    this.deadline,
    required this.companyId,
    this.vacancySkills,
    this.majorId,
    this.company,
    this.cityName,
    this.creationDate,
    this.lastModificationTime,
    this.creatorUserId,
    required this.lastModificationUserId,
    required this.deleteStatusId,
  });

  factory MatchedVacancy.fromJson(Map<String, dynamic> json) {
    return MatchedVacancy(
      vacancyId: json['vacancyId'] ?? 0,
      vacancyLevelId: json['vacancyLevelId'] ?? 0,
      title: json['title'] ?? 'Unknown title',
      responsibilities: json['responsbilities'] ?? 'No responsibilities listed',
      requirements: json['requirements'] ?? 'No requirements listed',
      deadline:
          json['deadline'] != null ? DateTime.parse(json['deadline']) : null,
      companyId: json['companyId'] ?? 0,
      vacancySkills: json['vacancySkills'] != null
          ? (json['vacancySkills'] as List)
              .map((i) => VacancySkill.fromJson(i))
              .toList()
          : null,
      majorId: json['majorId'] as int?,
      company:
          json['company'] != null ? CompanyModel.fromJson(json['company']) : null,
      cityName:
          // json['cityId']  ??
          'Unknown city',
      creationDate: json['creationDate'] != null
          ? DateTime.parse(json['creationDate'])
          : null,
      lastModificationTime: json['lastModificationTime'] != null
          ? DateTime.parse(json['lastModificationTime'])
          : null,
      creatorUserId: json['creatorUserId'] as int?,
      lastModificationUserId: json['lastModificationUserId'] ?? 0,
      deleteStatusId: json['deleteStatusId'] ?? 0,
    );
  }
}

class VacancySkill {
  final int? vacancySkillId;
  final int? vacancyId;
  final int? skillId;
  final String?
      skill; // Assuming `skill` is a complex type or just not well-defined yet

  VacancySkill({
    this.vacancySkillId,
    this.vacancyId,
    this.skillId,
    this.skill,
  });

  factory VacancySkill.fromJson(Map<String, dynamic> json) {
    return VacancySkill(
      vacancySkillId: json['vacancySkillId'] ?? 0,
      vacancyId: json['vacancyId'] ?? 0,
      skillId: json['skillId'] ?? 0,
      skill: json['skill']['skillNameEn'] ??
          "", // handle according to the data structure of `skill`
    );
  }
}
