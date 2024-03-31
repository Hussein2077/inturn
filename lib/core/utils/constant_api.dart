class ConstantApi {
  static const String baseUrl =
      'https://api.inturn.app/api/';
  static   getImage(String url)=>'https://api.inturn.app/api/$url';

   static const String myData = "${baseUrl}my-data";
  static const String getJobs = "${baseUrl}Jobs/GetVacancy";
  static const String apply = "${baseUrl}Apply";

  static const String getGetInternships = "${baseUrl}Jobs/GetInternships";
  static const String getGetInternshipsBySearch = "${baseUrl}Jobs/GetInternships";
  static const String myApplications = "${baseUrl}Apply/Myapplications";

  static const String login = "https://api.inturn.app/Login";
  static const String signUp = "https://api.inturn.app/Register";
  static const String sendCode = "${baseUrl}auth/sendPasswordResetEmail";
  static const String verifyCode = "${baseUrl}auth/verifyCode";
  static const String changePassword = "${baseUrl}auth/changePassword";
  static const String majors = "${baseUrl}Majors";
  static const String provinces = "${baseUrl}Provinces";
  static const String universities = "${baseUrl}Universities";
  static const String blogs = "${baseUrl}blogs";
  static const String googleRegister = "https://api.inturn.app/GLogin";
  static const String email = "email";
  static const String password = "password";
}
