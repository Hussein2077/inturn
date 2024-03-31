class VacancyModel {
  int? id;
  String? name;
  String? image;
  String? description;
  String? experience;
  int? minSalary;
  int? maxSalary;
  String? createDate;
  String? provinceName;
  int? provinceId;
  String? avatarUrl;
  String? websiteURL;
  String? major;
  String? titleEN;
  String? titleAr;
  String? companyName;
  String? type;

  VacancyModel({
    this.id,
    this.name,
    this.description,
    this.experience,
    this.minSalary,
    this.maxSalary,
    this.createDate,
    this.provinceName,
    this.provinceId,
    this.avatarUrl,
    this.websiteURL,
    this.major,
    this.titleEN,
    this.titleAr,
    this.companyName,
    this.image,
    this.type,
  });

  factory VacancyModel.fromJson(Map<String, dynamic> json) {
    return VacancyModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      image: json['avatarUrl'] ?? "",
      type: json['type'] ?? "Full Time",
      description: json['description'] ?? "",
      experience: json['experience'] ?? "",
      minSalary: json['minSalary']??1000,
      maxSalary: json['maxSalary']??5000,
      createDate: json['createDate']??"",
      provinceName: json['provinceName'] ?? "",
      provinceId: json['provinceId']??0,
      avatarUrl: json['avatarUrl'] ?? "",
      websiteURL: json['websiteURL'] ?? "",
      major: json['major'] ?? "",
      titleEN: json['titleEN'] ?? "",
      titleAr: json['titleAr'] ?? "",
      companyName: json['companyName'] ?? "",
    );
  }
}
class VacancySearch {
  final String? text;
  final String? skill;
  final String? area;
  final int type;

  VacancySearch({
    this.text,
    this.skill,
    this.area,
    required this.type,
  });
}class VacancyApply{
  final String vacancyID;
  final String userID;


  VacancyApply({
    required this.vacancyID,
    required this.userID,
  });
}