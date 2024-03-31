import 'dart:async';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/service/navigator_services.dart';
import 'package:inturn/core/service/service_locator.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/area_drop_down.dart';
import 'package:inturn/core/widgets/custom_text_field.dart';
import 'package:inturn/core/widgets/empty_widget.dart';
import 'package:inturn/core/widgets/jobs_and_intern_card.dart';
import 'package:inturn/core/widgets/loading_widget.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/major_drop_down.dart';
import 'package:inturn/core/widgets/vacancy_details.dart';
import 'package:inturn/features/internships/presentation/controller/get_internships/get_internships_bloc.dart';
import 'package:inturn/features/internships/presentation/controller/get_internships/get_internships_event.dart';
import 'package:inturn/features/internships/presentation/controller/intern_search_bloc/get_internships_search_bloc.dart';
import 'package:inturn/features/internships/presentation/controller/intern_search_bloc/get_internships_search_event.dart';
import 'package:inturn/features/internships/presentation/controller/intern_search_bloc/get_internships_search_state.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class InternshipScreen extends StatefulWidget {
  const InternshipScreen({super.key});

  @override
  State<InternshipScreen> createState() => _InternshipScreenState();
}

class _InternshipScreenState extends State<InternshipScreen> {
  late TextEditingController searchController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static int refreshNum = 10; // number that changes when refreshed

  final _refreshIndicatorKey = GlobalKey<LiquidPullToRefreshState>();

  Future<void> _handleRefresh() async {
    BlocProvider.of<GetInternshipsBySearchBloc>(
        getIt<NavigationService>().navigatorKey.currentContext!)
        .add(GetInternshipsBySearchEvent());
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(milliseconds: 1500), () {
      completer.complete();
    });


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
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context, text: StringManager.internships.tr()),
      body: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        showChildOpacityTransition: false,
        child: SizedBox(
          height: AppSize.screenHeight,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(AppSize.defaultSize! * 2),
              child: Column(
                children: [
                  SizedBox(
                      height: AppSize.defaultSize! * 4,
                      child: CustomTextField(
                        controller: searchController,
                        hintText: StringManager.whatAreYouLookingFor.tr(),
                        hintStyle: TextStyle(
                          fontSize: AppSize.defaultSize! * 1.3,
                        ),
                      )),
                  SizedBox(
                    height: AppSize.defaultSize!,
                  ),
                  const CitiesDropDown(),
                  SizedBox(
                    height: AppSize.defaultSize!,
                  ),
                  const MajorDropDown(),
                  SizedBox(
                    height: AppSize.defaultSize! * 2,
                  ),
                  MainButton(
                    text: StringManager.search.tr(),
                    onTap: () {
                      BlocProvider.of<GetInternshipsBySearchBloc>(context)
                          .add(GetInternshipsBySearchEvent(
                        type: 2,
                      ));
                    },
                  ),
                  SizedBox(
                    height: AppSize.defaultSize! * 4,
                  ),
                  BlocBuilder<GetInternshipsBySearchBloc,
                      GetInternshipsBySearchState>(builder: (context, state) {
                    if (state is GetInternshipsBySearchSuccessMessageState) {
                      return state.internModel.isEmpty
                          ? const EmptyWidget()
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: state.internModel.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      EdgeInsets.all(AppSize.defaultSize! * .5),
                                  child: InkWell(
                                    onTap: () {
                                      PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: VacancyDetails(
                                            vacancyModel:
                                                state.internModel[index]),
                                        withNavBar: false,
                                        // OPTIONAL VALUE. True by default.
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.fade,
                                      );
                                    },
                                    child: JobsAndInternCard(
                                      vacancyModel: state.internModel[index],
                                    )
                                        .animate()
                                        .fadeIn() // uses `Animate.defaultDuration`
                                        .scale() // inherits duration from fadeIn
                                        .move(delay: 300.ms, duration: 600.ms),
                                  )
                                  // runs after the above w/new duration
                                  ,
                                );
                              });
                    } else if (state
                        is GetInternshipsBySearchErrorMessageState) {
                      return ErrorWidget(state.errorMessage);
                    } else if (state is GetInternshipsBySearchLoadingState) {
                      return const LoadingWidget();
                    } else {
                      return const SizedBox();
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
