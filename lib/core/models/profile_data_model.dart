import 'package:inturn/features/home/data/model/cities_model.dart';
import 'package:inturn/features/home/data/model/faculty_model.dart';
import 'package:inturn/features/home/data/model/major_model.dart';
import 'package:inturn/features/home/data/model/skill_model.dart';
import 'package:inturn/features/home/data/model/university_model.dart';

// class ProfileDataModel {
//   ProfileDataModel({
//     this.userProfileId,
//     this.jobLevelId,
//     this.graduationStatusId,
//     this.jobLocationTypeId,
//     this.universityId,
//     this.facultyId,
//     this.userId,
//     this.firstName,
//     this.lastName,
//     this.description,
//     this.profileImage,
//     this.user,
//     this.university,
//     this.faculty,
//     this.countryId,
//     this.cityId,
//     this.creationDate,
//     this.lastModificationTime,
//     this.creatorUserId,
//     this.lastModificationUserId,
//     this.deleteStatusId,
//   });
//
//   ProfileDataModel.fromJson(dynamic json) {
//     userProfileId = json['userProfileId'];
//     jobLevelId = json['jobLevelId'];
//     graduationStatusId = json['graduationStatusId'];
//     jobLocationTypeId = json['jobLocationTypeId'];
//     universityId = json['universityId'];
//     facultyId = json['facultyId'];
//     userId = json['userId'];
//     firstName = json['firstName'];
//     lastName = json['lastName'];
//     description = json['description'];
//     profileImage = json['profileImage'];
//     user = json['user'] != null ? User.fromJson(json['user']) : null;
//     university = json['university'] != null
//         ? UniversityModel.fromJson(json['university'])
//         : null;
//     faculty =
//         json['faculty'] != null ? FacultyModel.fromJson(json['faculty']) : null;
//     countryId = json['countryId'];
//     cityId = json['cityId'];
//     creationDate = json['creationDate'];
//     lastModificationTime = json['lastModificationTime'];
//     creatorUserId = json['creatorUserId'];
//     lastModificationUserId = json['lastModificationUserId'];
//     deleteStatusId = json['deleteStatusId'];
//   }
//   int? userProfileId;
//   int? jobLevelId;
//   int? graduationStatusId;
//   int? jobLocationTypeId;
//   int? universityId;
//   int? facultyId;
//   String? userId;
//   String? firstName;
//   String? lastName;
//   dynamic description;
//   dynamic profileImage;
//   User? user;
//   UniversityModel? university;
//   FacultyModel? faculty;
//   dynamic countryId;
//   dynamic cityId;
//   String? creationDate;
//   String? lastModificationTime;
//   String? creatorUserId;
//   int? lastModificationUserId;
//   int? deleteStatusId;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['userProfileId'] = userProfileId;
//     map['jobLevelId'] = jobLevelId;
//     map['graduationStatusId'] = graduationStatusId;
//     map['jobLocationTypeId'] = jobLocationTypeId;
//     map['universityId'] = universityId;
//     map['facultyId'] = facultyId;
//     map['userId'] = userId;
//     map['firstName'] = firstName;
//     map['lastName'] = lastName;
//     map['description'] = description;
//     map['profileImage'] = profileImage;
//     if (user != null) {
//       map['user'] = user?.toJson();
//     }
//     if (university != null) {
//       map['university'] = university?.toJson();
//     }
//     if (faculty != null) {
//       map['faculty'] = faculty?.toJson();
//     }
//     map['countryId'] = countryId;
//     map['cityId'] = cityId;
//     map['creationDate'] = creationDate;
//     map['lastModificationTime'] = lastModificationTime;
//     map['creatorUserId'] = creatorUserId;
//     map['lastModificationUserId'] = lastModificationUserId;
//     map['deleteStatusId'] = deleteStatusId;
//     return map;
//   }
// }
class ProfileDataModel {
  int? userProfileId;
  int? jobLevelId;
  int? graduationStatusId;
  int? jobLocationTypeId;
  int? universityId;
  int? facultyId;
  String? userId;
  String? firstName;
  String? lastName;
  String? description;
  String? profileImage;
  User? user;
  UniversityModel? university;
  FacultyModel? faculty;
  int? countryId;
  int? cityId;
  Country? country;
  CityModel? city;


  ProfileDataModel({
    this.userProfileId,
    this.jobLevelId,
    this.graduationStatusId,
    this.jobLocationTypeId,
    this.universityId,
    this.facultyId,
    this.userId,
    this.firstName,
    this.lastName,
    this.description,
    this.profileImage,
    this.user,
    this.university,
    this.faculty,
    this.countryId,
    this.cityId,
    this.country,
    this.city,

  });

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) {
    return ProfileDataModel(
      userProfileId: json['userProfileId'] ??0,
      jobLevelId: json['jobLevelId'] ??1,
      graduationStatusId: json['graduationStatusId'] ??1,
      jobLocationTypeId: json['jobLocationTypeId'] ??1,
      universityId: json['universityId'] ??1,
      facultyId: json['facultyId'] ??1,
      userId: json['userId'] ??"",
      firstName: json['firstName'] ??"",
      lastName: json['lastName'] ??"",
      description: json['description'] ??"",
      profileImage: json['profileImage'] ??"",
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      university: json['university'] != null
          ? UniversityModel.fromJson(json['university'])
          : null,
      faculty:
      json['faculty'] != null ? FacultyModel.fromJson(json['faculty']) : null,
      countryId: json['countryId'] ??0,
      cityId: json['cityId'] ??0,
      country: json['country'] != null ? Country.fromJson(json['country']) : null,
      city: json['city'] != null ? CityModel.fromJson(json['city']) : null,
    );
  }
}

