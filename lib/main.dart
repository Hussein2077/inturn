import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/service/navigator_services.dart';
import 'package:inturn/core/service/service_locator.dart';
import 'package:inturn/core/translations/translations.dart';
import 'package:inturn/core/utils/methods.dart';
import 'package:inturn/features/auth/presentation/controller/add_info_bloc/add_info_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/add_skill/bloc.dart';
import 'package:inturn/features/auth/presentation/controller/login_bloc/login_with_email_and_password_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/sign_in_with_platform_bloc/sign_in_with_platform_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/sign_up_bloc/sign_up_with_email_and_password_bloc.dart';
import 'package:inturn/features/home/presentation/controller/apply_bloc/get_jobs_bloc.dart';
import 'package:inturn/features/home/presentation/controller/company_bloc/get_companies_bloc.dart';
import 'package:inturn/features/home/presentation/controller/company_bloc/get_companies_event.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_bloc.dart';
import 'package:inturn/features/home/presentation/controller/get_cities_major_universtity/get_options_events.dart';
import 'package:inturn/features/home/presentation/controller/get_major/bloc.dart';
import 'package:inturn/features/home/presentation/controller/get_major/event.dart';
import 'package:inturn/features/home/presentation/controller/get_my_applications/get_my_applications_bloc.dart';
import 'package:inturn/features/home/presentation/controller/intern_search_bloc/get_internships_search_bloc.dart';
import 'package:inturn/features/home/presentation/controller/top_five_and_blogs/get_top_five_bloc.dart';
import 'package:inturn/features/home/presentation/controller/top_five_and_blogs/get_top_five_event.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:inturn/features/home/presentation/controller/vacancy_details_bloc/bloc.dart';
import 'package:inturn/features/profile/presentation/controller/edit_profile/edit_profile_bloc.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_data/get_my_data_bloc.dart';
import 'package:inturn/features/profile/presentation/controller/get_my_profile_data/get_my_profile_data_bloc.dart';
import 'package:inturn/firebase_options.dart';

String? token;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding:  WidgetsFlutterBinding.ensureInitialized());

  await ServerLocator().init();
  await EasyLocalization.ensureInitialized();
  token = await Methods.instance.returnUserToken();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,

      );
  FlutterNativeSplash.remove();

  runApp(EasyLocalization(
      fallbackLocale: const Locale('en'),
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      assetLoader: CodegenLoader(),
      path: 'lib/core/translations/',
      saveLocale: true,
      child: Builder(builder: (context) {
        return const MyApp();
      })));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
static String userId = '0';
static int userProfileId = 0;
  static bool fromLogin=false;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      MyApp.  userId = await Methods.instance.returnUserId();
      MyApp.userProfileId = await Methods.instance.returnProfileId();
      print('user id ${MyApp.userId}');
      print('user profile id ${MyApp.userProfileId}');
    });
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<LoginWithEmailAndPasswordBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<SignUpWithEmailAndPasswordBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<GetMyApplicationsBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<SignInWithPlatformBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<OptionsBloc>()
            // ..add(const GetMajorEvent())
            ..add(const GetUniversityEvent())
            ..add(const GetSkillsEvent())
          ,
        ),
        BlocProvider(
            create: (context) => getIt<HomeBloc>()),
        BlocProvider(
            create: (context) => getIt<GetMajorBloc>()..add(GetMajorEvent())),
        BlocProvider(
          create: (context) => getIt<GetMyApplicationsBloc>(),
        ),  BlocProvider(
          create: (context) => getIt<GetMyDataBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<AddPersonalInfoBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<GetCompaniesBloc>()..add(GetCompaniesEvent()),
        ),
        BlocProvider(
          create: (context) => getIt<EditProfileBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<GetMyProfileDataBloc>(),
        ),  BlocProvider(
          create: (context) => getIt<AddSkillsBloc>(),
        ), BlocProvider(
          create: (context) => getIt<VacancyBloc>(),
        ),BlocProvider(
          create: (context) => getIt<ApplyBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<GetInternshipsBySearchBloc>()),

      ],
      child: MaterialApp(
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        navigatorKey: getIt<NavigationService>().navigatorKey,
        builder: EasyLoading.init(),
        initialRoute: Routes.splash,
            // token == null || token == 'noToken' ? Routes.login : Routes.main,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            scaffoldBackgroundColor: const Color.fromRGBO(250, 250, 250, 1)),
      ),
    );
  }
}
