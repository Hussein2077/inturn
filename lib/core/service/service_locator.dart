import 'package:get_it/get_it.dart';
import 'package:inturn/core/service/navigator_services.dart';
import 'package:inturn/features/auth/data/auth_remote_data_source.dart';
import 'package:inturn/features/auth/data/repo_imp.dart';
import 'package:inturn/features/auth/domain/repo/base_repo.dart';
import 'package:inturn/features/auth/domain/use_case/add_info_uc.dart';
import 'package:inturn/features/auth/domain/use_case/apple_sign.dart';
import 'package:inturn/features/auth/domain/use_case/change_password.dart';
import 'package:inturn/features/auth/domain/use_case/google_sign.dart';
import 'package:inturn/features/auth/domain/use_case/login_with_email_and_password_use_case.dart';
import 'package:inturn/features/auth/domain/use_case/send_code.dart';
import 'package:inturn/features/auth/domain/use_case/sign_up_use_case.dart';
import 'package:inturn/features/auth/domain/use_case/verify_code.dart';
import 'package:inturn/features/auth/presentation/controller/add_info_bloc/add_info_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/add_skill/bloc.dart';
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/login_bloc/login_with_email_and_password_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/sign_in_with_platform_bloc/sign_in_with_platform_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/sign_up_bloc/sign_up_with_email_and_password_bloc.dart';
import 'package:inturn/features/home/data/data%20source/home_remote_data_source.dart';
import 'package:inturn/features/home/data/repo%20imp/repo_imp.dart';
import 'package:inturn/features/home/domain/repo/jobs_base_repo.dart';
import 'package:inturn/features/home/domain/use_case/apply_use_case.dart';
import 'package:inturn/features/home/domain/use_case/companies_uc.dart';
import 'package:inturn/features/home/domain/use_case/get_areas_uc.dart';
import 'package:inturn/features/home/domain/use_case/get_blogs_uc.dart';
import 'package:inturn/features/home/domain/use_case/get_cities.dart';
import 'package:inturn/features/home/domain/use_case/get_major_uc.dart';
import 'package:inturn/features/home/domain/use_case/get_top_jobs.dart';
import 'package:inturn/features/home/domain/use_case/get_university_uc.dart';
import 'package:inturn/features/home/domain/use_case/intern_search_uc.dart';
import 'package:inturn/features/home/domain/use_case/vacancy_details_uc.dart';
import 'package:inturn/features/home/presentation/controller/apply_bloc/get_jobs_bloc.dart';
import 'package:inturn/features/home/presentation/controller/company_bloc/get_companies_bloc.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_bloc.dart';
import 'package:inturn/features/home/presentation/controller/get_major/bloc.dart';
import 'package:inturn/features/home/presentation/controller/get_my_applications/get_my_applications_bloc.dart';
import 'package:inturn/features/home/presentation/controller/intern_search_bloc/get_internships_search_bloc.dart';
import 'package:inturn/features/home/presentation/controller/suggested%20jobs%20in%20company/bloc.dart';
import 'package:inturn/features/home/presentation/controller/suggested/bloc.dart';
import 'package:inturn/features/home/presentation/controller/top_five_and_blogs/get_top_five_bloc.dart';
import 'package:inturn/features/home/presentation/controller/vacancy_details_bloc/bloc.dart';
import 'package:inturn/features/profile/data/data%20source/profile_remote_data_source.dart';
import 'package:inturn/features/profile/data/repo%20imp/repo_imp.dart';
import 'package:inturn/features/profile/domain/repo/profile_base_repo.dart';
import 'package:inturn/features/home/domain/use_case/my_applications_us.dart';
import 'package:inturn/features/profile/domain/use_case/change_password_uc.dart';
import 'package:inturn/features/profile/domain/use_case/edit_profile_uc.dart';
import 'package:inturn/features/profile/domain/use_case/get_my_data_uc.dart';
import 'package:inturn/features/profile/domain/use_case/get_pdf_uc.dart';
import 'package:inturn/features/profile/domain/use_case/get_profile_data_uc.dart';
import 'package:inturn/features/profile/domain/use_case/upload_pdf.dart';
import 'package:inturn/features/profile/presentation/controller/change_password/change_password_bloc.dart';
import 'package:inturn/features/profile/presentation/controller/edit_profile/edit_profile_bloc.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_data/get_my_data_bloc.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_profile_data/get_my_profile_data_bloc.dart';
import 'package:inturn/features/profile/presentation/controller/get_pdf/bloc.dart';
import 'package:inturn/features/profile/presentation/controller/upload_p_d_f/bloc.dart';

