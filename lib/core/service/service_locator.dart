import 'package:get_it/get_it.dart';
import 'package:inturn/core/service/navigator_services.dart';
import 'package:inturn/features/auth/data/auth_remote_data_source.dart';
import 'package:inturn/features/auth/data/repo_imp.dart';
import 'package:inturn/features/auth/domain/repo/base_repo.dart';
import 'package:inturn/features/auth/domain/use_case/google_sign.dart';
import 'package:inturn/features/auth/domain/use_case/login_with_email_and_password_use_case.dart';
import 'package:inturn/features/auth/domain/use_case/sign_up_use_case.dart';
import 'package:inturn/features/auth/presentation/controller/login_bloc/login_with_email_and_password_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/sign_in_with_platform_bloc/sign_in_with_platform_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/sign_up_bloc/sign_up_with_email_and_password_bloc.dart';
import 'package:inturn/features/home/data/data%20source/home_remote_data_source.dart';
import 'package:inturn/features/home/data/repo%20imp/repo_imp.dart';
import 'package:inturn/features/home/domain/repo/jobs_base_repo.dart';
import 'package:inturn/features/home/domain/use_case/get_cities.dart';
import 'package:inturn/features/home/domain/use_case/get_major_uc.dart';
import 'package:inturn/features/home/domain/use_case/get_university_uc.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_bloc.dart';
import 'package:inturn/features/internships/data/data%20source/internships_remote_data_source.dart';
import 'package:inturn/features/internships/data/repo%20imp/repo_imp.dart';
import 'package:inturn/features/internships/domain/repo/jobs_base_repo.dart';
import 'package:inturn/features/internships/domain/use_case/get_intern.dart';
import 'package:inturn/features/internships/domain/use_case/intern_search_uc.dart';
import 'package:inturn/features/internships/presentation/controller/get_internships/get_internships_bloc.dart';
import 'package:inturn/features/internships/presentation/controller/intern_search_bloc/get_internships_search_bloc.dart';
import 'package:inturn/features/jobs/data/data%20source/jobs_remote_data_source.dart';
import 'package:inturn/features/jobs/data/repo%20imp/repo_imp.dart';
import 'package:inturn/features/jobs/domain/repo/jobs_base_repo.dart';
import 'package:inturn/features/jobs/domain/use_case/get_jobs.dart';
import 'package:inturn/features/jobs/presentation/controller/get_jobs/get_jobs_bloc.dart';
import 'package:inturn/features/profile/data/data%20source/profile_remote_data_source.dart';
import 'package:inturn/features/profile/data/repo%20imp/repo_imp.dart';
import 'package:inturn/features/profile/domain/repo/profile_base_repo.dart';
import 'package:inturn/features/profile/domain/use_case/my_applications_us.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_applications/get_my_applications_bloc.dart';

final getIt = GetIt.instance;

class ServerLocator {
  Future<void> init() async {
    //bloc

    getIt.registerLazySingleton(() => LoginWithEmailAndPasswordBloc(
        loginWithEmailAndPasswordUseCase: getIt()));
    getIt.registerLazySingleton(
        () => SignInWithPlatformBloc(signInWithGoogleUC: getIt()));
    getIt.registerLazySingleton(() => SignUpWithEmailAndPasswordBloc(
          signUpWithEmailAndPasswordUseCase: getIt(),
        ));
    getIt.registerLazySingleton(() => GetJobsBloc(getJobsUseCase: getIt()));
    getIt.registerLazySingleton(
        () => GetInternshipsBloc(getInternshipsUseCase: getIt()));
    getIt.registerLazySingleton(
        () => GetMyApplicationsBloc(getMyApplicationsUseCase: getIt()));
    getIt.registerLazySingleton(() =>
        GetInternshipsBySearchBloc(getInternshipsBySearchUseCase: getIt()));
    getIt.registerLazySingleton(() => OptionsBloc(
          getCitiesUseCase: getIt(),
          getMajorUseCase: getIt(),
          getUniversityUseCase: getIt(),
        ));

//use_case
    getIt.registerFactory(
        () => LoginWithEmailAndPasswordUseCase(baseRepository: getIt()));
    getIt.registerFactory(() => SignInWithGoogleUC(baseRepository: getIt()));
    getIt.registerFactory(
        () => GetMyApplicationsUseCase(baseRepositoryProfile: getIt()));
    getIt.registerFactory(
        () => SignUpWithEmailAndPasswordUseCase(baseRepository: getIt()));
    getIt.registerFactory(() => GetJobsUseCase(baseRepositoryJobs: getIt()));
    getIt.registerFactory(
        () => GetInternshipsUseCase(baseRepositoryInternships: getIt()));
    getIt.registerFactory(() =>
        GetInternshipsBySearchUseCase(baseRepositoryInternships: getIt()));

    getIt.registerFactory(() => GetCitiesUseCase(baseRepositoryHome: getIt()));
    getIt.registerFactory(() => GetMajorUseCase(baseRepositoryHome: getIt()));
    getIt.registerFactory(
        () => GetUniversityUseCase(baseRepositoryHome: getIt()));
    //remote data
    getIt.registerLazySingleton<BaseRemotelyDataSource>(
        () => AuthRemotelyDateSource());
    getIt.registerLazySingleton<BaseRemotelyDataSourceJobs>(
        () => JobsRemotelyDateSource());
    getIt.registerLazySingleton<BaseRemotelyDataSourceInternships>(
        () => InternshipsRemotelyDateSource());
    getIt.registerLazySingleton<BaseRemotelyDataSourceHome>(
        () => HomeRemotelyDateSource());
    getIt.registerLazySingleton<BaseRemotelyDataSourceProfile>(
        () => ProfileRemotelyDateSource());
//repo
    getIt.registerLazySingleton<BaseRepository>(
        () => RepositoryImp(baseRemotelyDataSource: getIt()));
    getIt.registerLazySingleton<BaseRepositoryJobs>(
        () => JobsRepositoryImp(baseRemotelyDataSourceJobs: getIt()));
    getIt.registerLazySingleton<BaseRepositoryInternships>(() =>
        InternshipsRepositoryImp(baseRemotelyDataSourceInternships: getIt()));
    getIt.registerLazySingleton<BaseRepositoryHome>(
        () => HomeRepositoryImp(baseRemotelyDataSourceHome: getIt()));
    getIt.registerLazySingleton<BaseRepositoryProfile>(
        () => ProfileRepositoryImp(baseRemotelyDataSourceProfile: getIt()));
    getIt.registerLazySingleton(() => NavigationService());
  }
}
