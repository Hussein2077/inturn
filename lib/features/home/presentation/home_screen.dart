import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/custom_text_field.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/loading_widget.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/features/auth/presentation/add_info_flow/personal_info.dart';
import 'package:inturn/features/home/presentation/controller/top_five_and_blogs/get_top_five_bloc.dart';
import 'package:inturn/features/home/presentation/controller/top_five_and_blogs/get_top_five_event.dart';
import 'package:inturn/features/home/presentation/controller/top_five_and_blogs/get_top_five_state.dart';
import 'package:inturn/features/home/presentation/widgets/job_cart.dart';
import 'package:inturn/features/home/presentation/widgets/top_container.dart';
import 'package:inturn/features/main_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.onPressedIntern, this.onPressedJob});

  final void Function()? onPressedJob;
  final void Function()? onPressedIntern;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(GeMatchedVacancyEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                screen: const MainScreen(),
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
    );
  }
}
