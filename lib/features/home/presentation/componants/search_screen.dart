import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/area_drop_down.dart';
import 'package:inturn/core/widgets/custom_text_field.dart';
import 'package:inturn/core/widgets/loading_widget.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/features/home/data/model/matched_model.dart';
import 'package:inturn/features/home/presentation/componants/filters_screen.dart';
import 'package:inturn/features/home/presentation/controller/intern_search_bloc/get_internships_search_bloc.dart';
import 'package:inturn/features/home/presentation/controller/intern_search_bloc/get_internships_search_event.dart';
import 'package:inturn/features/home/presentation/controller/intern_search_bloc/get_internships_search_state.dart';
import 'package:inturn/features/home/presentation/widgets/job_cart.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<GetInternshipsBySearchBloc>(context)
        .add(GetInternshipsBySearchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context, text: StringManager.searchResults.tr()),
      body: Padding(
        padding: EdgeInsets.all(AppSize.defaultSize! * 2),
        child: Column(
          children: [
            Center(
              child: CustomTextField(
                controller: searchController,
                onChanged: (value) {
                  Future.delayed(const Duration(milliseconds: 500), () {
                    BlocProvider.of<GetInternshipsBySearchBloc>(context)
                        .add(GetInternshipsBySearchEvent(title: value));
                  });
                },
                hintText: StringManager.searchForJobs.tr(),
                fillColor: Colors.white,
                hintStyle: TextStyle(
                    fontSize: AppSize.defaultSize! * 1.3,
                    color: AppColors.greyColor),
                suffixIcon: MainButton(
                  text: StringManager.search.tr(),
                  width: AppSize.defaultSize! * 10,
                  padding: AppSize.defaultSize! * .5,
                  onTap: () {
                    BlocProvider.of<GetInternshipsBySearchBloc>(context)
                        .add(GetInternshipsBySearchEvent(
                      title: searchController.text,
                      vacancyLevelId: FiltersScreen.careerLevel,
                      cityId: CitiesDropDown.selectedValue2?.cityId,
                      countryId: CitiesDropDown.selectedValue?.countryId??1,
                    ));
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppSize.defaultSize! * 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "47 ${StringManager.jobFound.tr()}",
                    style: TextStyle(
                      fontSize: AppSize.defaultSize! * 1.8,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const FiltersScreen(),
                        withNavBar: false,
                        // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCDEE3),
                        borderRadius:
                            BorderRadius.circular(AppSize.defaultSize! * 1.5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppSize.defaultSize! * 2.5,
                            vertical: AppSize.defaultSize! * 1),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.filter_list_outlined,
                              color: AppColors.blackColor,
                            ),
                            SizedBox(
                              width: AppSize.defaultSize! * 1,
                            ),
                            Text(
                              StringManager.filter.tr(),
                              style: TextStyle(
                                fontSize: AppSize.defaultSize! * 1.8,
                                color: AppColors.blackColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<GetInternshipsBySearchBloc,
                GetInternshipsBySearchState>(
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
                                companyId: state.vacancyModel[index].companyId,
                                company: state.vacancyModel[index].company,
                                cityName: state.vacancyModel[index].cityName,
                                vacancyLevelId:
                                    state.vacancyModel[index].vacancyLevelId,
                                requirements:
                                    state.vacancyModel[index].requirements,
                                responsibilities:
                                    state.vacancyModel[index].responsibilities,
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
            SizedBox(
              height: AppSize.defaultSize!,
            ),
          ],
        ),
      ),
    );
  }
}
