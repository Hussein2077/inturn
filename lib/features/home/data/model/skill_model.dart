import 'package:equatable/equatable.dart';

class SkillModel extends Equatable {
  final int? skillId;
  final String? skillNameEn;
  final String? skillNameAr;
  final dynamic vacancySkill;

  const SkillModel({
    this.skillId,
    this.skillNameEn,
    this.skillNameAr,
    this.vacancySkill,

  });

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(
      skillId: json['skillId'] ??0,
      skillNameEn: json['skillNameEn'] ??'',
      skillNameAr: json['skillNameAr']??'',
      vacancySkill: json['vacancySkill'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'skillId': skillId,
      'skillNameEn': skillNameEn,
      'skillNameAr': skillNameAr,
      'vacancySkill': vacancySkill,
    };
  }

  @override
  List<Object?> get props => [
    skillId,
    skillNameEn,
    skillNameAr,
    vacancySkill,
  ];
}
