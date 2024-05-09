import 'package:inturn/features/home/data/model/faculty_model.dart';
import 'package:inturn/features/home/data/model/major_model.dart';
import 'package:inturn/features/home/data/model/skill_model.dart';
import 'package:inturn/features/home/data/model/university_model.dart';

class ProfileDataModel {
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
    this.creationDate,
    this.lastModificationTime,
    this.creatorUserId,
    this.lastModificationUserId,
    this.deleteStatusId,
  });

  ProfileDataModel.fromJson(dynamic json) {
    userProfileId = json['userProfileId'];
    jobLevelId = json['jobLevelId'];
    graduationStatusId = json['graduationStatusId'];
    jobLocationTypeId = json['jobLocationTypeId'];
    universityId = json['universityId'];
    facultyId = json['facultyId'];
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    description = json['description'];
    profileImage = json['profileImage'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    university = json['university'] != null
        ? UniversityModel.fromJson(json['university'])
        : null;
    faculty =
        json['faculty'] != null ? FacultyModel.fromJson(json['faculty']) : null;
    countryId = json['countryId'];
    cityId = json['cityId'];
    creationDate = json['creationDate'];
    lastModificationTime = json['lastModificationTime'];
    creatorUserId = json['creatorUserId'];
    lastModificationUserId = json['lastModificationUserId'];
    deleteStatusId = json['deleteStatusId'];
  }
  int? userProfileId;
  int? jobLevelId;
  int? graduationStatusId;
  int? jobLocationTypeId;
  int? universityId;
  int? facultyId;
  String? userId;
  String? firstName;
  String? lastName;
  dynamic description;
  dynamic profileImage;
  User? user;
  UniversityModel? university;
  FacultyModel? faculty;
  dynamic countryId;
  dynamic cityId;
  String? creationDate;
  String? lastModificationTime;
  String? creatorUserId;
  int? lastModificationUserId;
  int? deleteStatusId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userProfileId'] = userProfileId;
    map['jobLevelId'] = jobLevelId;
    map['graduationStatusId'] = graduationStatusId;
    map['jobLocationTypeId'] = jobLocationTypeId;
    map['universityId'] = universityId;
    map['facultyId'] = facultyId;
    map['userId'] = userId;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['description'] = description;
    map['profileImage'] = profileImage;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (university != null) {
      map['university'] = university?.toJson();
    }
    if (faculty != null) {
      map['faculty'] = faculty?.toJson();
    }
    map['countryId'] = countryId;
    map['cityId'] = cityId;
    map['creationDate'] = creationDate;
    map['lastModificationTime'] = lastModificationTime;
    map['creatorUserId'] = creatorUserId;
    map['lastModificationUserId'] = lastModificationUserId;
    map['deleteStatusId'] = deleteStatusId;
    return map;
  }
}

class User {
  User({
    this.socicaID,
    this.isCompleted,
    this.complition,
    this.refreshTokens,
    this.skills,
    this.majors,
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

  User.fromJson(dynamic json) {
    socicaID = json['socicaID'];
    isCompleted = json['isCompleted'];
    complition = json['complition'];
    if (json['refreshTokens'] != null) {
      refreshTokens = [];
      json['refreshTokens'].forEach((v) {
        refreshTokens?.add(RefreshTokens.fromJson(v));
      });
    }
    if (json['skills'] != null) {
      skills = [];
      json['skills'].forEach((v) {
        skills?.add(Skills.fromJson(v));
      });
    }
    if (json['majors'] != null) {
      majors = [];
      json['majors'].forEach((v) {
        majors?.add(Position.fromJson(v));
      });
    }
    applications = json['applications'];
    companies = json['companies'];
    id = json['id'];
    userName = json['userName'];
    normalizedUserName = json['normalizedUserName'];
    email = json['email'];
    normalizedEmail = json['normalizedEmail'];
    emailConfirmed = json['emailConfirmed'];
    passwordHash = json['passwordHash'];
    securityStamp = json['securityStamp'];
    concurrencyStamp = json['concurrencyStamp'];
    phoneNumber = json['phoneNumber'];
    phoneNumberConfirmed = json['phoneNumberConfirmed'];
    twoFactorEnabled = json['twoFactorEnabled'];
    lockoutEnd = json['lockoutEnd'];
    lockoutEnabled = json['lockoutEnabled'];
    accessFailedCount = json['accessFailedCount'];
  }
  dynamic socicaID;
  bool? isCompleted;
  int? complition;
  List<RefreshTokens>? refreshTokens;
  List<Skills>? skills;
  List<Position>? majors;
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['socicaID'] = socicaID;
    map['isCompleted'] = isCompleted;
    map['complition'] = complition;
    if (refreshTokens != null) {
      map['refreshTokens'] = refreshTokens?.map((v) => v.toJson()).toList();
    }
    if (skills != null) {
      map['skills'] = skills?.map((v) => v.toJson()).toList();
    }
    if (majors != null) {
      map['majors'] = majors?.map((v) => v.toJson()).toList();
    }
    map['applications'] = applications;
    map['companies'] = companies;
    map['id'] = id;
    map['userName'] = userName;
    map['normalizedUserName'] = normalizedUserName;
    map['email'] = email;
    map['normalizedEmail'] = normalizedEmail;
    map['emailConfirmed'] = emailConfirmed;
    map['passwordHash'] = passwordHash;
    map['securityStamp'] = securityStamp;
    map['concurrencyStamp'] = concurrencyStamp;
    map['phoneNumber'] = phoneNumber;
    map['phoneNumberConfirmed'] = phoneNumberConfirmed;
    map['twoFactorEnabled'] = twoFactorEnabled;
    map['lockoutEnd'] = lockoutEnd;
    map['lockoutEnabled'] = lockoutEnabled;
    map['accessFailedCount'] = accessFailedCount;
    return map;
  }
}

class Skills {
  Skills({
    this.skillId,
    this.skillNameEn,
    this.skillNameAr,
    this.vacancySkill,
  });

  Skills.fromJson(dynamic json) {
    skillId = json['skillId'];
    skillNameEn = json['skillNameEn'];
    skillNameAr = json['skillNameAr'];
    vacancySkill = json['skill']  == null ? null : SkillModel.fromJson(json['vacancySkill']);
  }
  int? skillId;
  String? skillNameEn;
  String? skillNameAr;
  SkillModel? vacancySkill;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['skillId'] = skillId;
    map['skillNameEn'] = skillNameEn;
    map['skillNameAr'] = skillNameAr;
    map['skill'] = vacancySkill;

    return map;
  }
}

class RefreshTokens {
  RefreshTokens({
    this.token,
    this.expiresOn,
    this.isExpired,
    this.createdOn,
    this.revokedOn,
    this.isActive,
  });

  RefreshTokens.fromJson(dynamic json) {
    token = json['token'];
    expiresOn = json['expiresOn'];
    isExpired = json['isExpired'];
    createdOn = json['createdOn'];
    revokedOn = json['revokedOn'];
    isActive = json['isActive'];
  }
  String? token;
  String? expiresOn;
  bool? isExpired;
  String? createdOn;
  dynamic revokedOn;
  bool? isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    map['expiresOn'] = expiresOn;
    map['isExpired'] = isExpired;
    map['createdOn'] = createdOn;
    map['revokedOn'] = revokedOn;
    map['isActive'] = isActive;
    return map;
  }
}
