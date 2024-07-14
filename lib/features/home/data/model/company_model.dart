class CompanyModel {
  final int? companyId;
  final String? companyName;
  final String? bio;
  final String? countOfEmployees;
  final String? foundationYear;
  final String? webSite;
  final String? facebookLink;
  final String? instagramLink;
  final String? xLink;
  final String? linkedInLink;
  final String? profileLogo;
  final String? coverLogo;
  final String? userId;
  final int? subscriptionPlanId;
  final int? majorId;
  final int? countryId;
  final String? cityName;
final int ? jobCount;
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
    this.userId,
    this.subscriptionPlanId,
    this.majorId,
    this.countryId,
    this.cityName,
    this.jobCount,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      companyId: json['companyId'] ?? 0,
      companyName: json['companyName'] ?? "",
      bio: json['bio'] ?? "",
      countOfEmployees: json['countOfEmployees'] ?? "",
      foundationYear: json['foundationYear'] ?? "",
      webSite: json['webSite'] ?? "",
      facebookLink: json['facebookLink'] ?? "",
      instagramLink: json['instagramLink'] ?? "",
      xLink: json['xLink'] ?? "",
      linkedInLink: json['linkedInLink'] ?? "",
      profileLogo: json['profileLogo']??"",
      coverLogo: json['coverLogo']??"",
      userId: json['userId'] ?? "",
      subscriptionPlanId: json['subscriptionPlanId'] ?? 0,
      majorId: json['majorId'] as int?,
      countryId: json['countryId'] as int?,
      cityName:
      // json['cityId'] ??
      "Cairo, Egypt",
      jobCount: json['jobCount']??0,
    );
  }

}