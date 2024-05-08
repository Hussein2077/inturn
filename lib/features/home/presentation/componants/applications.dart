import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/loading_widget.dart';
import 'package:inturn/features/home/data/model/matched_model.dart';
import 'package:inturn/features/home/presentation/controller/get_my_applications/get_my_applications_bloc.dart';
import 'package:inturn/features/home/presentation/controller/get_my_applications/get_my_applications_state.dart';
import 'package:inturn/features/home/presentation/controller/intern_search_bloc/get_internships_search_bloc.dart';
import 'package:inturn/features/home/presentation/controller/intern_search_bloc/get_internships_search_event.dart';
import 'package:inturn/features/home/presentation/controller/intern_search_bloc/get_internships_search_state.dart';
import 'package:inturn/features/home/presentation/widgets/job_cart.dart';
import 'package:inturn/main.dart';

class ApplicationsScreen extends StatefulWidget {
  const ApplicationsScreen({super.key});

  @override
  State<ApplicationsScreen> createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> {
  @override
  void initState() {
    BlocProvider.of<GetInternshipsBySearchBloc>(context)
        .add(GetInternshipsBySearchEvent(userId: MyApp.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context,
          text: StringManager.applications.tr(), leading: false),
      body: Column(children: [
        BlocBuilder<GetInternshipsBySearchBloc, GetInternshipsBySearchState>(
          builder: (context, state) {
            if (state is GetInternshipsBySearchLoadingState) {
              return const LoadingWidget();
            } else if (state is GetInternshipsBySearchSuccessMessageState) {
              return ListView.builder(
                  itemCount: state.vacancyModel.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (item, index) {
                    return Padding(
                      padding: EdgeInsets.all(AppSize.defaultSize! * 1.2),
                      child: JobCart(
                        vacancyModel: MatchedVacancyWrapper(
                          matchedVacancy: MatchedVacancy(
                            vacancyId: state.vacancyModel[index].vacancyId!,
                            title: state.vacancyModel[index].title!,
                            companyId: state.vacancyModel[index].companyId!,
                            company: state.vacancyModel[index].company!,
                            cityName: state.vacancyModel[index].cityName!,
                            vacancyLevelId:
                                state.vacancyModel[index].vacancyLevelId!,
                            requirements:
                                state.vacancyModel[index].requirements!,
                            responsibilities:
                                state.vacancyModel[index].responsibilities!,
                          ),
                          matchmakingPercentage: '',
                        ),
                      )
                          .animate()
                          .fadeIn() // uses `Animate.defaultDuration`
                          .scale() // inherits duration from fadeIn
                          .move(delay: 300.ms, duration: 600.ms),
                    );
                  });
            } else if (state is GetInternshipsBySearchErrorMessageState) {
              return ErrorWidget(state.errorMessage);
            } else {
              return const SizedBox();
            }
          },
        ),
        // BlocBuilder<GetMyApplicationsBloc, GetMyApplicationsState>(
        //   builder: (context, state) {
        //     if (state is GetMyApplicationsSuccessMessageState) {
        //       return Expanded(
        //         child: ListView.builder(
        //             itemCount: 10,
        //             shrinkWrap: true,
        //             physics: const BouncingScrollPhysics(),
        //             itemBuilder: (item, index) {
        //               return Padding(
        //                 padding: EdgeInsets.all(AppSize.defaultSize! * 1.2),
        //                 child: JobCart(
        //                   linearCircle: false,
        //                   vacancyModel: VacancyModel()as MatchedVacancyWrapper,
        //                 )
        //                     .animate()
        //                     .fadeIn() // uses `Animate.defaultDuration`
        //                     .scale() // inherits duration from fadeIn
        //                     .move(delay: 300.ms, duration: 600.ms),
        //               );
        //             }),
        //       );
        //     } else if (state is GetMyApplicationsErrorMessageState) {
        //       return ErrorWidget(state.errorMessage);
        //     } else if (state is GetMyApplicationsLoadingState) {
        //       return const LoadingWidget();
        //     } else {
        //       return const SizedBox();
        //     }
        //   },
        // ),
      ]),
    );
  }
}
