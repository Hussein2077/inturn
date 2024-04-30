class CompanyModel {
  CompanyModel({
      this.companyId, 
      this.companyName, 
      this.bio, 
      this.countOfEmployees, 
      this.foundationYear, 
      this.webSite, 
      this.facebookLink, 
      this.instagramLink, 
      this.xLink, 
      this.linkedInLink, 
      this.profileLogo, 
      this.coverLogo, 
      this.jobs, 
      this.userId, 
      this.subscriptionPlanId, 
      this.majorId, 
      this.creationDate, 
      this.lastModificationTime, 
      this.creatorUserId, 
      this.lastModificationUserId, 
      this.deleteStatusId,});

  CompanyModel.fromJson(dynamic json) {
    companyId = json['companyId'];
    companyName = json['companyName'];
    bio = json['bio'];
    countOfEmployees = json['countOfEmployees'];
    foundationYear = json['foundationYear'];
    webSite = json['webSite'];
    facebookLink = json['facebookLink'];
    instagramLink = json['instagramLink'];
    xLink = json['xLink'];
    linkedInLink = json['linkedInLink'];
    profileLogo = json['profileLogo'];
    coverLogo = json['coverLogo'];
    jobs = json['jobs'];
    userId = json['userId'];
    subscriptionPlanId = json['subscriptionPlanId'];
    majorId = json['majorId'];
    creationDate = json['creationDate'];
    lastModificationTime = json['lastModificationTime'];
    creatorUserId = json['creatorUserId'];
    lastModificationUserId = json['lastModificationUserId'];
    deleteStatusId = json['deleteStatusId'];
  }
  int? companyId;
  String? companyName;
  String? bio;
  String? countOfEmployees;
  String? foundationYear;
  dynamic webSite;
  dynamic facebookLink;
  dynamic instagramLink;
  dynamic xLink;
  dynamic linkedInLink;
  dynamic profileLogo;
  dynamic coverLogo;
  dynamic jobs;
  String? userId;
  dynamic subscriptionPlanId;
  dynamic majorId;
  String? creationDate;
  String? lastModificationTime;
  String? creatorUserId;
  int? lastModificationUserId;
  int? deleteStatusId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['companyId'] = companyId;
    map['companyName'] = companyName;
    map['bio'] = bio;
    map['countOfEmployees'] = countOfEmployees;
    map['foundationYear'] = foundationYear;
    map['webSite'] = webSite;
    map['facebookLink'] = facebookLink;
    map['instagramLink'] = instagramLink;
    map['xLink'] = xLink;
    map['linkedInLink'] = linkedInLink;
    map['profileLogo'] = profileLogo;
    map['coverLogo'] = coverLogo;
    map['jobs'] = jobs;
    map['userId'] = userId;
    map['subscriptionPlanId'] = subscriptionPlanId;
    map['majorId'] = majorId;
    map['creationDate'] = creationDate;
    map['lastModificationTime'] = lastModificationTime;
    map['creatorUserId'] = creatorUserId;
    map['lastModificationUserId'] = lastModificationUserId;
    map['deleteStatusId'] = deleteStatusId;
    return map;
  }

}