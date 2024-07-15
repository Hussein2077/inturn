import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/main.dart';

class ConstantApi {
  static const String baseUrl = 'https://api.intrn.app/Intrn/api/';

  static getImage(String url) => 'https://api.intrn.app/Intrn/Images/$url';

  static getPdf(String url) => 'https://api.intrn.app/Intrn/UsersCVs/$url';

  static const String login = "${baseUrl}NewAuth/LoginWithPhone";
  static const String deleteAccount = "${baseUrl}NewUserProfiles/DeleteUserProfileByUserId";
  static const String signUp = "${baseUrl}NewAuth/phone-signup";
  static const String sendCode = "${baseUrl}NewAuth/generate-phone-otp";
  static const String sendCodeToEmail =
      "${baseUrl}NewAuth/generate-otp-Register";
  static const String verifyCode = "${baseUrl}NewAuth/validate-otp-register";

  static const String universities = "${baseUrl}Universities/GetAllUniversity";
  static const String uploadPdf = "${baseUrl}UploadCV/upload-cv";
  static const String updatePdf = "${baseUrl}UploadCV/updateUserCV";

  static String faculty(int id) => "${baseUrl}Faculties/GetFacultiesBy$id";

  static String getAreas(int id) =>
      "${baseUrl}Areas/GetAreaByCityId?cityId=$id";
  static const String provinces = "${baseUrl}Countries/GetAllCountriesIncluded";
  static const String getMajorsByCategory =
      "${baseUrl}Majors/GetAllMajorsAsyncGroupedByCategory";

  static String vacancyDetails(int id) => "${baseUrl}vacancyDetails$id";

  static String getVacancy(String id) =>
      "${baseUrl}UserProfiles/SuggestedJobsForUser/$id";

  static String myApplications(String userId) =>
      "${baseUrl}applications/GetMyApplicationsByUserId?userId=$userId";

  static const String myData = "${baseUrl}NewAuth/UserData";

  static String getCV(String id) => "${baseUrl}UploadCV/getUserCV$id";

  static const String complete = "${baseUrl}NewAuth/complete";
  static const String getCompanies = "${baseUrl}Companies/GetAllCompanies";

  static String editProfileData() =>
      "${baseUrl}UserProfiles/EditUserProfileByUserId";

  static const String getGetInternshipsBySearch =
      '${baseUrl}Vacancies/SearchVacancies';

//add personal info
  static String addPersonalInfo() => "${baseUrl}UserProfiles/AddFormUserInfo";

  static String sendUniversityFacultyIds(
    String id,
  ) =>
      "${baseUrl}UserProfiles/EditFormEducation?userId=$id";

  static String sendLocationTypeIds(
    String id,
  ) =>
      "${baseUrl}UserProfiles/EditFormLocation?userId=$id";

  static String sendExperienceLevel(
    String id,
  ) =>
      "${baseUrl}UserProfiles/EditFormExperience?userId=$id";

  static String sendMajorIds(
    String id,
  ) =>
      "${baseUrl}UserProfiles/EditFormMajors?userId=$id";

  static String sendSkills(
    String id,
  ) =>
      "${baseUrl}UserProfiles/EditFormSkills?userId=$id";

  static String getMyData(String id) =>
      "${baseUrl}UserProfiles/GetUserProfileByUserId?userId=$id";
  static const String getSkill = "${baseUrl}Skills/GetAllSkills";

  static String apply(String userId, int vacancyId) =>
      "${baseUrl}applications/apply?userId=${MyApp.userId}&vacancyId=$vacancyId";

//////////////////////////////////////////////////////////////////////
  static const String getJobs = "${baseUrl}Jobs/GetVacancy";
  static const String getGetInternships = "${baseUrl}Jobs/GetInternships";

  static const String resetPassword = "${baseUrl}Auth/reset-password-with-otp";
  static const String changePassword = "${baseUrl}Auth/Change-password";
  static const String googleRegister = "https://api.inturn.app/GLogin";
  static const String email = "email";
  static const String password = "password";
}
