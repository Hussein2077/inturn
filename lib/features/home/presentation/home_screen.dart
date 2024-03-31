import 'dart:async';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/service/navigator_services.dart';
import 'package:inturn/core/service/service_locator.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/loading_widget.dart';
import 'package:inturn/features/home/presentation/widgets/home_buttons.dart';
import 'package:inturn/features/home/presentation/widgets/job_carousel.dart';
import 'package:inturn/features/internships/presentation/controller/get_internships/get_internships_bloc.dart';
import 'package:inturn/features/internships/presentation/controller/get_internships/get_internships_event.dart';
import 'package:inturn/features/internships/presentation/controller/intern_search_bloc/get_internships_search_bloc.dart';
import 'package:inturn/features/internships/presentation/controller/intern_search_bloc/get_internships_search_state.dart';
import 'package:inturn/features/jobs/presentation/controller/get_jobs/get_jobs_bloc.dart';
import 'package:inturn/features/jobs/presentation/controller/get_jobs/get_jobs_event.dart';
import 'package:inturn/features/jobs/presentation/controller/get_jobs/get_jobs_state.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.onPressedIntern, this.onPressedJob});

  final void Function()? onPressedJob;
  final void Function()? onPressedIntern;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static int refreshNum = 10; // number that changes when refreshed

  final _refreshIndicatorKey = GlobalKey<LiquidPullToRefreshState>();

  Future<void> _handleRefresh() async {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(milliseconds: 1500), () {
      completer.complete();
    });
    BlocProvider.of<GetInternshipsBloc>(
        getIt<NavigationService>().navigatorKey.currentContext!)
        .add(GetInternshipsEvent());
    BlocProvider.of<GetJobsBloc>(context).add(GetJobsEvent());

    setState(() {
      refreshNum = Random().nextInt(13);
    });
    return completer.future.then<void>((_) {
      ScaffoldMessenger.of(
          getIt<NavigationService>().navigatorKey.currentContext!)
          .showSnackBar(
        SnackBar(
          content: const Text('Refresh complete'),
          action: SnackBarAction(
            label: 'RETRY',
            onPressed: () {
              _refreshIndicatorKey.currentState!.show();
            },
          ),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(
        context,
        widget: CustomText(
          text: 'INTRN',
          fontSize: AppSize.defaultSize! * 3,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        child: Column(
          children: [
            BlocBuilder<GetJobsBloc, GetJobsState>(
              builder: (context, state) {
                if (state is GetJobsSuccessMessageState) {
                  return CarouselWithIndicatorDemo(
                    jobSlider: state.jobModel,
                  );
                } else if (state is GetJobsErrorMessageState) {
                  return ErrorWidget(state.errorMessage);
                } else if (state is GetJobsLoadingState) {
                  return const SizedBox();
                } else {
                  return const SizedBox();
                }
              },
            ).animate().fade().scale(),
            BlocBuilder<GetInternshipsBySearchBloc, GetInternshipsBySearchState>(
              builder: (context, state) {
                if (state is GetInternshipsBySearchSuccessMessageState) {
                  return CarouselWithIndicatorDemo(
                    jobSlider: state.internModel,
                  );
                } else if (state is GetInternshipsBySearchErrorMessageState) {
                  return ErrorWidget(state.errorMessage);
                } else if (state is GetInternshipsBySearchLoadingState) {
                  return const LoadingWidget();
                } else {
                  return const SizedBox();
                }
              },
            ).animate().fade().scale(),
            // const TakeQuiz(),
            HomePageButtons(
              text: StringManager.jobs.tr(),
              onPressed: widget.onPressedJob,
            ).animate().fade().scale(),
            HomePageButtons(
                    text: StringManager.internships.tr(),
                    onPressed: widget.onPressedIntern)
                .animate()
                .fade()
                .scale(),
          ],
        ),
      ),
    );
  }
}
