import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/empty_widget.dart';
import 'package:inturn/core/widgets/loading_widget.dart';
import 'package:inturn/features/home/data/model/matched_model.dart';
import 'package:inturn/features/home/presentation/controller/get_my_applications/get_my_applications_bloc.dart';
import 'package:inturn/features/home/presentation/controller/get_my_applications/get_my_applications_event.dart';
import 'package:inturn/features/home/presentation/controller/get_my_applications/get_my_applications_state.dart';
import 'package:inturn/features/home/presentation/controller/intern_search_bloc/get_internships_search_bloc.dart';
import 'package:inturn/features/home/presentation/controller/intern_search_bloc/get_internships_search_event.dart';
import 'package:inturn/features/home/presentation/controller/intern_search_bloc/get_internships_search_state.dart';
import 'package:inturn/features/home/presentation/widgets/job_cart.dart';
import 'package:inturn/main.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class ApplicationsScreen extends StatefulWidget {
  const ApplicationsScreen({super.key});

  @override
  State<ApplicationsScreen> createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> {
  final refreshIndicatorKey = GlobalKey<LiquidPullToRefreshState>();


  Future<void> _handleRefresh() async {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(milliseconds: 600), () {
      completer.complete();
    });

    // setState(() {
    //   refreshNum = Random().nextInt(13);
    // });
    return completer.future.then<void>((_) {
      BlocProvider.of<GetMyApplicationsBloc>(context)
          .add(GetMyApplicationsEvent( MyApp.userId));
    });
  }
  @override
  void initState() {
    BlocProvider.of<GetMyApplicationsBloc>(context)
        .add(GetMyApplicationsEvent( MyApp.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context,
          text: StringManager.applications.tr(), leading: false),
      body: LiquidPullToRefresh(
        key: refreshIndicatorKey,
        showChildOpacityTransition: false,
        backgroundColor: AppColors.secondaryColor,
        color: AppColors.primaryColor,
        onRefresh: _handleRefresh,
        child: SingleChildScrollView(
          child: Column(children: [
            BlocBuilder<GetMyApplicationsBloc, GetMyApplicationsState>(
              builder: (context, state) {
                if (state is GetMyApplicationsLoadingState) {
                  return const LoadingWidget();
                } else if (state is GetMyApplicationsSuccessMessageState) {
                  if(state.jobModel.isEmpty){
                    return const EmptyWidget();
                  }
                  return ListView.builder(
                      itemCount: state.jobModel.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (item, index) {
                        return Padding(
                          padding: EdgeInsets.all(AppSize.defaultSize! * 1.2),
                          child: JobCart(
                        linearCircle: false,
                            applicationStatusId: state.jobModel[index].applicationStatusId!,
                            vacancyModel: MatchedVacancyWrapper(
                              matchedVacancy: MatchedVacancy(
                                vacancyId: state.jobModel[index].vacancyId,
                                title: state.jobModel[index].vacancy?.title,
                                companyId: state.jobModel[index].vacancy?.companyId,
                                company: state.jobModel[index].vacancy?.company,
                                cityName: state.jobModel[index].vacancy?.cityName,
                                vacancyLevelId:
                                    state.jobModel[index].vacancy?.vacancyLevelId,
                                requirements:
                                    state.jobModel[index].vacancy?.requirements,
                                responsibilities:
                                    state.jobModel[index].vacancy?.responsibilities,
                                description: state.jobModel[index].vacancy?.description,
                              ),
                              matchmakingPercentage: 0,
                            ),
                          )
                              .animate()
                              .fadeIn() // uses `Animate.defaultDuration`
                              .scale() // inherits duration from fadeIn
                              .move(delay: 300.ms, duration: 600.ms),
                        );
                      });
                } else if (state is GetMyApplicationsErrorMessageState) {
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
        ),
      ),
    );
  }
}
