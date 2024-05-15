import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/main.dart';

class ConstantApi {
  static const String baseUrl = 'https://api.intrn.app/Intrn/api/';

  static getImage(String url) => 'https://api.intrn.app/Intrn/uploads/$url';

  static const String login = "${baseUrl}Auth/Login";
  static const String universities = "${baseUrl}Universities/GetAllUniversity";

  static String faculty(int id) => "${baseUrl}Faculties/GetFacultiesBy$id";
  static const String provinces = "${baseUrl}Countries/GetAllCountriesIncluded";
  static const String getMajorsByCategory =
      "${baseUrl}Majors/GetAllMajorsAsyncGroupedByCategory";

  static String vacancyDetails(int id) => "${baseUrl}vacancyDetails$id";

  static String getVacancy(String id) =>
      "${baseUrl}UserProfiles/SuggestedJobsForUser/$id";
  static const String myApplications = "${baseUrl}Apply/Myapplications";

  static String myData(String id) => "${baseUrl}Auth/UserData?userId=$id";

  static String complete(String id) => "${baseUrl}Auth/complete?userId=$id";
  static const String getCompanies = "${baseUrl}Companies/GetAllCompanies";

  static String editProfileData() =>
      "${baseUrl}UserProfiles/EditUserProfileByUserId";
  //https://api.intrn.app/Intrn/api/UserProfiles/EditUserProfileByUserId
  static String sendUniversityFacultyIds(String id, int userprofileId) =>
      "${baseUrl}UserProfiles/EditFormEducation?userId=$id&userProfileId=$userprofileId";

  static String sendLocationTypeIds(String id, int userprofileId) =>
      "${baseUrl}UserProfiles/EditFormLocation?userId=$id&userProfileId=$userprofileId";
  static String sendExperienceLevel (String id, int userprofileId) =>
      "${baseUrl}UserProfiles/EditFormExperience?userId=$id&userProfileId=$userprofileId";

  static String sendMajorIds(String id, int userprofileId) =>
      "${baseUrl}UserProfiles/EditFormMajors?userId=$id&userProfileId=$userprofileId";

  static String sendSkills(String id, int userprofileId) =>
      "${baseUrl}UserProfiles/EditFormSkills?userId=$id&userProfileId=$userprofileId";

  static const String getGetInternshipsBySearch =
      '${baseUrl}Vacancies/SearchVacancies';

//add personal info
  static String addPersonalInfo() => "${baseUrl}UserProfiles/AddFormUserInfo";

  static String getMyData(String id) =>
      "${baseUrl}UserProfiles/GetUserProfileByUserId?userId=$id";
  static const String getSkill = "${baseUrl}Skills/GetAllSkills";

  static String apply(String userId, int vacancyId) =>
      "${baseUrl}applications/apply?userId=${MyApp.userId}&vacancyId=$vacancyId";

//////////////////////////////////////////////////////////////////////
  static const String getJobs = "${baseUrl}Jobs/GetVacancy";
  static const String getGetInternships = "${baseUrl}Jobs/GetInternships";

  static const String signUp = "https://api.inturn.app/Register";
  static const String sendCode = "${baseUrl}auth/sendPasswordResetEmail";
  static const String verifyCode = "${baseUrl}auth/verifyCode";
  static const String changePassword = "${baseUrl}auth/changePassword";
  static const String googleRegister = "https://api.inturn.app/GLogin";
  static const String email = "email";
  static const String password = "password";
}