final getIt = GetIt.instance;

class ServerLocator {
  Future<void> init() async {
    //bloc

    getIt.registerLazySingleton(() => LoginWithEmailAndPasswordBloc(
        loginWithEmailAndPasswordUseCase: getIt()));
    getIt.registerLazySingleton(
        () => SignInWithPlatformBloc(signInWithGoogleUC: getIt(), signInWithAppleUC: getIt()));
    getIt.registerLazySingleton(() => SignUpWithEmailAndPasswordBloc(
          signUpWithEmailAndPasswordUseCase: getIt(),
        ));
    getIt.registerLazySingleton(() => GetMyDataBloc(
        getMyDataUseCase: getIt(), completeProfileUseCase: getIt()));
    getIt.registerLazySingleton(
        () => GetMyApplicationsBloc(getMyApplicationsUseCase: getIt()));
    getIt.registerLazySingleton(() => OptionsBloc(
          getCitiesUseCase: getIt(),
          getFacultyUseCase: getIt(),
          getUniversityUseCase: getIt(),
          getSkillUseCase: getIt(),
          getAreaUseCase: getIt(),
        ));

    getIt.registerLazySingleton(
        () => GetCompaniesBloc(getCompaniesUseCase: getIt()));
    getIt.registerLazySingleton(() => HomeBloc(getMatchedJobsCase: getIt()));
    getIt.registerLazySingleton(() => GetMajorBloc(getMajorUseCase: getIt()));
    getIt.registerLazySingleton(() => AddPersonalInfoBloc(
        addPersonalInfoUseCase: getIt(),
        sendExperienceLevelUseCase: getIt(),
        sendSkillsIDUseCase: getIt(),
        sendUniversityFacultyIdsUseCase: getIt(),
        sendLocationTypeUseCase: getIt(),
        sendMajorIDUseCase: getIt()));
    getIt.registerLazySingleton(
        () => EditProfileBloc(editPersonalInfoUseCase: getIt()));

    getIt.registerLazySingleton(
        () => GetMyProfileDataBloc(getMyProfileDataUseCase: getIt()));
    getIt.registerLazySingleton(
        () => AddSkillsBloc(sendSkillsIDUseCase: getIt()));
    getIt.registerLazySingleton(
        () => VacancyBloc(getVacancyDetailsUseCase: getIt()));
    getIt.registerLazySingleton(() => ApplyBloc(applyUseCase: getIt()));
    getIt.registerLazySingleton(() =>
        GetInternshipsBySearchBloc(getInternshipsBySearchUseCase: getIt()));
    getIt.registerLazySingleton(
        () => SuggestedJobsBloc(getInternshipsBySearchUseCase: getIt()));
    getIt.registerLazySingleton(() =>
        SuggestedJobsInCompanyBloc(getInternshipsBySearchUseCase: getIt()));
    getIt.registerLazySingleton(() => PdfUploadBloc(getIt()));
    getIt.registerLazySingleton(() => GetPdfBloc(getPDFUseCase: getIt()));
    getIt.registerLazySingleton(() => ResetPasswordFlowBloc(
          resetPasswordUseCase: getIt(),
          sendCodeUseCase: getIt(),
          verifyCodeUseCase: getIt(),
        ));

    getIt.registerLazySingleton(
            () => ChangePasswordFlowBloc(changePasswordUseCase: getIt()));

//use_case
    getIt.registerFactory(
        () => GetMyProfileDataUseCase(baseRepositoryProfile: getIt()));
    getIt.registerFactory(
            () => ChangePasswordUseCase(baseRepository: getIt()));
    getIt.registerFactory(() => ResetPasswordUseCase(baseRepository: getIt()));
    getIt.registerFactory(() => SendCodeUseCase(baseRepository: getIt()));
    getIt.registerFactory(() => VerifyCodeUseCase(baseRepository: getIt()));
    getIt.registerFactory(
        () => EditPersonalInfoUseCase(baseRepositoryProfile: getIt()));
    getIt.registerFactory(
        () => GetCompaniesUseCase(baseRepositoryHome: getIt()));
    getIt.registerFactory(
        () => LoginWithEmailAndPasswordUseCase(baseRepository: getIt()));
    getIt.registerFactory(() => SignInWithGoogleUC(baseRepository: getIt()));
    getIt.registerFactory(() => SignInWithAppleUC(baseRepository: getIt()));
    getIt.registerFactory(
        () => GetMyApplicationsUseCase(baseRepositoryHome: getIt()));
    getIt.registerFactory(
        () => SignUpWithEmailAndPasswordUseCase(baseRepository: getIt()));
    getIt.registerFactory(() => GetCitiesUseCase(baseRepositoryHome: getIt()));
    getIt.registerFactory(() => GetFacultyUseCase(baseRepositoryHome: getIt()));
    getIt.registerFactory(
        () => GetUniversityUseCase(baseRepositoryHome: getIt()));
    getIt.registerFactory(() => GetMajorUseCase(baseRepositoryHome: getIt()));
    getIt
        .registerFactory(() => GetMatchedJobsCase(baseRepositoryHome: getIt()));
    getIt.registerFactory(
        () => GetMyDataUseCase(baseRepositoryProfile: getIt()));
    getIt
        .registerFactory(() => AddPersonalInfoUseCase(baseRepository: getIt()));
    getIt.registerFactory(
        () => SendExperienceLevelUseCase(baseRepository: getIt()));
    getIt.registerFactory(
        () => SendUniversityFacultyIdsUseCase(baseRepository: getIt()));
    getIt.registerFactory(
        () => SendLocationTypeUseCase(baseRepository: getIt()));
    getIt.registerFactory(() => SendMajorIDUseCase(baseRepository: getIt()));
    getIt.registerFactory(() => GetSkillsUseCase(baseRepositoryHome: getIt()));
    getIt.registerFactory(() => SendSkillsIDUseCase(baseRepository: getIt()));
    getIt.registerFactory(
        () => CompleteProfileUseCase(baseRepositoryProfile: getIt()));
    getIt.registerFactory(
        () => GetVacancyDetailsUseCase(baseRepositoryHome: getIt()));
    getIt.registerFactory(() => ApplyUseCase(baseRepositoryJobs: getIt()));
    getIt.registerFactory(
        () => GetInternshipsBySearchUseCase(baseRepositoryHome: getIt()));
    getIt.registerFactory(() => GetAreaUseCase(baseRepositoryHome: getIt()));
    getIt.registerFactory(
        () => UploadPDFUseCase(baseRepositoryProfile: getIt()));
    getIt.registerFactory(() => GetPDFUseCase(baseRepositoryProfile: getIt()));

    //remote data
    getIt.registerLazySingleton<BaseRemotelyDataSource>(
        () => AuthRemotelyDateSource());
    getIt.registerLazySingleton<BaseRemotelyDataSourceHome>(
        () => HomeRemotelyDateSource());
    getIt.registerLazySingleton<BaseRemotelyDataSourceProfile>(
        () => ProfileRemotelyDateSource());

//repo
    getIt.registerLazySingleton<BaseRepository>(
        () => RepositoryImp(baseRemotelyDataSource: getIt()));
    getIt.registerLazySingleton<BaseRepositoryHome>(
        () => HomeRepositoryImp(baseRemotelyDataSourceHome: getIt()));
    getIt.registerLazySingleton<BaseRepositoryProfile>(
        () => ProfileRepositoryImp(baseRemotelyDataSourceProfile: getIt()));
    getIt.registerLazySingleton(() => NavigationService());
  }
}