class User {
  String? socicaID;
  bool? isCompleted;
  int? completion;
  List<UserSkill>? userSkills;
  List<UserMajor>? userMajors;
  dynamic applications;
  dynamic companies;
  String? id;
  String? userName;
  String? normalizedUserName;
  String? email;
  String? normalizedEmail;
  bool? emailConfirmed;
  String? passwordHash;
  String? securityStamp;
  String? concurrencyStamp;
  dynamic phoneNumber;
  bool? phoneNumberConfirmed;
  bool? twoFactorEnabled;
  dynamic lockoutEnd;
  bool? lockoutEnabled;
  int? accessFailedCount;

  User({
    this.socicaID,
    this.isCompleted,
    this.completion,
    this.userSkills,
    this.userMajors,
    this.applications,
    this.companies,
    this.id,
    this.userName,
    this.normalizedUserName,
    this.email,
    this.normalizedEmail,
    this.emailConfirmed,
    this.passwordHash,
    this.securityStamp,
    this.concurrencyStamp,
    this.phoneNumber,
    this.phoneNumberConfirmed,
    this.twoFactorEnabled,
    this.lockoutEnd,
    this.lockoutEnabled,
    this.accessFailedCount,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      socicaID: json['socicaID'],
      isCompleted: json['isCompleted'],
      completion: json['complition'],
      userSkills: (json['userSkills'] as List<dynamic>?)
          ?.map((skill) => UserSkill.fromJson(skill))
          .toList(),
      userMajors: (json['userMajors'] as List<dynamic>?)
          ?.map((major) => UserMajor.fromJson(major))
          .toList(),
      applications: json['applications'],
      companies: json['companies'],
      id: json['id'],
      userName: json['userName'],
      normalizedUserName: json['normalizedUserName'],
      email: json['email'],
      normalizedEmail: json['normalizedEmail'],
      emailConfirmed: json['emailConfirmed'],
      passwordHash: json['passwordHash'],
      securityStamp: json['securityStamp'],
      concurrencyStamp: json['concurrencyStamp'],
      phoneNumber: json['phoneNumber'],
      phoneNumberConfirmed: json['phoneNumberConfirmed'],
      twoFactorEnabled: json['twoFactorEnabled'],
      lockoutEnd: json['lockoutEnd'],
      lockoutEnabled: json['lockoutEnabled'],
      accessFailedCount: json['accessFailedCount'],
    );
  }
}



class UserSkill {
  int? userSkillId;
  int? skillId;
  String? userId;
  Skill? skill;

  UserSkill({
    this.userSkillId,
    this.skillId,
    this.userId,
    this.skill,
  });

  factory UserSkill.fromJson(Map<String, dynamic> json) {
    return UserSkill(
      userSkillId: json['userSkillId'],
      skillId: json['skillId'],
      userId: json['userId'],
      skill: Skill.fromJson(json['skill']),
    );
  }
}

class UserMajor {
  int? userMajorId;
  int? majorId;
  String? userId;
  Major? major;

  UserMajor({
    this.userMajorId,
    this.majorId,
    this.userId,
    this.major,
  });

  factory UserMajor.fromJson(Map<String, dynamic> json) {
    return UserMajor(
      userMajorId: json['userMajorId'],
      majorId: json['majorId'],
      userId: json['userId'],
      major: Major.fromJson(json['major']),
    );
  }
}

class Skill {
  int? skillId;
  String? skillNameEn;
  String? skillNameAr;
  String? creationDate;
  String? lastModificationTime;
  String? creatorUserId;
  int? lastModificationUserId;
  int? deleteStatusId;

  Skill({
    this.skillId,
    this.skillNameEn,
    this.skillNameAr,
    this.creationDate,
    this.lastModificationTime,
    this.creatorUserId,
    this.lastModificationUserId,
    this.deleteStatusId,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      skillId: json['skillId'],
      skillNameEn: json['skillNameEn'],
      skillNameAr: json['skillNameAr'],
      creationDate: json['creationDate'],
      lastModificationTime: json['lastModificationTime'],
      creatorUserId: json['creatorUserId'],
      lastModificationUserId: json['lastModificationUserId'],
      deleteStatusId: json['deleteStatusId'],
    );
  }
}

class Major {
  int? majorId;
  String? majorNameEn;
  String? majorNameAr;
  String? majorRank;
  int? majorCategoryId;
  String? creationDate;
  String? lastModificationTime;
  String? creatorUserId;
  int? lastModificationUserId;
  int? deleteStatusId;

  Major({
    this.majorId,
    this.majorNameEn,
    this.majorNameAr,
    this.majorRank,
    this.majorCategoryId,
    this.creationDate,
    this.lastModificationTime,
    this.creatorUserId,
    this.lastModificationUserId,
    this.deleteStatusId,
  });

  factory Major.fromJson(Map<String, dynamic> json) {
    return Major(
      majorId: json['majorId'],
      majorNameEn: json['majorNameEn'],
      majorNameAr: json['majorNameAr'],
      majorRank: json['majorRank'],
      majorCategoryId: json['majorCategoryId'],
      creationDate: json['creationDate'],
      lastModificationTime: json['lastModificationTime'],
      creatorUserId: json['creatorUserId'],
      lastModificationUserId: json['lastModificationUserId'],
      deleteStatusId: json['deleteStatusId'],
    );
  }
}