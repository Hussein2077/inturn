import 'dart:async';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/empty_widget.dart';
import 'package:inturn/core/widgets/loading_widget.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/features/home/presentation/controller/top_five_and_blogs/get_top_five_bloc.dart';
import 'package:inturn/features/home/presentation/controller/top_five_and_blogs/get_top_five_event.dart';
import 'package:inturn/features/home/presentation/controller/top_five_and_blogs/get_top_five_state.dart';
import 'package:inturn/features/home/presentation/widgets/job_cart.dart';
import 'package:inturn/features/home/presentation/widgets/top_container.dart';
import 'package:inturn/features/main_screen.dart';
import 'package:inturn/main.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.onPressedIntern, this.onPressedJob, required this.userID});
final String userID;
  final void Function()? onPressedJob;
  final void Function()? onPressedIntern;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
  // static int refreshNum = 10; // number that changes when refreshed

  final _refreshIndicatorKey = GlobalKey<LiquidPullToRefreshState>();

  Future<void> _handleRefresh() async {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(milliseconds: 600), () {
      completer.complete();
    });

    // setState(() {
    //   refreshNum = Random().nextInt(13);
    // });
    return completer.future.then<void>((_) {
      BlocProvider.of<HomeBloc>(context).add(GeMatchedVacancyEvent(widget.userID));

    });
  }
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(GeMatchedVacancyEvent(widget.userID));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        showChildOpacityTransition: false,
        backgroundColor: AppColors.secondaryColor,
        color: AppColors.primaryColor,
        onRefresh: _handleRefresh,
        child: SingleChildScrollView(
          child: Column(children: [
            const TopContainer(),
            SizedBox(
              height: AppSize.defaultSize! * 3,
            ),
            CustomText(
              text: StringManager.matchedJobs.tr(),
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColor,
              // textAlign: TextAlign.start,
              fontSize: AppSize.defaultSize! * 1.6,
            ),
            SizedBox(
              height: AppSize.defaultSize!,
            ),
            SizedBox(
              width: AppSize.defaultSize! * 28,
              child: CustomText(
                text: StringManager.unmatchedVacancies.tr(),
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: AppSize.defaultSize! * 1.4,
                maxLines: 2,
              ),
            ),
            SizedBox(
              height: AppSize.defaultSize!,
            ),
            MainButton(
              text: StringManager.changeWorkPreferences.tr(),
              onTap: () {
                MainScreen.mainIndex = 3;
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen:   MainScreen(userID: MyApp.userId,),
                  withNavBar: false,
                  // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                );
              },
              color: AppColors.lightGreyColor,
              textColor: AppColors.primaryColor,
            ),
            BlocBuilder<HomeBloc, HomeState >(
              builder: (context, state) {
                if(state is GetMatchedVacancyLoadingState){
                  return const LoadingWidget() ;
                }
                else if(state is GetMatchedVacancySuccessMessageState){
                  print('${ state.vacancyModel[3].matchedVacancy.description}sdgwrwr');
                  if(state.vacancyModel.isEmpty){
                    return const EmptyWidget();
                  }
                  return ListView.builder(
                      itemCount: state.vacancyModel.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (item, index) {

                        return Padding(
                          padding: EdgeInsets.all(AppSize.defaultSize! * 1.2),
                          child:   JobCart(vacancyModel: state.vacancyModel[index],).animate()
                              .fadeIn() // uses `Animate.defaultDuration`
                              .scale() // inherits duration from fadeIn
                              .move(delay: 300.ms, duration: 600.ms),
                        );
                      });
                }
                else if(state is GetMatchedVacancyErrorMessageState){
                  return ErrorWidget(  state.errorMessage);
                }
                else {
                  return const SizedBox();
                }
              },
            ),
            SizedBox(
              height: AppSize.defaultSize!,
            ),
          ]),
        ),
      ),
    );
  }
}
