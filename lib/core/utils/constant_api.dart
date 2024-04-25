class ConstantApi {
  static const String baseUrl =
      'http://128.140.69.196/Intrn/api/';
  static   getImage(String url)=>'https://api.inturn.app/api/$url';

  static const String login = "${baseUrl}Auth/Login";
  static const String universities = "${baseUrl}Universities/GetAllUniversity";
  static   String faculty (int id)=> "${baseUrl}Faculties/GetFacultiesBy$id";
  static const String provinces = "${baseUrl}Countries/GetAllCountriesIncluded";
  static const String getMajorsByCategory = "${baseUrl}Majors/GetAllMajorsAsyncGroupedByCategory";

//////////////////////////////////////////////////////////////////////
  static const String myData = "${baseUrl}my-data";
  static const String getJobs = "${baseUrl}Jobs/GetVacancy";
  static const String apply = "${baseUrl}Apply";

  static const String getGetInternships = "${baseUrl}Jobs/GetInternships";
  static const String getGetInternshipsBySearch = "${baseUrl}Jobs/GetInternships";
  static const String myApplications = "${baseUrl}Apply/Myapplications";

  static const String signUp = "https://api.inturn.app/Register";
  static const String sendCode = "${baseUrl}auth/sendPasswordResetEmail";
  static const String verifyCode = "${baseUrl}auth/verifyCode";
  static const String changePassword = "${baseUrl}auth/changePassword";
  static const String googleRegister = "https://api.inturn.app/GLogin";
  static const String email = "email";
  static const String password = "password";
}
